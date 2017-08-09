//
//  ViewController.swift
//  zly-ofo
//
//  Created by 郑乐银 on 2017/5/18.
//  Copyright © 2017年 郑乐银. All rights reserved.
//

import UIKit
import SWRevealViewController
import FTIndicator

class ViewController: UIViewController ,MAMapViewDelegate,AMapSearchDelegate,AMapNaviWalkManagerDelegate{
    var mapView: MAMapView!
    var search: AMapSearchAPI!
    var  pin  = MyPinAnnotation()
    var pinView :  MAAnnotationView!
    var nearBySerch = true
    var walkManager  : AMapNaviWalkManager!
    var start ,end : CLLocationCoordinate2D!
    
    @IBOutlet weak var panelView: UIView!
     /**点击定位图标*/
    @IBAction func locationBtnTap(_ sender: Any) {
        nearBySerch = true
        searchBikeNearby()
    }
    
    /**搜索周边小黄车请求*/
    func searchBikeNearby() {
        searchCustomLocation(mapView.userLocation.coordinate)
    }
    func searchCustomLocation(_ center: CLLocationCoordinate2D)  {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(center.latitude), longitude: CGFloat(center.longitude))
        request.keywords = "餐馆"
    
        request.radius = 500
        request.requireExtension = true
        search.aMapPOIAroundSearch(request)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MAMapView(frame: view.bounds)
        view.addSubview(mapView)
        mapView.delegate = self
        /**地图缩放*/
        mapView.zoomLevel = 14
        /**地位*/
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
       
        /** 搜索 */
        search = AMapSearchAPI()
        search.delegate = self
        
        walkManager = AMapNaviWalkManager()
        walkManager.delegate = self
        setUI()
        
    }
   // MARK: 设置UI MapVIew
    func setUI () {
        //底部view
        view.bringSubview(toFront: panelView)
        /** 设置navigation */
        self.navigationItem.titleView = UIImageView(image:#imageLiteral(resourceName: "ofoLogo"))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"ofo", style:.plain,target:nil, action:nil)
        
        /**启动的页面*/
        if let revealVC = revealViewController () {
            revealVC.rearViewRevealWidth = 290
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    // MARK: 大头针动画 (有bug---有意见可以联系我共同学习 1502904932@qq.com)
    func pinAnimation() {
        pinView = MAAnnotationView()
        //坠落效果，y轴加位移
        let endFrame = pinView.frame
        
        pinView.frame = endFrame.offsetBy(dx: 0, dy: -15)
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            self.pinView.frame = endFrame
        }, completion: nil)
    }
    // MARK: MAPView Delegate 路线规划
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay is MAPolyline {
            print("大头针不动")
            //导航时候大头针不要动
            pin.isLockedToScreen = false
            //把地图缩放到路线之内
            mapView.visibleMapRect  = overlay.boundingMapRect
            
            let  renderer  =  MAPolylineRenderer(overlay: overlay)
            
            renderer?.lineWidth = 8
            
            renderer?.strokeColor = UIColor.yellow
            
            return renderer
        }
        return nil
    }
    
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        print("点击我")
        start = pin.coordinate;
        end = view.annotation.coordinate
        
        let startPoint = AMapNaviPoint.location(withLatitude: CGFloat(start.latitude), longitude: CGFloat(end.longitude))!
        let endPoint = AMapNaviPoint.location(withLatitude: CGFloat(end.latitude), longitude: CGFloat(end.longitude))!
        
        walkManager.calculateWalkRoute(withStart: [startPoint], end: [endPoint])
    }
    

    func mapView(_ mapView: MAMapView!, didDeselect view: MAAnnotationView!) {
        
        
    }
    /**小黄车图标动画显示*/
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
        let aViews  = views as! [MAAnnotationView]
        
        for aView  in aViews  {
            guard aView.annotation is MAPinAnnotationView else {
                let endFrame = aView.frame
                    aView.frame = endFrame.offsetBy(dx: 0, dy: -15)
                    UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
                    aView.frame = endFrame
                    }, completion: nil)

                continue
            }
            aView.transform = CGAffineTransform(scaleX: 0,y : 0)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
                aView.transform = .identity
            }, completion: nil)
            
        }

    }
   
    /// 用户移动地图的交互
    ///
    /// - Parameter mapView: <#mapView description#>
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        if wasUserAction {
            pin.isLockedToScreen = true
            /*大头针动画**/
           // pinAnimation()
            searchCustomLocation(mapView.centerCoordinate)
            
        }
    }
    /// 地图初始化完成
    /// - Parameter mapView: <#mapView description#>
    func mapInitComplete(_ mapView: MAMapView!) {
        pin = MyPinAnnotation()
        pin.coordinate = mapView.centerCoordinate
        /**屏幕中心坐标*/
        pin.lockedScreenPoint = CGPoint(x: view.bounds.width / 2, y:view.bounds.height/2)
        pin.isLockedToScreen = true
        
        mapView.addAnnotation(pin)
        mapView.showAnnotations([pin], animated: true)
        
        searchBikeNearby()
    }
    
    /// 自定义大头针视图
    ///
    /// - Parameters:
    ///   - mapView: mapView
    ///   - annotation: 标注
    /// - Returns: 大投资视图
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        //用户定义得位置，不需要自定义
        if annotation is MAUserLocation {
            return nil
        }
        /**自定义大头针*/
        if annotation is MyPinAnnotation {
            let reuserid = "anchor"
            
            var zlyAnaotion = mapView.dequeueReusableAnnotationView(withIdentifier: reuserid) as? MAPinAnnotationView
            if zlyAnaotion == nil {
                zlyAnaotion  = MAPinAnnotationView(annotation:annotation, reuseIdentifier:reuserid)
            }
            zlyAnaotion?.image = #imageLiteral(resourceName: "homePage_wholeAnchor")
            zlyAnaotion?.canShowCallout = false
    
            return zlyAnaotion
        }
        
        
        let reseid = "zly"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reseid) as? MAPinAnnotationView
        if annotationView == nil {
            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reseid)
        }
        
        if annotation.title == "正常使用" {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBike")
        }else {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBikeRedPacket")
        }
        annotationView?.canShowCallout  = true
        //annotationView?.animatesDrop = true
        return annotationView!
        
        
    }
    
    
    // MARK: AMapSearchDelegate
    /**搜索周边小黄车以后完成处理*/
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        guard response.count > 0 else {
            print("周边没有小黄车")
            return
        }
        var annotations : [MAPointAnnotation] = []
        
        annotations  = response.pois.map() {
            let annotation = MAPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.location.latitude), longitude: CLLocationDegrees($0.location.longitude))
            if $0.distance < 400 {
                annotation.title = "红包区域开锁任意小黄车"
                annotation.subtitle = "骑行十分钟可获得现金红包"
            }else {
                annotation.title = "正常使用"
            }
            return annotation
        }
        mapView.addAnnotations(annotations)
        
       if nearBySerch {
            mapView.showAnnotations(annotations, animated: true)
            nearBySerch = !nearBySerch
        }
        
    }
    
     // MARK: AMapNaviWalkManagerDelegate 导航代理
    
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
        print("路线规划成功")
        
        mapView.removeOverlays(mapView.overlays)
    
        
        var coordinates = walkManager.naviRoute!.routeCoordinates!.map {
            return CLLocationCoordinate2D(latitude: CLLocationDegrees($0.latitude), longitude:CLLocationDegrees($0.longitude))
        }
        
        let poliyline = MAPolyline(coordinates: &coordinates, count : UInt(coordinates.count))
        mapView.add(poliyline)
        
        //提示用距离＆用时
        let walkMintute = walkManager.naviRoute!.routeTime / 60
        
        var timeDesc = "一分钟以内"
        if walkMintute > 0 {
            timeDesc = walkMintute.description + "分钟"
        }
        
        let hintTitle = "步行" + timeDesc
        
        let hintSubstitute = "距离" + walkManager.naviRoute!.routeLength.description + "米"
        
//        let ac  = UIAlertController(title:hintTitle ,message: hintSubstitute ,preferredStyle: .alert)
//        
//        let action  = UIAlertAction(title: "ok", style:.default, handler: nil )
//        
//         ac.addAction(action)
//        
//        self.present(ac, animated: true, completion: nil)
        
        FTIndicator.setIndicatorStyle(.dark)
        FTIndicator.showNotification(with: #imageLiteral(resourceName: "clock"), title: hintTitle, message: hintSubstitute)
        
        
    }
    
    
     func walkManager(_ walkManager: AMapNaviWalkManager, onCalculateRouteFailure error: Error) {
        print("路线规划失败",error)
    }
    
    
    
    
}




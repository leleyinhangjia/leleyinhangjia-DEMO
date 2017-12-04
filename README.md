# leleyinhangjia-DEMO(***以适配iPhone X和ios11 以后版本***)
## 由于业余时间手敲,难免有bug.请批评指正(喵播--白屏加载慢问题---IJK请更换最新);
## 模仿ios经典项目(ofo,喵播等)+常用第三方类拓展+实际开发中遇到问题(由于近期比较忙于项目开发会持续更新中)...

## zly-ofo (Swift版) (只为学习交流,禁止使用商业用途,本人不承担任何责任)

## Requirements

  - iOS 9+
  - swift 3.0
  -  for zly-ofo
  
## Bike license plate and cipher
   LeadCould 云端 车牌号---密码:

* **code:40000** pass:2573
* **code:40001** pass:7378
* **code:40002** pass:7255
* **code:40003** pass:4628
  
### 请用户自己打开项目(由于Pods过大上传很慢原因)---鼠标点击右键-open with External Edtior ----pod install(pod update)

## 仿照主要是利用地图定位找到周围车辆开锁

1.高德地图框架 你可以直接去申请高德开发者中心申请(http://lbs.amap.com)
##  AMapServices.shared().apiKey = "xxxx"  AMapServices.shared().enableHTTPS = true
2.导入高德相关框架
### pod 'AMap3DMap'
### pod 'AMapSearch'
### pod 'AMapLocation'
### pod 'AMapNavi'

### 主页面----显示周围的车辆和红包范围
![alt-text-1](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/1.png?raw=true "")
```swift
//Implement delegate in your UIViewController
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
```
### 主页面----显示扫码界面
![alt-text-1](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/2.png?raw=true "")
### 主页面----显示车牌输入界面
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/3.png)
### 主页面----显示密码界面
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/6.png)

# 项目二 喵播(OC版)
## (喵播--主要是利用集成ijkplayer视频直播框架,LFLiveKit 后台录制、美颜功能、支持h264、AAC硬编码，动态改变速率，RTMP传输等)
### (Reveal-来查询bug神器,页面展示,2D,3D,UI界面使用框架一目了然(还可以破解别人app): 如何使用请看相关推荐别人博客: http://www.jianshu.com/p/55c91033040c;我有破解版Raveal,想要可以联系我1502904932@qq.com)
### (由于IJKMediaFramework.framework过大没有上传github 通过我的百度云直接下载:https://pan.baidu.com/s/1nuWEw9F  密码:qt6h)
### 直播推流本地服务搭建参考(https://www.cnblogs.com/yajunLi/p/6412821.html)
```bash
$ gem install cocoapods
```

#### Podfile

To integrate SwiftMultiSelect into your Xcode project using CocoaPods, specify it in your `Podfile`:
#### Podfile

To integrate SwiftMultiSelect into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'MiaoBo' do
use_frameworks!
pod 'ReactiveCocoa', '~> 2.5'
pod 'AFNetworking', '~> 3.1.0'
pod 'SDWebImage', '~> 4.0.0'
pod 'MJRefresh', '~> 3.1.12'
pod 'MJExtension', '~> 3.0.13'
pod 'Masonry', '~> 1.0.2'
pod 'MBProgressHUD', '~> 0.9.2'
pod 'BarrageRenderer', '~> 1.9.1'
#pod 'GPUImage', '~> 0.1.7' 由于LFLiveKit里面已经集成了GPUImage
pod 'LFLiveKit', '~> 1.6'
end

```

Then, run the following command:

```bash
$ pod install
```

### 主页面----登录首页
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/miaobo1.png)

Reachability网络监听:
```Object-C
typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWIFI // WIFI
};
// 判断网络类型
+ (NetworkStates)getNetworkStates
{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    // 保存网络状态
    NetworkStates states = NetworkStatesNone;
    for (id child in subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏码
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                   //无网模式
                    states = NetworkStatesNone;
                    break;
                case 1:
                    states = NetworkStates2G;
                    break;
                case 2:
                    states = NetworkStates3G;
                    break;
                case 3:
                    states = NetworkStates4G;
                    break;
                case 5:
                {
                    states = NetworkStatesWIFI;
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return states;
}
```
### 主页面----主播显示界面
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/miaobo2.png)
### 主页面----直播界面
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/miaobo3.png)

粒子运动:
```Object-C
CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
// 发射器在xy平面的中心位置
emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.frame.size.width-50,self.moviePlayer.view.frame.size.height-50);
// 发射器的尺寸大小
emitterLayer.emitterSize = CGSizeMake(20, 20);
// 渲染模式
emitterLayer.renderMode = kCAEmitterLayerUnordered;
// 开启三维效果
//    _emitterLayer.preservesDepth = YES;
NSMutableArray *array = [NSMutableArray array];
// 创建粒子
for (int i = 0; i<10; i++) {
    // 发射单元
    CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
    // 粒子的创建速率，默认为1/s
    stepCell.birthRate = 1;
    // 粒子存活时间
    stepCell.lifetime = arc4random_uniform(4) + 1;
    // 粒子的生存时间容差
    stepCell.lifetimeRange = 1.5;
    // 颜色
    // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
    // 粒子显示的内容
    stepCell.contents = (id)[image CGImage];
    // 粒子的名字
    //            [fire setName:@"step%d", i];
    // 粒子的运动速度
    stepCell.velocity = arc4random_uniform(100) + 100;
    // 粒子速度的容差
    stepCell.velocityRange = 80;
    // 粒子在xy平面的发射角度
    stepCell.emissionLongitude = M_PI+M_PI_2;;
    // 粒子发射角度的容差
    stepCell.emissionRange = M_PI_2/6;
    // 缩放比例
    stepCell.scale = 0.3;
    [array addObject:stepCell];
}

emitterLayer.emitterCells = array;
[self.moviePlayer.view.layer insertSublayer:emitterLayer below:self.catEarView.layer];

```

### 主页面----新加入的主播
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/miaobo4.png)
### 主页面----自己开通主播
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/miaobo5.png)
### 推流界面----推流直播界面
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/WechatIMG2.jpeg)

#第三方拓展--(条件选择器)
## 为什么推荐--自定义强可以根据自己要求随意改动,可变更根据需求
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/select.png)


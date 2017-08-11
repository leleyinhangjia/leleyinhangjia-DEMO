# leleyinhangjia-DEMO
# 由于业余时间手敲,难免有bug.请批评指正;
## 模仿ios经典项目(ofo,喵播等)+常用第三方类拓展+实际开发中遇到问题(由于近期比较忙于项目开发会持续更新中)...

## zly-ofo (Swift版) (只为学习交流,禁止使用商业用途,本人不承担任何责任)
## 输入车牌号 :是通过云存储获取(LeadCould) 如下:车牌号---密码
###        code:40000 pass:2573
###        code:40001 pass:7378
###        code:40002 pass:7255
###        code:40003 pass:4628
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
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/1.png)
### 主页面----显示扫码界面
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/2.png)
### 主页面----显示车牌输入界面
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/3.png)
### 主页面----显示密码界面
![Image text](https://raw.githubusercontent.com/leleyinhangjia/leleyinhangjia-DEMO/master/image/6.png)

# 项目二 喵播(Object-C)
## (喵播--主要是利用集成ijkplayer视频直播框架,LFLiveKit 后台录制、美颜功能、支持h264、AAC硬编码，动态改变速率，RTMP传输等)
### (Reveal-来查询bug神器,页面展示,2D,3D,UI界面使用框架一目了然(还可以破解别人app): 如何使用请看相关推荐别人博客: http://www.jianshu.com/p/55c91033040c;我有破解版Raveal,想要可以联系我1502904932@qq.com)
### (由于IJKMediaFramework.framework过大没有上传github 通过我的百度云直接下载:https://pan.baidu.com/s/1gf1movD 密码:88sa)

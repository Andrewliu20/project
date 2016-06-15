

#ifndef NetInterface_h
#define NetInterface_h


/** 家居接口信息*/


/*
 
    逛街接口
 
    GET 请求
 */
//http://yyjd.xinzhuzhang.com/m/jiaju/subject/list?type=0&appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1463485030.854870&v=1.2.0&ios=9.3.1&sign=ba937ca0a13d84d8a8507213a9a9fcc2


#define Home_URL @"http://yyjd.xinzhuzhang.com/m/jiaju/subject/list?type=0&appid=881376723&channel=AppleStore2&udid=null"



//topList接口是个单独接口,20160520变更
#define toLostURL @"http://www.xinzhuzhang.com/qianghuo/ADServlet?id=260990&appid=881376723&udid=c64d8aac00df48c37b95125ce274166aca16e64b&mac=02:00:00:00:00:00&idfa=518765D5-4E6D-4712-995C-911AC68BE703"

/*
    逛街详细接口
 
    GET 请求
    参数: id   是HOME_URL接口中的subjectid的值 另外对于HOME_URL中还要根据type分别解析数据,因为类型不同,详细中的数据请求的接收数据是不同的,需要分来处理
          page 页数从0开始  当没有下一页上时 字典shopList或者subjectList 中没有数据
 
    注意:id = 7时,字典subjectList中没有数据
 
 */




// type类型是subject
//http://yyjd.xinzhuzhang.com/m/jiaju/subject/detail?id=8&page=0&appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1463488013.791824&v=1.2.0&ios=9.3.1&sign=17b1360b3cee47fbe4f6fcd79219aeab

#define HomeDetailSuject_URL @"http://yyjd.xinzhuzhang.com/m/jiaju/subject/detail?id=%@&page=%@&appid=881376723&channel=AppleStore2&token=&udid=null"

//type类型是shop  小编精选和其他不同,其他的都是一样的

#define HomeDetailShop_URL @"http://yyjd.xinzhuzhang.com/m/jiaju/subject/recommend?id=%@&page=%@&appid=881376723&channel=AppleStore2&token=&udid=null"


//小编精选内容详细 这里的数据请求地址和类型为subject的数据接口一样

//http://yyjd.xinzhuzhang.com/m/jiaju/subject/detail?id=62&page=1&appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1463491597.873642&v=1.2.0&ios=9.3.1&sign=b733194a37405c5895e92f9553178d42



/*
    单个物品页面  GET请求
 
    id 这个id是上个页面中数据中字典goodsList中的id值
 */

//http://yyjd.xinzhuzhang.com/m/jiaju/goods/detail?id=1637856&appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1463492648.511167&v=1.2.0&ios=9.3.1&sign=5df3433f838879d3b1678e3885fb9839

#define GoodURL @"http://yyjd.xinzhuzhang.com/m/jiaju/goods/detail?id=%@&appid=881376723&channel=AppleStore2&token=&udid=nul"

/*
 
    单个物品详情跳转到淘宝的的连接  是在单个页面数据中个字典url
 */


 /*
   店铺信息接口
  page = 0的时候
  http://yyjd.xinzhuzhang.com/m/jiaju/shop/detail?id=4106&sort=0&page=0&catid=&appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1464081277.834157&v=1.2.0&ios=9.3.2&sign=a09a643cc91873c1368bea392417e229
  
  下一页(这里的参数是)
  
  http://yyjd.xinzhuzhang.com/m/jiaju/shop/detail?id=4106&sort=0&page=1&listtime=2016-05-14&catid=&appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1464081785.193708&v=1.2.0&ios=9.3.2&sign=cb86f7a26f96dfcad2166bc2349f8593
  */

#define ShopURL @"http://yyjd.xinzhuzhang.com/m/jiaju/shop/detail?id=%@&sort=0&page=%@&catid=&appid=881376723&channel=AppleStore2&token=&udid="


/***********************/


/*
    捡宝接口
    GET 请求
 
    传入参数
    page  请求的页面数例如 page = 1
 
 */
#define Reduced_URL @"http://yyjd.xinzhuzhang.com/m/qiangbaokuan/channel/list?page=%zd&appid=881376723&channel=AppleStore2&token=&udid=null"


/*
    捡宝中物品查看物品详细接口ReducedGoodURL  GET 请求数据
 
 参数 : id  是捡宝页面单个物品数据中的itemid值
 */


//http://yyjd.xinzhuzhang.com/m/qiangbaokuan/goods/detail?id=337544&appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1463493891.490149&v=1.2.0&ios=9.3.1&sign=05bac96854045ae6e7467efa5aec537b


#define ReducedGoodURL @"http://yyjd.xinzhuzhang.com/m/qiangbaokuan/goods/detail?id=%@&appid=881376723&channel=AppleStore2&token=&udid=null"


/*
    点击图片跳转和去看看跳转要显示的数据是相同的接口
    参数: id
 */

#define GoodDescURL @"http://www.xinzhuzhang.com/qianghuo/ProductServlet?id=%@"

/*
    物品详细中的去领取20优惠券的接口和捡宝页面的领券接口相同
 */


/*
 
    物品详情中的去购买的接口在ReducedGoodURL接口中数据的url连接,请求淘宝的网页,购买物品
 */

/**
 *  领红包接口
    http://www.xinzhuzhang.com/qianghuo/GetHongbaoServlet
 */
#define GetHongBaoURL @"http://www.xinzhuzhang.com/qianghuo/GetHongbaoServlet"

/*
    捡宝页面中的去领券的接口在 捡宝页面数据接口中的config中获取
 
    格式:http://shop.m.taobao.com/shop/coupon.htm?seller_id=2622773190&activity_id=6ad54f6a43af459f83469681cbb5b8a3
 */




/*************************/

/*
 
    关注接口
 
    GET 请求
 */
//http://yyjd.xinzhuzhang.com/m/jiaju/shop/follow/list?appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1463485767.937894&v=1.2.0&ios=9.3.1&sign=62298fc8a22288b963498bdaff7c08df


#define Attention_URL @"http://yyjd.xinzhuzhang.com/m/jiaju/shop/follow/list?appid=881376723&channel=AppleStore2&token=&udid=null"

/*
    关注接口数据是否更新
 */
//http://yyjd.xinzhuzhang.com/m/jiaju/shop/follow/update?appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1463485930.533536&v=1.2.0&ios=9.3.1&sign=a388d65eaa371273f17b34f66f640207

#define AttentionUpdata_URL @"http://yyjd.xinzhuzhang.com/m/jiaju/shop/follow/update?appid=881376723&channel=AppleStore2&token=&udid=null"



/*
    关注里面的店铺信息
 
    参数: id   参数有关注接口的sid的值
 
        sort  0
 
        page
 
    http://yyjd.xinzhuzhang.com/m/jiaju/shop/detail?id=4057&sort=0&page=0&catid=&appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1463570779.301024&v=1.2.0&ios=9.3.1&sign=d619b0222d90c7ee6368831e2f68923f
 */

#define ShopInfoURL @"http://yyjd.xinzhuzhang.com/m/jiaju/shop/detail?id=%@&sort=0&page=%@&catid=&appid=881376723&udid=null"

#define ShopNextInfoURL @"http://yyjd.xinzhuzhang.com/m/jiaju/shop/detail?id=%@&sort=0&page=%@&listtime=%@&catid=&appid=881376723&udid=null"
/*
    物品详情接口和ReducedGoodURL接口一样
 
    进入店铺查看详情:是ReducedGoodURL接口中url ,跳入淘宝页面
 */

/**
 *  分类的接口
 *
 */

/*
 
    分类页面接口(77-132)其中131不可用
    GET 请求数据
    该出的数据是请求的图片
    图片从60开始存在,到132结束,其其中60 - 76的图片这个页面用不到
 
 http://photo6.xinzhuzhang.com/caticon_jiaju/cat_90.png?v=11
 */


#define Classify_URL @"http://photo6.xinzhuzhang.com/caticon_jiaju/cat_%@.png"

/*
    分类中每个类别的物品的接口  GET请求
 
    参数:
        cid:
        page  从0开始
 
 
 http://yyjd.xinzhuzhang.com/m/jiaju/goods/category/search?cid=77&isFollow=&page=0&appid=881376723&channel=AppleStore2&token=&udid=c64d8aac00df48c37b95125ce274166aca16e64b&idfa=518765D5-4E6D-4712-995C-911AC68BE703&idfv=40ABE4FE-E825-4526-9095-C09A0863BEA9&mac=02:00:00:00:00:00&timestamp=1463571811.692100&v=1.2.0&ios=9.3.1&sign=1ceb990cc3b8eb2bebe62bcf9d62c492
 */


#define GoodsTypeURL @" http://yyjd.xinzhuzhang.com/m/jiaju/goods/category/search?cid=77&isFollow=&page=%d&appid=881376723&channel=AppleStore2&token=&udid=nill"


/*
    在类型物品模块的单个物品信息接口和捡宝中物品查看物品详细接口ReducedGoodURL 相同
 */

#endif /* NetInterface_h */






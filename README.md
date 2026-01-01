# 启航电商WMS系统

> **欢迎来到我们的开源项目！创新、协作、高质量的代码。您的Star🌟，是我们前进的动力！ 💪✨🏆**

> **项目持续更新中，还有很多不足，请多包含！如有任何疑问请提交issuse！谢谢！ 💪✨🏆**

## 系统介绍
启航电商WMS系统是一套电商WMS进销存业务管理系统，主体功能包括：商品管理、出库管理、入库管理、库存管理、仓库设置等。

**该WMS系统并不是普通的WMS系统，改系统是带电商OMS功能的电商订单、仓库一体化管理系统**

[启航电商ERP系统](https://gitee.com/qiliping/qihangerp-cloud)


## 功能清单

#### 商品管理

+ 商品库：商品信息管理。
+ 商品库存：商品库存查询。
+ 店铺商品管理（店铺商品关联商品库商品）
+ 商品分类管理：管理商品分类、分类属性规格。
+ 商品品牌管理：品牌管理。

#### 网店订单管理
+ 店铺订单管理：管理店铺订单，包括拉取订单、订单处理等；
+ 店铺售后管理：管理店铺售后，包括拉取售后、售后处理等；
+ 店铺管理：多平台多店铺参数设置
+ 平台参数设置：平台开关及参数设置。

#### 出库管理
+ 订单发货
+ 备货出库
+ 出库管理
+ 发货记录

#### 入库管理
+ 入库管理
+ 退货入库
+ 采购入库


#### 仓库设置
+ 发货设置
+ 库位管理



## 部署说明

#### 0 版本说明
+ Java：17
+ Nodejs：v16
+ SpringBoot:3
+ MySQL:8
+ Redis:7

#### 1 配置MySQL

+ 创建数据库`qihang-wms`
+ 导入数据库结构：sql脚本`docs\qihang-wms.sql`



#### 2 启动Redis
项目开发采用Redis7

#### 3 修改项目配置

+ 修改`app`项目中的配置文件`application.yml`配置`Mysql`相关配置。


#### 4 mvn打包部署
+ Java版本：`Java 17`
+ Maven版本：`3.8`
  `mvn clean package`


#### 5 前端 `vue`打包
+ nodejs版本要求：`v16.x`
+ 安装依赖：`npm install --registry=https://registry.npmmirror.com`
+ 打包`npm run build:prod`

#### 6 修改Nginx配置

```
# 前端web配置
location / {
        #root   /opt/qihangerp/nginx/dist;
        root /usr/share/nginx/html;
        index  index.html index.htm;
        try_files $uri $uri/ /index.html;
    }
# 增加后台api转发
##### 修改Nginx配置（增加vue404、增加后台api转发）

location /prod-api/ {
    proxy_set_header Host $http_host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header REMOTE-HOST $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_pass http://localhost:8088/;
}
```
#### 7 访问web
+ 访问地址：`http://localhost`
+ 登录名：`admin`
+ 登录密码：`admin123`



## 支持一下

**感谢大家的关注与支持！希望利用本人从事电商10余年的经验帮助到大家提升工作效率！**

### 6.1 赠人玫瑰手留余香
💖 如果觉得有用记得点个 Star⭐

### 6.2 一起交流


💖 欢迎加入关注微信公众号和朋友们一起交流！

   <img src="docs/微信公众号.jpg" width="300px" />


### 6.3 捐助作者
哪怕是堆代码，也是耗费作者不少精力的，如果项目帮到了您可以请作者吃个盒饭！

<img src="docs/微信收款码.jpg" width="300px" />
<img src="docs/支付宝收款码.jpg" width="300px" />




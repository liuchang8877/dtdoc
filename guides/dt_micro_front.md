# DT平台微前端技术文档



> 2020.06.10 卜文豪
>
> 第一版，后续根据需求持续补充完善



> 2020.07.03 卜文豪
>
> 新增脚手架相关内容描述
>
> 新增iframe组件接口文档



> 2020.07.09 卜文豪
>
> 新增迁移指南



> 2020.07.16 卜文豪
>
> 左右视图组件新增属性: canHideLeft



> 2020.08.10 卜文豪
>
> 所有组件接口文档更新



> 2020.08.12 卜文豪
>
> 树形结构组件新增按钮配置属性



> 2020.08.14 卜文豪
>
> 表单组新增relyOn、showOnValue属性
>
> 表单组新增type="text"纯文本类型



> 2020.09.01 卜文豪
>
> 表单组新增showOnFunction、showButtons属性
>
> 表格组件新增ref标识
>
> 穿梭框新增hideAllChildren属性
>
> 框架项目新增全局loading方法，配置于Vue实例中



> 2020.11.04 卜文豪
>
> 各组件接口内容完善补全



> 2020.11.18 卜文豪
>
> 查询表单新增日期、时间选择器范围选择配置
>
> 表单组新增日期、时间选择器范围选择配置；v-model双向绑定配置



>2020.12.07 卜文豪
>
>部分组件新增属性，完善接口文档
>
>新增工具类方法描述



> 2020.12.16 卜文豪
>
> 新增全屏视图模式

### 一、项目概览

#### 1. 架构设计

对于微前端的概念介绍以及DT项目微前端的架构设计，提供了PPT文档进行介绍，并组织了技术培训，详看钉钉“智慧校园应用事业群产品培训”群中《DT微前端》直播回放视频，以下仅展示部分关键要素。

![Image text](https://git.newcapec.cn/150453/images/raw/master/micro_frontend_1.jpg)

![Image text](https://git.newcapec.cn/150453/images/raw/master/micro_frontend_2.jpg)

![Image text](https://git.newcapec.cn/150453/images/raw/master/micro_frontend_3.jpg)

![Image text](https://git.newcapec.cn/150453/images/raw/master/micro_frontend_4.jpg)

![Image text](https://git.newcapec.cn/150453/images/raw/master/micro_frontend_5.jpg)

![Image text](https://git.newcapec.cn/150453/images/raw/master/micro_frontend_6.jpg)

![Image text](https://git.newcapec.cn/150453/images/raw/master/micro_frontend_7.jpg)

#### 2. 目录结构

由于微前端化改造，新的DT平台前端由多个独立的项目组成，所以目录结构将分为**外层**和**内层**两部分组成。

* ##### 外层：不同项目间的目录结构

  ```js
  - deepCloud   // 总项目文件夹
   - common       // 通用文件
    - lang          // 通用国际化配置
   - projects     // 独立子项目文件夹
    - currency      // 通用业务项目
    - frame         // 框架项目
    - demo          // 已配置的空项目（demo项目）
    - ...           // 后续可能集成的各子项目
   - root_html    // 基座项目
   - README.md    // 项目概述文件
   - .gitignore   // git忽略配置文件
  ```
  
* ##### 内层：每个独立项目自身的目录结构

  ```js
  // 各子项目均为独立的vue项目，基本类似，此处以demo项目作为举例
  
  - demo                 // 子项目文件夹
   - dist                      // 打包文件
   - node_modules              // 框架依赖
   - public                    // vue脚手架自带（微前端架构下目前基本无用）
   - src                       // 项目主体文件夹
    - assets                     // 静态文件
    - components                 // 自定义组件
    - i18n                       // 国际化
    - router                     // 路由
    - service                    // 网络请求
    - store                      // 数据管理
    - views                      // 页面
    - App.vue                    // 页面入口
    - main.js                    // 项目入口
    - set-public-path.js         // 项目微前端化输出配置
   - .browserslistrc           // 浏览器兼容配置（vue脚手架自带）
   - .env.development          // 开发环境常量
   - .env.production           // 生产环境常量
   - babel.config.js           // vue脚手架自带
   - package.json              // npm依赖管理
   - vue.config.js             // vue项目打包配置
  ```

### 二、项目详解

> deepcloud-cli中，框架项目与通用业务项目已打包内置于基座项目中

#### 1. 基座项目

* 统一引入通用的框架依赖：vue、element-UI、axios等，所有子项目通过对vue.config.js进行配置在打包时已忽略自身依赖框架
  * 子项目中自身业务需求要引入使用到的依赖正常使用
  * 若后续新增引入其他公共依赖框架，建议尽量由基座统一加载，以避免项目整体运行时产生重复依赖的现象
* 统一引入各子项目打包生成的js文件，注册并根据url中的特定前缀管理子项目的加载展示
  * 目前前缀为子项目名称，比如当url为**localhost:5000/currency/xxx**时，基座会动态加载渲染通用业务项目
  * 前缀名称在各子项目的**.env.development || .env.production**中进行配置，应避免与其他子项目重复
  * 新集成子项目需要更新基座项目中的**registry/singleSpa_projects.json**文件
* 基座项目已配置代理服务，在开发过程中无需考虑跨域问题，通过调整基座项目中**serve/config.js**文件即可进行代理配置

#### 2. 框架项目

* ##### 页面
  * 登录页面 - 包含登录、自动登录业务
  * 框架页面 - 包含顶部导航条、左侧菜单目录、右侧页面视图区域

* ##### 样式
  * 统一引入基础样式配置
  * 统一引入element-UI自定义样式

* ##### 通用组件库

  | 类别     | 组件         | 组件名              |
  | -------- | ------------ | ------------------- |
  | 页面     | 单视图页面   | dt-single-page-view |
  |          | 左右视图页面 | dt-double-page-view |
  |          | iframe页面   | dt-iframe-view      |
  |          |              |                     |
  | 表单     | 图片上传     | dt-image-upload     |
  |          | 搜索表单     | dt-search-form      |
  |          | 表单组视图   | dt-form-group       |
  |          |              |                     |
  | 表格     | 标准表格     | dt-table            |
  |          | 表格按钮组   | dt-table-btn-group  |
  |          |              |                     |
  | 穿梭框   | 标准模式     | dt-transfer         |
  |          | 弹窗模式     | dt-transfer-dialog  |
  |          | 输入框模式   | dt-transfer-input   |
  |          |              |                     |
  | 树形结构 | 标准模式     | dt-tree             |
  |          | 弹窗模式     | dt-tree-dialog      |
  |          | 输入框模式   | dt-tree-input       |
  |          |              |                     |
  | 其他     | 弹窗         | dt-dialog           |
  |          | 分页         | dt-pagination       |
  |          | svg图标      | dt-svg-icon         |

  > 1. 上述组件均统一声明在vue实例中，所有页面可直接使用，无需通过import引入
  >
  > 2. 上述组件的使用方式在demo项目中均有展示，在本文后面的章节中也会有详细的讲解
  >
  > 3. 上述组件均是基于产品提出的UI规范对element-ui组件进行二次封装而成，旨在保证平台UI样式统一

* ##### 通用方法
  * 基础工具
  * 验证工具
  * 语言环境
  * 消息通知
  
  * 身份认证信息
  
  * 权限校验
  
  > 1. 上述工具类方法均统一声明在vue实例中，命名为$utils，页面可直接使用
  >2. 权限校验方法单独声明在vue实例中，命名为$checkPermission，页面可直接使用
  
* ##### 全局loading

  * 项目内置了视图区域的全局loading配置及方法
    * 展示： this.$dt_loading.show(text)
    * 隐藏： this.$dt_loading.hide()
  * 一般常规页面开发无需再设置视图的v-loading及相关逻辑，需要展示或隐藏时调用上述方法即可
  * 展示方法中参数**text**为loading下方文字内容，默认为：正在加载中...
  
* **全屏视图**

  * 项目提供了全屏视图的显示方式，当处于全屏视图模式时，不展示左侧菜单目录、顶部导航栏、面包屑。
  * 开启方式：url上追加参数**isFullPage=true**
  * 样例：http://xxx.xxx.xxx?isFullPage=true

#### 3. 通用业务项目

* ##### 页面
  * 以菜单目录作为依据进行目录结构划分，多层的情况下也需保持一致
  * 页面最外层统一使用框架项目提供的页面视图组件（单、左右）
  * 注意隔离，样式隔离使用**scope**关键字、vue中已声明的属性或方法实现不可覆盖替换


* ##### 路由
  * 由于微前端架构的原因，页面路径必须逐个声明，弃用老项目中的声明方式
  * **router/config**文件夹中的目录结构与**src/views**下的一级目录保持一致，内部**index.js**文件中仅声明自身模块下的页面
  * 路由路径引入统一前缀，而后根据目录结构拼接完整路径，写法保持一致
  
> 样例
  >
  > deepcloud-cli项目可参考 **projects/demo/...**

```js
  // 系统管理下级各页面的路由路径声明
  // src/router/config/sysConfig/index.js
  
  import { prefix } from '../../prefix'
  import menu from '@/views/sysConfig/menu'
  import dict from '@/views/sysConfig/dict'
  import ... from '...'
  
  export default [
    {
        name: 'menu',
        component: menu,
        path: prefix + '/sysConfig/menu'
    },
    {
        name: 'dict',
        component: dict,
    		path: prefix + '/sysConfig/dict' 
    },
    ...
  ]
```

  ```vue
  // 获取url尾部拼接的参数
// src/views/sysConfig/dict/index.vue
  // http://localhost:5000/currency/sysConfig/dict?a=1
  
  <script>
  export default {
    ...
    mounted() {
    		console.log(this.$route.query)
  	},
    watch: {
	      $route: {
	    	    handler: function(route) {
              	console.log(route.query)
            }
    	}
    }
  }
  </script>
  ```

* ##### 网络
  
  * 每个子项目中内置Request基础方法，底层模块依赖于脚手架，提供自定义拦截器扩展方法
  * **src/service/api**文件夹中的目录结构与**src/views**中的目录结构保持一致，各文件中仅声明自身页面涉及到的接口请求方法
  * **src/service/base**文件中定义封装了对网络请求底层的依赖方法以及自定义拦截器扩展方法
  * **src/service/config**文件中定义了常用的各个网关地址路径
  * 页面中引入网络请求模块的写法保持统一
  
  > 样例
  >
  > deepcloud-cli项目可参考 **projects/demo/...**
  
  ```javascript
  // src/service/api/sysConfig/menu.js
    
  import service from '../../base'
  import config from '../../config'
    
  export default {
  	getMenuList() {
  		return service({
  			url: config.VUE_MODULE_UPMS + 'adm/security/menu/alllist',
  			method: 'get'
  		})
  	},
  	...
  }
  ```
  
  ```vue
  // 页面中引入网络模块并调用接口请求方法
  // src/views/sysConfig/menu/index.vue
    
  <script>
  import Request from '@/service'
  export default {
  	...
  	methods: {
  		getList() {
  			Request.sysConfig.menu.getMenuList().then(res => {
  				console.log(res)
  			}).catch(err => {
  				console.log(err)
  			})
  		}
  	}
  }
  </script>  
  ```
* ##### 国际化
  * 常用参数已在外层目录结构下的**common/lang**文件夹中进行统一配置
  * 原则上各独立子项目仅在自身项目中配置各页面需要的特定中英文数据
  * **i18n/lang/en、i18n/lang/zh**中的js文件对应导航菜单的一级目录列表，各js文件中声明本模块下的所有页面数据

  > 样例
  >
  > deepcloud-cli项目可参考 **projects/demo/...**
  
  ```javascript
  // 中文 src/i18n/lang/zh/sysConfig.js
  export default {
  	// 路由管理页面
  	route: {
  		refresh: '刷新路由'
  	}
  }
    
  // 英文 src/i18n/lang/en/sysConfig.js
  export default {
  	// 路由管理页面
  	route: {
  		refresh: 'refresh route'
  	}
  }
  ```
  
  ```vue
  // 国际化数据在页面中的具体使用
    
  // src/views/sysConfig/route/index.vue
  <template>
    <single-page-view>
      <p>{{ $t('sysConfig.route.refresh') }}</p>
    </single-page-view>
  </template>
  
  <script>
    export default {
      ...
      mounted() {
      	console.log(this.$t('sysConfig.route.refresh'))
    	}
    }
  </script>
  ```
* ##### 组件
  * **src/components**文件夹中的目录结构与**src/views**中的目录结构保持一致，各文件中仅封装自身页面涉及的自定义组件
  * 原则上自定义组件的封装仅关注样式、交互，业务代码尽量不要在组件中编写以保证组件的扩展性与复用性
  * 平台本身已提供了部分通用的自定义组件，若不满足需求优先考虑联系脚手架开发人员对其进行扩展，尽量不重复创建样式或功能交互一致的组件
  * 子项目自身独立使用的组件由各项目组开发人员自行封装，平台内可通用的组件由脚手架开发人员统一进行封装


* ##### 通知
  * 子项目一般情况下以低耦合的状态共存，尽量保持项目自治。若确实需要进行子项目之间的通信交互时，通过web浏览器原生自带的消息机制来实现，各项目**main.js**中也已存在具体使用场景

  > 样例

  ```js
  // 消息通知的基础封装方法
  // .../utils/notice.js
  
  export default {
    demo: {
        key: 'DEMO_NOTICE',
        // 发送
        send(param) {
            window.dispatchEvent(new CustomEvent(this.key, param))
        },
        // 监听
        listener(_function) {
            window.addEventListener(this.key, _function)
        },
        // 移除
        clear(_funciont) {
            window.removeEventListener(this.key, _function)
        }
    },
    ...
  }
  ```

  ```js
  // 发送消息通知
  
  // 通过Vue实例调用通知方法
  - Vue.prototype.$utils.notice.demo.send(...)
  // 页面中通过this调用通知方法
  - this.$utils.notice.demo.send(...)
  ```

  ```js
  // 消息通知的监听与销毁
  // src/main.js
  
  import Vue from 'vue'
  ...
  
  // 收到消息时响应的方法
  const listener_function = () => {
    console.log('...')
  }
  
  // 微前端中子应用的生命周期 - 挂载
  export function mount(props) {
    Vue.prototype.$utils.notice.demo.listener(listener_function)
    ... 
  }
  
  // 微前端中子应用的生命周期 - 卸载
  export function unmount(props) {
    Vue.prototype.$utils.notice.demo.clear(listener_function)
    ...
  }
  ```

* ##### 其他
  * 各项目中的**projects/xxx/.env**文件中可声明项目自身需要用到的常量，一般为项目名称、接口请求地址等
  * 各项目中的**main.js、vue.config.js**等一些基础配置文件一般无需改动，参考demo项目中的进行配置即可
  * 开发过程中尽量注意代码规范
    * 变量或方法声明、关键业务逻辑部分需要写清注释
    * 大片代码注释部分需要表明该处代码涉及哪些业务、因何弃用、在什么情况下会重新启用
    * 复制粘贴后再更改开发的过程中，必须对无用代码进行清理

#### 4. demo项目

* ##### 页面入口
  * 导航条右上角，鼠标移到登录用户头像上时展示的下拉菜单中提供demo页面入口按钮
  * 脚手架项目入口已隐藏，可手动输入 http://localhost:5000/demo/welcome 进行查看


* ##### 包含内容
  * 组件库展示样例
  * 项目网络、路由、国际化等基础配置样例


* ##### 开发参考方式
  * 通过复制本项目重新创建代码仓库进行开发
  * 基础配置文件已全部涵盖，除极少数特定参数外均无需更改调整
    * .env文件中的**VUE_APP_BASE_NAME**改为项目自身名称
    * package.json文件中的**name**改为项目自身名称

### 三、开发文档

#### 1. 安装运行

* ##### 项目地址
  * https://git.newcapec.cn/02-newcapec/17-shareTech/front-development-team/deepcloud.git
    * 用于DT团队内部维护脚手架基础公共内容
  * https://git.newcapec.cn/02-newcapec/17-shareTech/front-development-team/deepcloud-cli.git
    * 脚手架，用于其他团队接入DT平台


* ##### 启动命令
  > 1. 由于DT平台微前端化后每个子项目均为独立服务，所以平台完整运行需要启动所有项目的服务
  > 2. 基座与子项目全部启动服务之后，浏览器访问 http://localhost:5000 
  * 基座项目
    * cd root_html
    * npm install
    * npm run serve
  * 框架项目
    * cd projects/frame
    * npm install
    * npm run serve
    
    > deepcloud-cli忽略此命令，该项目已打包内置于基座中
    
  * 通用业务项目
    * cd projects/currency
    * npm install
    * npm run serve
    
    > deepcloud-cli忽略此命令，该项目已打包内置于基座中
  * demo项目
    * cd projects/demo
    * npm install
    * npm run serve

#### 2. 通用组件库

1. 通用组件库基于element-UI进行二次封装
2. 通用组件库已内置由产品团队提出的标准UI规范样式布局代码
3. 通用组件库旨在减少开发工作量、规范页面UI标准，但并不能涵盖所有情况，开发中结合实际情况按需选用
4. demo项目中提供了所有组件的基础用法及demo示例页面

**2.1 页面**

* **单视图组件**

  * dt-single-page-view
  * 页面展示区域最外层视图元素，已内置基础间距等样式属性

  > 样例

  ```vue
  // projects/demo/src/views/welcome/index.vue
  
  <template>
    <dt-single-page-view>
        ...
    </dt-single-page-view>
  </template>
  ```

  > 属性

  | 属性       | 类型    | 简介                | 默认值 |
  | ---------- | ------- | ------------------- | ------ |
  | style      | Object  | 组件外层div样式     | {}     |
  | innerStyle | Object  | 组件内层div样式     | {}     |
  | show       | Boolean | 组件内层div是否展示 | true   |

  > 1. 组件内部由两层div组成，故有内层与外层之说，内层div中设置插槽slot以渲染实际内容
  >
  > 2. 设置内外层div的原因主要是为了处理样式、间距、loading等问题，无其他特殊考虑因素

* **左右视图组件**

  * dt-double-page-view
  * 页面展示区域最外层视图元素，已内置基础间距等样式属性
  * 分为左右两块视图区域，右侧视图宽度根据左侧宽度自适应填充

  > 样例

  ```vue
  // projects/demo/src/views/demos/other/index.vue
  
  <template>
    <dt-double-page-view>
        <div slot="left_view">
            ...
        </div>
        <div slot="right_view">
            ...
        </div>
    </dt-double-page-view>
  </template>
  ```

  > 属性

  | 属性        | 类型    | 简介                                           | 默认值  |
  | ----------- | ------- | ---------------------------------------------- | ------- |
  | style       | Object  | 组件外层div样式                                | {}      |
  | innerStyle  | Object  | 组件内层div样式                                | {}      |
  | show        | Boolean | 组件内层div是否展示                            | true    |
  | leftWidth   | String  | 左侧视图宽度                                   | "200px" |
  | canHideLeft | Boolean | 右侧视图是否显示按钮，点击可展示或隐藏左侧视图 | false   |

  > 1. 组件内部由两层div组成，故有内层与外层之说，内层div中设置两个插槽slot以渲染左右视图实际内容
  >
  > 2. 设置内外层div的原因主要是为了处理样式、间距、loading等问题，无其他特殊考虑因素

* **iframe组件**

  * dt-iframe-view

  > 样例

  ```vue
  // projects/demo/src/views/demos/iframe/index.vue
  
  <template>
      <iframe-view :url="url" />
  </template>
  
  <script>
  export default {
    name: 'iframePage',
    data() {
        return {
            url: "http://192.168.113.166/docs/#/guides/dt_micro_front"
        }
    }
  }
  </script>
  ```

  > 属性

  | 属性 | 类型   | 简介     | 默认值 |
  | ---- | ------ | -------- | ------ |
  | url  | String | 访问地址 | ""     |

**2.2 表单**

* **图片上传**

  * dt-image-upload
  * 内置DT平台上传图片adminHeader以及访问图片地址的固定前置路径

  > 样例

  ```vue
  // projects/demo/src/views/demos/form/index.vue
  
  <template>
  	<dt-image-upload
  		:src="imageUpload.path"
  		v-model="imageUpload.path"
  		@success="imageUploadSuccess"
  	/>
  </template>
  
  <script>
  export default {
  	name: 'formPage',
  	data() {
  		return {
  			imageUpload: {
  				path: '/20200421/9/AC8D0FE58E764AF7B02D7159555D3DEB.jpg'
  			}
  		}
  	}，
    methods: {
    	imageUploadSuccess(path) {
            console.log(path)
        }
  	}
  }
  </script>
  ```
  
  > 属性
  
  | 属性 | 类型   | 简介               | 默认值 |
  | ---- | ------ | ------------------ | ------ |
  | src  | String | 默认显示的图片路径 | ""     |
  
  > 事件
  
  | 事件    | 简介     | 返回值                   | 返回值示例     |
  | ------- | -------- | ------------------------ | -------------- |
  | success | 上传成功 | 上传图片后返回的路径地址 | "/xxx/xxx.jpg" |
  
  > 可通过v-model或success两种方式获取到图片上传后服务端返回的路径地址
* **搜索表单**

  * dt-search-form
  * DT页面中表格上方的常规搜索查询模块

  > 样例

  ```vue
  // projects/demo/src/views/demos/form/index.vue
  
  <template>
  	<dt-search-form :render="render" @confirm="confirm">
      <el-input
        slot="slot_A"
        placehoder="自定义插槽A"
        v-model="searchFormSlotA"
      />
    </dt-search-form>
  </template>
  
  <script>
  export default {
  	name: 'formPage',
  	data() {
  		return {
  			render: [{
  				type: 'input',
  				key: 'input',
  				label: '文本',
  				placeholder: '请输入文本',
  			}, {
  				type: 'select',
  				key: 'select',
  				label: '选择',
  				placeholder: '请选择选项',
  				option: [
  					{ label: '选项A', value: 0 },
  					{ label: '选项B', value: 1, disabled: true }
  				]
  			}, {
  				type: 'time-picker',
  				key: 'time',
  				label: '时间',
  				placeholder: '请选择时间'
  			}, {
  				type: 'date-picker',
  				key: 'date',
  				label: '日期',
  				placeholder: '请选择日期'
  			}, {
  				type: 'date-picker',
  				key: 'datetime',
  				pickerType: 'datetime',
  				label: '日期时间',
  				placeholder: '请选择日期时间'
  			}, {
  				type: 'time-picker',
  				key: 'timerange',
  				isRange: true,
  				label: '时间范围',
  				placeholder: '请选择时间范围'
  			}, {
  				type: 'date-picker',
  				key: 'daterange',
  				pickerType: 'daterange',
  				label: '日期范围',
  				placeholder: '请选择日期范围'
  			}, {
  				type: 'date-picker',
  				key: 'datetimerange',
  				pickerType: 'datetimerange',
  				label: '日期时间范围',
  				placeholder: '请选择日期时间'
  			}, {
  				type: 'slot',
  				name: 'slot_A',
  				label: '自定义插槽'
  			}],
        // 查询表单插槽A绑定v-model数据
        searchFormSlotA: '',
  		}
  	}，
    methods: {
    	confirm(form) {
            console.log(form)
        }
  	}
  }
  </script>
  ```

  > 属性

  | 属性     | 类型   | 简介                                | 默认值 |
  | -------- | ------ | ----------------------------------- | ------ |
  | render   | Array  | 表单渲染数据 （数组中元素为Object） | []     |
  | formMd   | Number | 表单自适应栅格布局尺寸（全部）      | 12     |
  | formLg   | Number | 表单自适应栅格布局尺寸（全部）      | 6      |
  | buttonMd | Number | 按钮自适应栅格布局尺寸              | -      |
  | buttonLg | Number | 按钮自适应栅格布局尺寸              | -      |

  > render中元素

  | 属性        | 类型    | 简介                           | 补充                                                         |
  | ----------- | ------- | ------------------------------ | ------------------------------------------------------------ |
  | type        | String  | 表单类型                       | input：输入框<br />select：下拉选择框<br />date-picker：日期选择器<br />time-picker：时间选择器<br />slot: 自定义插槽 |
  | key         | String  | 表单唯一标识                   | confirm事件返回值中各数据所对应的键值                        |
  | label       | String  | 表单标题                       | -                                                            |
  | placeholder | String  | 占位文字                       | -                                                            |
  | disabled    | Boolean | 是否禁用                       | -                                                            |
  | default     | -       | 默认数据                       | -                                                            |
  | option      | Array   | 下拉选择框选项                 | 仅在type="select"时生效<br />label：选项名<br />value：选项值<br />disabled：选项是否禁用 |
  | filterable  | Boolean | 选择器是否可搜索               | 仅在type="select"时生效                                      |
  | clearable   | Boolean | 是否可以清空选项               | 仅在type="select"时生效                                      |
  | isRange     | Boolean | 是否是时间范围选择             | 仅在type="time-picker"时生效<br />范围选择时返回对应数据为数组结构 |
  | pickerType  | String  | 日期选择器类型                 | 仅在type="date-picker"时生效<br />可配置值详见element-UI文档<br />范围选择时返回对应数据为数组结构 |
  | md          | Number  | 表单自适应栅格布局尺寸（单个） | 优先级高于formMd                                             |
  | lg          | Number  | 表单自适应栅格布局尺寸（单个） | 优先级高于formLg                                             |

  > 事件

  | 事件    | 简介 | 返回值           | 示例                                            |
  | ------- | ---- | ---------------- | ----------------------------------------------- |
  | confirm | 提交 | Object: 表单内容 | {input: "...", select: 0, date: xxx, time: xxx} |
  | reset   | 重置 | -                | -                                               |

  > 1. 日期选择器与时间选择器返回的是new Date()对象，可根据业务具体情况取值
  > 2. 表单重置按钮业务逻辑已内置，无需考虑，重置按钮事件多用于同步调整slot中内容以及校验相关内容
  > 3. 暂不支持校验规则，后续迭代中会进行补充优化

* **表单组视图**

  * dt-form-group
  * DT页面中新增、修改页面的常用表单模块

  > 样例

  ```vue
  // projects/demo/src/views/demos/form/index.vue
  
  <template>
  	<!-- v-model与date属性在实际使用时二选一 -->
  	<dt-form-group 
  		ref="dtFormGroup"
  		v-model="data"
  		:data="data"
  		:render="render"
  		@reset="reset"
  		@change="change"
  		@confirm="confirm"
  	>
        <!-- 表单插槽 - slotA -->
        <template v-slot:slotA="{ modelData }">
            <el-input v-model="modelData.key_slotA" :placeholder="'自定义插槽A'" />
        </template>
        <!-- 表单插槽 - slot -->
        <template slot="slotB">
            <div>
                {{formGroup.slotData.slotB}}
                <el-button @click="slotBButton">点击按钮</el-button>
            </div>
        </template>
        <!-- 整行插槽 - slotS_A -->
        <template v-slot:slotS_A="{ modelData }">
            <el-form-item
                prop="key_slotS_A"
                label="整行插槽"
                :rules="[{ required:true, message:'请输入内容', trigger: 'blur' }]"
            >
                <el-col :md="12" :lg="9">
                    <el-input 
                    		v-model="modelData.key_slotS_A" 
                    		:placeholder="'整行插槽A'" />
                </el-col>
            </el-form-item>
        </template>
    </dt-form-group>
  	<div>{{JSON.stringify(data)}}</div>
  </template>
  
  <script>
  export default {
  	name: 'formPage',
  	data() {
  		return {
            data: {
                key_textarea: 'abcdefg',
                key_select: 0,
                key_radio: 0,
            },
            slotData: {
                slotB: ''
            },
            render: [{
                type: 'text',
                label: '纯文本',
                value: '纯文本内容'
            },{
                type: 'input',
                key: 'key_input',
                label: '文本',
                placeholder: '请输入文本',
                rules: [
                    { required: true, message: '请输入内容', trigger: 'blur' },
                    { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
                ]
            }, {
                type: 'input',
                key: 'key_textarea',
                inputType: 'textarea',
                label: '长文本',
                placeholder: '请输入内容',
                rules: [
                    { required: true, message: '请输入内容', trigger: 'blur' },
                ]
            }, {
                type: 'select',
                key: 'key_select',
                label: '选择框',
                placeholder: '请选择选项',
                option: [
                    { label: '选项A', value: 0 },
                    { label: '选项B', value: 1 }
                ],
                rules: [
                    { required: true, message: '请选择选项', trigger: 'change' }
                ]
            }, {
                type: 'radio',
                key: 'key_radio',
                label: '单选',
                option: [
                    { label: '选项A', value: 0 },
                    { label: '选项B', value: 1, disabled: true }
                ],
                rules: [
                    { required: true, message: '请选择选项', trigger: 'change' }
                ]
            }, {
                type: 'input',
                key: 'key_input_relyOnRadioA',
                label: '依赖单选A',
                placeholder: 'AAAAA',
                relyOn: 'key_radio',
                showOnValue: 0,
                rules: [
                    { required: true, message: '请输入内容', trigger: 'blur' },
                ]
            }, {
                type: 'input',
                key: 'key_input_relyOnRadioB',
                label: '依赖单选B',
                placeholder: 'BBBBB',
                relyOn: 'key_radio',
              	showOnFunction: (val) => {
                  return val == 1
                }
                rules: [
                    { required: true, message: '请输入内容', trigger: 'blur' },
                ]
            }, {
                type: 'checkbox',
                key: 'key_checkbox',
                label: '多选',
                option: [
                    { label: '选项A', value: 0 },
                    { label: '选项B', value: 1 }
                ],
                rules: [
                    { type: 'array', required: true, message: '请选择', trigger: 'change' }
                ]
            }, {
                type: 'date-picker',
                key: 'key_datePicker',
                label: '日期选择器',
                placeholder: '请选择日期',
            },{
                type: 'date-picker',
                key: 'key_datetimePicker',
        				pickerType: 'datetime'
                label: '日期时间选择器',
                placeholder: '请选择日期',
            }, {
                type: 'time-picker',
                key: 'key_timePicker',
                label: '时间选择器',
                placeholder: '请选择时间',
            }, {
                type: 'image-upload',
                key: 'key_imageUpload',
                label: '上传图片',
                rules: [
                    { required: true, message: '请上传图片' }
                ]
            }, {
                type: 'slot',
                name: 'slotA',
                key: 'key_slotA',
                label: '自定义插槽',
                rules: [
                    { required: true, message: '请输入内容', trigger: 'blur' },
                ]
            }, {
                type: 'slot',
                name: 'slotB',
                key: 'key_slotB',
                label: '自定义插槽',
                rules: [
                    { required: true, message: '请点击按钮', trigger: 'change' },
                ]
            }, {
                type: 'slot-s',
                name: 'slotS_A',
                key: 'key_slotS_A'
            }]
  		}
  	}，
    methods: {
        // 表单组确认
        confirm(form) {
            console.log(form)
        },
        // 表单组重置
        reset() {
            this.slotData.slotB = ''
            this.$refs.dtFormGroup.slotModelUpdate('key_slotB', this.slotData.slotB)
        },
        // 表单内容改变
        change(event) {
          	console.log(event)
        },
        // 表单组 - 插槽B按钮
        slotBButton() {
            if (this.slotData.slotB) {
              this.slotData.slotB = ''
            } else {
              this.slotData.slotB = '已点击'
            }
            this.$refs.dtFormGroup.slotModelUpdate('key_slotB', this.slotData.slotB)
        }
  	}
}
  </script>
  ```
  
  > 属性
  
  | 属性       | 类型   | 简介                                 | 默认值  |
  | ---------- | ------ | ------------------------------------ | ------- |
  | data       | Object | 表单默认值，key为render中各表单的key | {}      |
  | render     | Array  | 表单渲染数据 （数组中元素为Object）  | []      |
  | labelWidth | String | 表单左侧标题栏宽度                   | "100px" |
  
  > render中元素
  
  | 属性           | 类型     | 简介           | 补充                                                         |
  | -------------- | -------- | -------------- | ------------------------------------------------------------ |
  | type           | String   | 表单类型       | text：纯文本 <br />input：输入框 <br />select：下拉选择框 <br />radio：单选 <br />checkbox：多选 <br />date-picker：日期选择框 <br />time-picker：时间选择框 <br />image-upload：图片上传 <br />hidden: 隐藏式组件<br />slot：自定义插槽 -  表单（插槽内容在el-form-item的表单区域）<br />slot-s: 自定义插槽 - 整行（无el-form-item，插槽内容为整行区域） |
  | key            | String   | 表单唯一标识   | confirm事件返回值中各数据所对应的键值，未配置时不返回该条表单内容 |
  | label          | String   | 表单标题       | -                                                            |
| placeholder    | String   | 占位文字       | -                                                            |
  | disabled       | Boolean  | 是否禁用       | -                                                            |
| default        | -        | 默认值         | 优先处理"data"属性中的默认值<br />若已在"data"中设置则忽略本属性的值<br />与"data"效果一致，建议优先使用"data"属性 |
  | rules          | Array    | 校验规则       | 写法与element-UI一致，未配置key时rules校验规则无效           |
  | inputType      | String   | 输入框类型     | 仅在type="input"时生效 <br />可配置为"textarea"以显示长文本  |
  | maxlength | String | 输入框最大长度 | 仅在type="input"时生效 |
  | showWordLimit | Boolean | 是否显示限制 | 仅在type="input"时生效 |
| readonly | Boolean | 输入框是否只读 | 仅在type="input"时生效 |
  | rows | String | 输入框行数 | 仅在type="input"且inputType="textarea"时生效 |
| option         | Array    | 下拉选择框选项 | 仅在type="select"时生效 <br />label：选项名  <br />value：选项值  <br />disabled：选项是否禁用 |
  | valueFormat | String | 日期、时间选择器值的格式 | 仅在type="time-picker"或type="date-picker"时生效<br />参考element-UI对应属性value-format |
  | isRange | Boolean | 是否是时间范围选择 | 仅在type="time-picker"时生效<br />范围选择时返回对应数据为数组结构 |
  | pickerType | String | 日期选择器类型 | 仅在type="date-picker"时生效<br />可配置为值详见element-UI开发文档<br />范围选择时返回对应数据为数组结构 |
| name           | String   | 自定义插槽名   | 仅在tpye="slot"或tpye="slot-s"时生效 <br />用于识别组件标签内部编写的自定义插槽内容 |
  | relyOn         | String   | 依赖于某条表单 | 值为表单组中某条表单的key <br />表示本表单的显示与否依赖于对应key值的表单 |
  | showOnValue    | -        | 显示条件值     | 仅在配置了relyOn属性时生效 <br />表示该表单的显示条件，当被依赖表单的值等于本属性的值时显示表单 |
  | showOnFunction | Function | 显示条件       | 仅在配置了relyOn属性时生效<br />入参为relyOn的组件的值<br />方法return true时显示表单<br />当同时配置了showOnValue时，本属性不生效 |
  | rmsr | Boolean | 移除输入框特殊字符校验     | 默认值为false<br />默认输入框不能输入特殊字符，当改值为true时，移除特殊字符校验 |
  
  > 事件
  
  | 事件    | 简介     | 返回值           | 示例                                                        |
  | ------- | -------- | ---------------- | ----------------------------------------------------------- |
  | v-model | 双向绑定 | Object: 表单内容 | {key_input: "...", key_textarea: "...", key_select: 0, ...} |
  | confirm | 提交     | Object: 表单内容 | {key_input: "...", key_textarea: "...", key_select: 0, ...} |
  | reset   | 重置     | -                | -                                                           |
  
  > 插槽相关
  
  | 事件            | 简介                                                   | 示例                                                         |
  | --------------- | ----------------------------------------------------- | ------------------------------------------------------------ |
  | slotModelUpdate | 更新插槽绑定数据并校验 <br />插槽存在key、rules时使用 | this.$refs.dtForm.slotModelUpdate(key, value) <br />key：插槽对应的key值<br />value：更新的内容 |
  
  > 1. v-model与data属性在实际使用时二选一
  >    1. 使用data时，默认数据由data传入，在@change与@confirm中传出
  >    2. 使用v-model时，默认数据由v-model传入且双向绑定，同时@change与@confirm亦传出数据
  > 2. 日期选择器与时间选择器返回的是new Date()对象，可根据业务具体情况取值
  > 3. 表单重置按钮业务逻辑已内置，无需考虑，重置按钮事件多用于同步调整slot中内容以及校验相关内容
  > 4. 自定义组件的表单列需要增加校验规则时会用到slotModelUpdate，用法及逻辑偏复杂
  >    1. slot表单需要配置key、rules
  >    2. 通过slotModelUpdate同步组件内对应表单条目的具体数据值
  >    3. 同步数据后会自动进行规则校验
  >    4. confirm事件返回值中会包含该条目的数据键值对

**2.3 表格**

* **标准表格**

  * dt-table
  * 常规表格模块，内置表格按钮组件

  > 样例

  ```vue
  // projects/demo/src/views/demos/table/index.vue
  
  <template>
  	<dt-table
  		ref="dt_table"
  		type="selection"
  		:data="columns"
  		:columns="columns"
  		@btnClick="btnClick"
  		@selection-change="handleSelectionChange"
  	/>
  </template>
  
  <script>
  export default {
  	name: 'tablePage',
  	data() {
        return {
            data: [{
                name: '王小虎',
                province: '上海',
                state: '1',
                address: '上海市普陀区金沙江路 1518 弄',
                imageView: {
                    url: 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                    srcList: [
                        'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                        'https://fuss10.elemecdn.com/1/8e/aeffeb4de74e2fde4bd74fc7b4486jpeg.jpeg'
                    ]
                },
                image: 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg'
            },{
                name: '王小虎',
                province: '上海',
                state: '1',
                address: '上海市普陀区金沙江路 1518 弄',
                imageView: {
                    url: 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                    srcList: [
                        'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
                        'https://fuss10.elemecdn.com/1/8e/aeffeb4de74e2fde4bd74fc7b4486jpeg.jpeg'
                    ]
                },
                image: 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg'
            }],
            columns: [{
                label: "姓名",
                prop: "name",
                tooltip: true
            }, {
                label: "地址",
                prop: "address",
                tooltip: true,
                align: "left"
            }, {
                label: "图片(可浏览)",
                width: 100,
                prop: "imageView",
                image: true,
                imageView: true,
                style: 'width: 50px; height:50px; border-radius: 100%'
            }, {
                label: "图片",
                width: 80,
                align: "left",
                prop: "image",
                image: true
            }, {
                label: "自定义html",
                tooltip: true,
                align: "left",
                template: (row) => {
                    return '<a href="###" style="color:blue">' + row.province + '</a>'
                }
            }, {
                label: "状态",
                minWidth: 60,
                tooltip: true,
                render: (h, params) => {
                    const text = params.row.state == 1 ? "启用中1" : "停用中2";
                    return h(
                        "div", text
                    );
                }
            }, {
                label: "状态",
                prop: "state",
                minWidth: 100,
                tooltip: true,
                align: "center",
                render: (h, params) => {
                    const text = params.row.state == 1 ? "启用中" : "停用中";
                    return h(
                        "Tag",
                        {
                            props: {
                                type: params.row.state == 1 ? "success" : "danger"
                            }
                        },
                        text
                	);
                }
            }, {
                label: "操作",
                align: "center",
                btn: (row) => {
                    let btnList = [row.name, "添加", "删除", "按钮"]
                    return btnList;
                }
            }]
  		}
  	}，
    methods: {
        btnClick(event) {
            console.log(event.index)
            console.log(event.row)
            // 组件中内嵌的el-table
            console.log(this.$refs.dt_table.$refs.table)
        },
        handleSelectionChange(row) {
            console.log(row)
        }
  	}
  }
  </script>
  ```
  
  > 属性
  
  | 属性    | 类型   | 简介                                                         | 默认值 |
  | ------- | ------ | ------------------------------------------------------------ | ------ |
  | data    | Array  | 表格数据                                                     | []     |
  | columns | Array  | 列配置数据（数组中元素为Object）                             | []     |
  | type    | String | 表格首列渲染类型<br />selection: 多选框<br />index: 索引（从1开始） | ""     |
  
    > columns中元素
  
  | 属性       | 类型     | 简介           | 补充                                                  |
  | ---------- | -------- | -------------- | ----------------------------------------------------- |
  | label      | String   | 列标题         | -                                                     |
  | prop       | String   | 表格数据key值  | 与data中key值对应                                     |
  | tooltip    | Boolean  | 是否禁用换行   | 禁用换行时超出部分...，鼠标指向时弹出气泡展示完整数据 |
  | align      | String   | 列对齐方式     | -                                                     |
  | width      | Number   | 列宽           | 按钮列内置默认宽度：160                               |
  | minWidth   | Number   | 最小列宽       | -                                                     |
  | image      | Boolean  | 该列是否为图片 | -                                                     |
  | imageView  | Boolean  | 图片是否可预览 | 仅在image=true时生效                                  |
  | imageStyle | String   | 图片样式       | 仅在image=true时生效                                  |
  | btn        | Function | 表格按钮配置   | 入参为本行数据，返回按钮数组                          |
  | template   | Function | 自定义渲染内容 | 入参为本行数据，返回字符串元素内容                    |
  | render     | Function | 自定义渲染内容 | 入参为渲染函数、本行数据，返回render渲染函数          |
  | ...        | ...      | 其他参数       | element-UI其他常用基础配置属性                        |
  
    > 事件
  
  | 事件             | 简介     | 返回值                                   | 示例                                 |
  | ---------------- | -------- | ---------------------------------------- | ------------------------------------ |
  | btnClick         | 表格按钮 | Object对象（按钮索引、本行数据、按钮名） | {index: ..., row: {...}, value: ...} |
  | selection-change | 选择某行 | Object对象（选中行数据）                 | {....}                               |
  
    > 1. 表格组件目前可支持70%-80%左右的常用业务功能
    > 2. 例如表格、树形结构的深度复杂用法暂不支持，页面开发过程中可根据实际情况选用组件或element-UI的el-组件

* **表格按钮组**

  * dt-table-btn-group
  * 表格内部操作按钮模块，最多显示三个，超出显示“更多”，以气泡弹窗展示多余按钮

  > 样例

  ```vue
  // projects/demo/src/views/demos/table/index.vue
  
  <template>
  	<dt-table-btn-group :btnList="btnList" @btnClick="btnClick" />
  </template>
  
  <script>
  export default {
  	name: 'tablePage',
  	data() {
        return {
            btnList: ["编辑", "添加", "删除", "按钮"]
        }
  	}，
    methods: {
        btnClick(index) {
            console.log(index)
        }
  	}
  }
  </script>
  ```
  
  > 属性
  
  | 属性    | 类型  | 简介     | 默认值 |
  | ------- | ----- | -------- | ------ |
  | btnList | Array | 按钮数据 | []     |
  
  > 事件
  
  | 事件     | 简介 | 返回值                 | 示例 |
  | -------- | ---- | ---------------------- | ---- |
  | btnClick | 点击 | Object对象（按钮索引） | 0    |

**2.4 穿梭框**

* **标准模式**

  * dt-transfer
  * 在具体元素视图中展示

  > 样例

  ```vue
  // projects/demo/src/views/demos/transfer/index.vue
  
  <template>
    <dt-single-page-view>
        <dt-transfer :data="data" v-model="select" @child="child" />
        <div>已选：{{JSON.stringify(select)}}</div>
    </dt-single-page-view>
  </template>
  
  <script>
  export default {
  	name: 'transferPage',
  	data() {
        return {
            data: [
                { id: 'a', title: 'aaa' },
                { id: 'b', title: 'bbb' },
                { id: 'c', title: 'ccc' },
                { id: 'd', title: 'ddd' },
                { id: 'e', title: 'eee' },
                { id: 'f', title: 'fff' },
                { id: 'g', title: 'ggg' },
                { id: 'h', title: 'hhh' },
                { id: 'i', title: 'iii'，selectedDisableChildren: true },
            ],
            select: []
        }
  	}，
    methods: {
        child(event) {
            // 选中数据
            console.log(event.parent)
            // 根据event.parent拉取其下级数据
            let under_data = [...]
            // 调用event.update回传下级数据
            event.update(under_data)
        }
  	}
  }
  </script>
  ```

  > 属性

  | 属性                 | 类型    | 简介                                | 默认值 |
  | -------------------- | ------- | ----------------------------------- | ------ |
  | data                 | Array   | 初始首级数据                        | []     |
  | defaultSelect        | Array   | 已选数据（传入时对应数据默认选中）  | []     |
  | singleCheck          | Boolean | 是否为单选模式                      | false  |
  | checkChildrenDisable | Boolean | 是否禁用下级按钮                    | false  |
  | permissionSwitch     | Boolean | 权限开关（开启后识别data.able字段） | false  |
  | viewHeight           | String  | 视图高度                            | '50vh' |
  | viewWidth            | String  | 视图宽度                            | '100%' |

  > data中元素

  | 属性                    | 类型    | 简介                                                         | 补充  |
  | ----------------------- | ------- | ------------------------------------------------------------ | ----- |
  | id                      | Number  | 数据唯一标识，判断左右侧数据的依据                           | -     |
  | __id                    | Number  | 同id，优先级高于id，当服务端返回数据id字段在实际情况中存在冲突时使用 | -     |
  | title                   | String  | 名称                                                         | -     |
  | hideChildren            | Boolean | 是否隐藏下级按钮                                             | -     |
  | able                    | Boolean | 权限开关，与permissionSwitch对应                             | -     |
  | parentId                | Number  | 上级id                                                       | -     |
  | selectedDisableChildren | Boolean | 选中之后禁用下级按钮                                         | false |
  > defaultSelect属性

  | 属性                 | 类型    | 简介    | 默认值 |
  | ------------ | ------- | -------------------------------- | ---- |
  |id|Number|数据唯一标识，判断左右侧数据的依据|-|
  |__id|Number|同id，优先级高于id，当服务端返回数据id字段在实际情况中存在冲突时使用|-|
  |title|String|名称|-|
  |disabled|Boolean|是否禁用移除|false|

  > 事件

  | 事件    | 简介     | 返回值                                                       | 示例     |
  | ------- | -------- | ------------------------------------------------------------ | -------- |
  | v-model | 选中数据 | -                                                            | 详见demo |
  | child   | 点击下级 | 返回Object <br />parent：当前选中的数据（Object） <br />update：更新穿梭框左侧列表展示下级数据（Function） | 详见demo |

* **弹窗模式**

  * dt-transfer-dialog
  * 以弹窗形式展示

  > 样例

  ```vue
  // projects/demo/src/views/demos/transfer/index.vue
  
  <template>
    <dt-single-page-view>
        <el-button @click="visible = true">穿梭框弹窗</el-button>
        <dt-transfer-dialog
            :title="'穿梭框弹窗'"
            :data="data"
            :visible.sync="visible"
            @click="click"
            @child="child"
        />
        <div>已选：{{JSON.stringify(select)}}</div>
    </dt-single-page-view>
  </template>
  
  <script>
  export default {
    name: 'transferPage',
    data() {
        return {
            data: [
                { id: 'a', title: 'aaa' },
                { id: 'b', title: 'bbb' },
                { id: 'c', title: 'ccc' },
                { id: 'd', title: 'ddd' },
                { id: 'e', title: 'eee' },
                { id: 'f', title: 'fff' },
                { id: 'g', title: 'ggg' },
                { id: 'h', title: 'hhh' },
                { id: 'i', title: 'iii' },
            ],
            select: [],
            visible: false
        }
  	}，
    methods: {
        click(event) {
            if(event.cancel) return
            this.visible = false
            this.select = event
        }
        child(event) {
            // 选中数据
            console.log(event.parent)
            // 根据event.parent拉取其下级数据
            let under_data = [...]
            // 调用event.update回传下级数据
            event.update(under_data)
        }
  	}
  }
  </script>
  ```

  > 属性

  | 属性    | 类型    | 简介                  | 默认值 |
  | ------- | ------- | --------------------- | ------ |
  | title   | String  | 弹窗标题              | ""     |
  | visible | Boolean | 是否展示弹窗          | false  |
  | ...     | ...     | dt-transfer的所有属性 | -      |

  > 事件

  | 事件  | 简介     | 返回值                                                       | 示例     |
  | ----- | -------- | ------------------------------------------------------------ | -------- |
  | click | 弹窗按钮 | 点击确定时返回选中元素 <br />点击取消时返回对象：{ cancel: true } | 详见demo |
  | child | 点击下级 | 返回Object，Object中包含以下两个参数<br />parent：当前选中的数据（Object） <br />update：更新穿梭框左侧列表展示下级数据（Function） | 详见demo |

* **输入框模式**

  * dt-transfer-input
  * 渲染输入框，点击输入框时以弹窗形式展示

  > 样例

  ```vue
  // projects/demo/src/views/demos/transfer/index.vue
  
  <template>
    <dt-single-page-view>
        <dt-transfer-input
            :title="'穿梭框弹窗+输入框'"
            :data="transfer_data"
            :defaultSelect="select"
            @click="click"
            @child="child"
        />
  	</dt-single-page-view>
  </template>
  
  <script>
  export default {
  	name: 'transferPage',
  	data() {
        return {
            data: [
                { id: 'a', title: 'aaa' },
                { id: 'b', title: 'bbb' },
                { id: 'c', title: 'ccc' },
                { id: 'd', title: 'ddd' },
                { id: 'e', title: 'eee' },
                { id: 'f', title: 'fff' },
                { id: 'g', title: 'ggg' },
                { id: 'h', title: 'hhh' },
                { id: 'i', title: 'iii' },
            ],
            select: []
        }
  	}，
    methods: {
        click(event) {
            if(event.cancel) return
            this.select = event
        }
        child(event) {
            // 选中数据
            console.log(event.parent)
            // 根据event.parent拉取其下级数据
            let under_data = [...]
            // 调用event.update回传下级数据
            event.update(under_data)
        }
  	}
  }
  </script>
  ```

  > 属性

  | 属性        | 类型   | 简介                  | 默认值 |
  | ----------- | ------ | --------------------- | ------ |
  | title       | String | 弹窗标题              | ""     |
  | placeholder | String | 占位文字              | ""     |
  | ...         | ...    | dt-transfer的所有属性 | -      |

  > 事件

  | 事件  | 简介             | 返回值                                                       | 示例     |
  | ----- | ---------------- | ------------------------------------------------------------ | -------- |
  | click | 弹窗按钮点击事件 | 点击确定时返回选中元素  <br />点击取消时返回对象：{ cancle: true } | 详见demo |
  | child | 下级按钮点击事件 | 返回Object，Object中包含以下两个参数 <br />parent：当前选中的数据（Object）  <br />update：更新穿梭框左侧列表展示下级数据（Function） | 详见demo |

**2.5 树形结构**

* **标准模式**

  * dt-tree
  * 在具体元素视图中展示

  > 样例

  ```vue
  // projects/demo/src/views/demos/tree/index.vue
  
  <template>
    <dt-single-page-view>
        <dt-tree 
            v-model="select" 
            :data="data" 
            :buttons="buttons"
            @select="selectItem"
            @clickButton="clickButton"
        />
        <div class="data">已选：{{JSON.stringify(select)}}</div>
  	</dt-single-page-view>
  </template>
  
  <script>
  export default {
  	name: 'treePage',
  	data() {
        return {
            data: [{
                label: '一级 1',
                id: '1',
                children: [{
                    id: '2',
                    label: '二级 1-1',
                    children: [{
                        id: '3',
                        label: '三级 1-1-1'
                    }]
                }]
            }, {
                id: '4',
                label: '一级 2',
                children: [{
                    id: '5',
                    label: '二级 2-1',
                    children: [{
                        id: '6',
                        label: '三级 2-1-1'
                    }, {
                        id: '7',
                        label: '三级 2-1-2'
                    }]
                }, {
                    id: '8',
                    label: '二级 2-2',
                    children: [{
                        id: '9',
                        label: '三级 2-2-1'
                    }]
                }]
            }, {
                label: '一级 3',
                id: '10',
                children: [{
                    id: '11',
                    label: '二级 3-1',
                    children: [{
                        id: '12',
                        label: '三级 3-1-1'
                    }]
                }, {
                    id: '13',
                    label: '二级 3-2',
                    children: [{
                        id: '14',
                        label: '三级 3-2-1'
                    }]
                }]
            }],
            buttons: ['A', 'B'],
            select: {}
  		}
  	},
    methods: {
        selectItem(row) {
            console.log(row)
        },
        clickButton(index, row) {
            console.log(index)
            console.log(row)
        }
    }
  }
  </script>
  ```

  > 属性

  | 属性          | 类型    | 简介                                                 | 默认值 |
  | ------------- | ------- | ---------------------------------------------------- | ------ |
  | data          | Array   | 初始数据                                             | []     |
  | defaultSelect | Array   | 已选数据（一般用于多选模式，传入时对应数据默认选中） | []     |
  | singleCheck   | Boolean | 是否为单选模式                                       | true   |
  | showSearch    | Boolean | 是否显示搜索框                                       | false  |
  | props         | Object  | 数据渲染属性配置，同element-UI                       | {}     |
  | buttons       | Array   | 右侧按钮配置                                         | []     |
  | ...           | ...     | element-UI其他基础配置属性                           | -      |

  > 事件

  | 事件        | 简介         | 返回值                                                       | 示例                             |
  | ----------- | ------------ | ------------------------------------------------------------ | -------------------------------- |
  | v-model     | 选中数据     | 选中数据的内容                                               | 详见demo                         |
  | select      | 选中数据     | 选中数据的内容                                               | 详见demo                         |
  | clickButton | 列表右侧按钮 | 返回Object <br />index：按钮数据的索引  <br />value：按钮名称<br />row：按钮所属的条目数据 | {index: ..., value: .., row: {}} |

* **弹窗模式**

  * dt-tree-dialog
  * 以弹窗形式展示

  > 样例

  ```vue
  // projects/demo/src/views/demos/tree/index.vue
  
  <template>
    <dt-single-page-view>
        <el-button @click="visible = true">树形结构弹窗</el-button>
        <dt-tree-dialog
            :title="'树形结构弹窗'"
            :data="data"
            :visible.sync="visible"
            @select="select"
        />
        <div class="data">已选：{{JSON.stringify(selectData)}}</div>
  	</dt-single-page-view>
  </template>
  
  <script>
  export default {
  	name: 'treePage',
  	data() {
        return {
            data: [{
                label: '一级 1',
                id: '1',
                children: [{
                    id: '2',
                    label: '二级 1-1',
                    children: [{
                        id: '3',
                        label: '三级 1-1-1'
                    }]
                }]
            }, {
                id: '4',
                label: '一级 2',
                children: [{
                    id: '5',
                    label: '二级 2-1',
                    children: [{
                        id: '6',
                        label: '三级 2-1-1'
                    }, {
                        id: '7',
                        label: '三级 2-1-2'
                    }]
                }, {
                    id: '8',
                    label: '二级 2-2',
                    children: [{
                        id: '9',
                        label: '三级 2-2-1'
                    }]
                }]
            }, {
                label: '一级 3',
                id: '10',
                children: [{
                    id: '11',
                    label: '二级 3-1',
                    children: [{
                        id: '12',
                        label: '三级 3-1-1'
                    }]
                }, {
                    id: '13',
                    label: '二级 3-2',
                    children: [{
                        id: '14',
                        label: '三级 3-2-1'
                    }]
                }]
            }],
            selectData: {},
            visible: false
  		}
  	},
    methods: {
        select(event) {
            if(event.cancel) return
            this.visible = false
            this.selectData = event
        }
    }
  }
  </script>
  ```

  > 属性

  | 属性    | 类型    | 简介              | 默认值 |
  | ------- | ------- | ----------------- | ------ |
  | title   | String  | 弹窗标题          | ""     |
  | visible | Boolean | 是否展示弹窗      | ""     |
  | ...     | ...     | dt-tree的所有属性 | -      |

  > 事件

  | 事件        | 简介         | 返回值                                                       | 示例                             |
  | ----------- | ------------ | ------------------------------------------------------------ | -------------------------------- |
  | select      | 弹窗按钮     | 点击确定时返回选中元素  <br />点击取消时返回对象：{ cancel: true } | 详见demo                         |
  | clickButton | 列表右侧按钮 | 返回Object <br />index：按钮数据的索引  <br />value：按钮名称<br />row：按钮所属的条目数据 | {index: ..., value: .., row: {}} |
  
> 1. 单选模式时弹窗底部没有按钮，点击条目直接触发select回调
  >
  > 2. 多选模式时点击弹窗底部确定按钮时触发select回调

* **输入框模式**

  * dt-tree-input
  * 渲染输入框，点击输入框时以弹窗形式展示

  > 样例

  ```vue
  // projects/demo/src/views/demos/tree/index.vue
  
  <template>
    <dt-single-page-view>
        <dt-tree-input
            :title="'树形结构弹窗+输入框'"
            :data="data"
            :defaultSelect="selectData"
            @select="select"
        />
  	</dt-single-page-view>
  </template>
  
  <script>
  export default {
  	name: 'treePage',
  	data() {
        return {
            data: [{
                label: '一级 1',
                id: '1',
                children: [{
                    id: '2',
                    label: '二级 1-1',
                    children: [{
                        id: '3',
                        label: '三级 1-1-1'
                    }]
                }]
            }, {
                id: '4',
                label: '一级 2',
                children: [{
                    id: '5',
                    label: '二级 2-1',
                    children: [{
                        id: '6',
                        label: '三级 2-1-1'
                    }, {
                        id: '7',
                        label: '三级 2-1-2'
                    }]
                }, {
                    id: '8',
                    label: '二级 2-2',
                    children: [{
                        id: '9',
                        label: '三级 2-2-1'
                    }]
                }]
            }, {
                label: '一级 3',
                id: '10',
                children: [{
                    id: '11',
                    label: '二级 3-1',
                    children: [{
                        id: '12',
                        label: '三级 3-1-1'
                    }]
                }, {
                    id: '13',
                    label: '二级 3-2',
                    children: [{
                        id: '14',
                        label: '三级 3-2-1'
                    }]
                }]
            }],
            selectData: {}
  		}
  	},
    methods: {
        select(event) {
            if(event.cancel) return
            this.select = event
        }
    }
  }
  </script>
  ```

  > 属性

  | 属性        | 类型   | 简介              | 默认值 |
  | ----------- | ------ | ----------------- | ------ |
  | title       | String | 弹窗标题          | ""     |
  | placeholder | String | 占位文字          | ""     |
  | ...         | ...    | dt-tree的所有属性 | -      |

  > 事件

  | 事件        | 简介         | 返回值                                                       | 示例                             |
  | ----------- | ------------ | ------------------------------------------------------------ | -------------------------------- |
  | select      | 弹窗按钮     | 点击确定时返回选中元素<br />点击取消时返回对象：{ cancle: true } | 详见demo                         |
  | clickButton | 列表右侧按钮 | 返回Object <br />index：按钮数据的索引  <br />value：按钮名称<br />row：按钮所属的条目数据 | {index: ..., value: .., row: {}} |
  

**2.6 其他**

* **弹窗**

  * dt-dialog
  * 内置弹窗样式，内置弹窗底部按钮，按钮可自定义

  > 样例

  ```vue
  // projects/demo/src/views/demos/welcome/index.vue
  
  <template>
    <dt-dialog title="提示" :border="true" :visible.sync="dialogShow">
        <div style="height:1000px; background: #cccccc">弹窗内置最小高度、最大高度，高度超出时内容体可滚动</div>
  	</dt-dialog>
  </template>
  
  <script>
  export default {
  	name: 'welcome',
  	data() {
        return {
            dialogShow: false
        }
  	}
  }
  </script>
  ```

  > 属性

  | 属性       | 类型    | 简介                   | 默认值 |
  | ---------- | ------- | ---------------------- | ------ |
  | visible    | Boolean | 是否显示               | false  |
  | title      | String  | 弹窗标题               | ""     |
  | border     | Boolean | 标题底部是否显示分割线 | false  |
  | autoHide   | Boolean | 点击按钮是否自动关闭   | true   |
  | buttonView | Boolean | 是否自定义底部按钮区域 | false  |

  > 事件

  | 事件    | 简介     | 返回值 | 示例 |
  | ------- | -------- | ------ | ---- |
  | confirm | 确认按钮 | -      | -    |
  | cancel  | 取消按钮 | -      | -    |

  > 插槽

  | 插槽名     | 简介                                    | 数据 | 示例 |
  | ---------- | --------------------------------------- | ---- | ---- |
  | buttonView | 弹窗底部按钮区域，buttonView=true时可用 | -    | -    |

* **分页**

  * dt-pagination

  > 样例

  ```vue
  // projects/demo/src/views/demos/table/index.vue
  
  <template>
    ...
    <dt-pagination 
        :hidden="pagination.total == 0"
        :total="pagination.total"
        :pageSize="pagination.pageSize"
        :currentPage="pagination.currentPage"
        @sizeChange="sizeChange"
        @currentChange="currentChange"
    />
  </template>
  
  <script>
  export default {
    name: "tablePage",
    data() {
        return {
            pagination: {
                total: 20,
                pageSize: 10,
                currentPage: 1
            }
        }
    },
    methods: {
        sizeChange(event) {
            console.log(event)
        },
        currentChange(event) {
            console.log(event)
        },
        ...
    }
  }
  </script>
  ```

  > 属性

  | 属性        | 类型    | 简介                         | 默认值                                   |
  | ----------- | ------- | ---------------------------- | ---------------------------------------- |
  | total       | Number  | 总条数                       | null                                     |
  | currentPage | Number  | 当前页码                     | 1                                        |
  | pageSize    | Number  | 每页条数                     | 10                                       |
  | pageSizes   | Array   | 切换每页条数的选项           | [10, 20, 30, 50]                         |
  | layout      | String  | 展示样式（详见element-UI）   | "total, size, prev, pager, next, jumper" |
  | background  | Boolean | 是否为分页按钮添加背景色     | true                                     |
  | autoScroll  | Boolean | 换页后是否自动将页面移至顶部 | true                                     |
  | hidden      | Boolean | 是否隐藏                     | false                                    |
  | left        | Boolean | 是否居左                     | false                                    |

  > 事件

  | 事件          | 简介         | 返回值                           | 示例                                |
  | ------------- | ------------ | -------------------------------- | ----------------------------------- |
  | sizeChange    | 切换每页条数 | Object对象（当前页码、每页条数） | { currentPage: ..., pageSize: ... } |
  | currentChange | 切换当前页码 | Object对象（当前页码、每页条数） | { currentPage: ..., pageSize: ... } |

* **svg图标**

  * dt-svg-icon
  * 内置自定义icon图标，与emelent-UI提供的图标不冲突，属于扩展资源

  > 样例

  ```vue
  // projects/demo/src/views/demos/other/index.vue
  
  <template>
    ...
    <dt-svg-icon icon-class="search" />
    ...
  </template>
  ```

  > 属性

  | 属性      | 类型   | 简介                                           | 默认值 |
  | --------- | ------ | ---------------------------------------------- | ------ |
  | iconClass | String | 图标文件名（必传）                             | null   |
  | className | String | svg元素的扩展class名，用于页面中编写自定义样式 | " "    |


#### 3. 通用工具

​	项目提供了部分常用的工具方法，已内置于脚手架中。在开发过程中可根据需求进行选择使用，以下为各工具方法

* **基础工具**（调用方式：this.$utils.base.xxx）

  * scrollTop：滑动至页面顶部
  * parseTime：解析时间
    * 参数1：time（date - Object|String|Number）
    * 参数2：cFormat（String）（可不传）
      * 默认值：“{y}-{m}-{d} {h}:{i}:{s}”
      * 可识别内容为 {y}、{m}、{d}、{h}、{i}、{s}、{a}，分别对应年、月、日、时、分、秒、周，其中周为大写汉字（一、二、...、六、日）
      * 比如 this.$utils.base.parseTime(*时间戳*，*“{y}-{m}-{d} {h}:{i}:{s} 周{a}”*) 调用后返回内容为：年-月-日 时:分:秒 周a
    * 返回：String
  * formatTime：格式化时间
    * 参数1：time（date - Number）
    * 参数2：cFormat（String）（可不传）
    * 返回：String
    * 补充说明：该方法会对比当前时间，距当前时间1天内时动态返回“刚刚”、“x分钟前”、“x小时前”、“一天前”；若超出1天则返回“xx月xx日xx时xx分”，若传入cFormat则会调用解析时间方法parseTime，按照配置的字符串格式进行返回
  * creatUniqueString：生成32位随机数
    * 返回：String
  * bytrLength：获取字节长度
    * 参数：String
    * 返回：Number
  
* **验证工具**（调用方式：this.$utils.validate.xxx）

  > 除isArray外各方法参数均为String，所有方法返回均为Boolean

  * isString：字符串格式
  * isArray：数组格式
  * isURL：URL地址
  * isEmail：邮箱
  * isExternal：外链
  * isLowerCase：小写字母
  * isUpperCase：大写字母
  * isAlphabets：英文字母
  * isSpecialCharacter：特殊字符

* **语言环境**（调用方式：this.$utils.language.xxx）

  * get：获取当前语言环境
  * change：切换语言环境

* **消息通知**（调用方式：this.$utils.notice.xxx）

  > 方法均在内部使用，暂不列出

* **身份认证信息**（调用方式：this.$utils.auth.xxx）

  > 部分方法在内部使用，暂不列出

  * getToken：获取用户token
  * getUserName：获取用户名
  * getAdminheader：获取请求头认证信息
    * 返回：Object
    * 补充说明：多用于文件上传配置header信息

* **权限校验**（调用方式：this.$checkPermission）

  * 判断用户权限，多用于按钮权限配置等
  * 样例：this.$checkPermission(['security：menu：save'])



### 四、迁移指南

#### 1. 注意事项

* **名词解释**
  * 项目名词
    * 基座
      * 整个平台的入口
    * 框架项目
      * 页面整体布局结构
    * 通用业务项目
      * 所有DT平台基础业务
    * demo项目
      * 目录结构、公共组件、公共能力等代码样例
  * 技术名词
    * 项目注册表
      * **root_html/registry/singleSpa_projects.json**，声明子项目包地址，用于向基座中注册应用
    * 项目前缀名
      * **projects/xxx/.env.development && projects/xxx/.env.production**，声明子项目前缀名称，与项目注册表中声明的子项目名保持一致，用于基座根据URL前缀匹配加载子项目
    * 代理服务
      * **root_html/serve/config.js**，配置代理服务，用于开发调试，解决跨域等问题，配置方式同原项目vue.config.js中的proxy
    * .....
* **基于脚手架开发**
  * 框架项目与通用业务项目内置于基座中，开发时无需再额外启动这两个项目的服务
  * 此文档和**projects/demo**中几乎包含了各公共能力的代码样例，务必先学习理解后进行开发
  * 建议复制整个demo项目，而后在新拷贝的项目中开发
* **创建独立仓库**
  * deepCloud-cli由DT开发团队维护，供所有业务团队借鉴使用。非DT团队开发人员不可更改。
  * 业务团队应将deepCloud-cli拷贝后创建独立仓库进行开发。

#### 2. 迁移步骤

* **项目角度**

  1. 复制demo项目，在projects文件夹下与demo项目同级粘贴新项目，重命名为实际项目名
  2. 修改**package.json**，将name改为实际项目名，修改服务启动的端口号，demo项目端口号为13579，根据自身情况调整，保证不与其他本地启动的服务重复即可（scripts.serve字段 “vue-cli-service serve --port 13579”）
  3. 修改**.env.xxxxx**两个文件中的**VUE_APP_BASE_NAME**字段，值改为项目名，**src/router/prefix,js**中的取值来自于此，该值即项目前缀名
  4. 修改**root_html/registry/singleSpa_projects.json**，仿照demo项目的声明写法添加自身项目，key为实际项目名，值为项目包地址

* **页面角度**

  1. 根据实际页面中的目录结构在**src/views**中创建页面文件，将老项目中的页面文件复制粘贴到新文件中，可以仍保持vue与js分离，也可以vue与js在同一个.vue文件中（参考demo项目中的page页面）

  2. 调整**template**中内容

     1）将最外层class名为“app-container”、“app-card”、“app-card-body”的三层div改为单视图组件或多视图组件，具体参考demo

     2）分页、树形结构、穿梭框、表单等组件替换为新的通用组件，用法参考demo及技术文档

  3. 调整**script**中内容（js文件）

     1）移除多余import，理论上通用组件、通用工具类、网络请求等替换后可删除80%-100%的import声明

     2）调整业务中部分方法调用

  4. 创建网络接口方法

     1）老的请求方法全部摒弃，务必按照demo中的方式创建新的网络接口模块

     2）注意**src/service**中目录结构、声明方式写法等

     3）在**script**(js文件)中替换所有网络请求方法 [ import Request from "@/service" ] [ Request.xxx.xxx().then(...).catch(...) ]

  5. 创建国际化配置文件

     1）在**src/i18n**中创建页面使用的国际化参数，注意目录结构、声明方式写法等

     2）最外层**common/lang**中已内置大部分通用国际化参数，仅声明页面自身使用的其他数据即可

     2）在**template**中修改各$t(...)声明，参考demo与文档

  6. 调试页面，根据实际情况进行细节优化调整

* **补充**

  * 老项目中**style**内常包含 .app-container{...} 样式布局代码，此块代码基本无用可直接删除，删除时注意是否会影响页面，若确实产生变化则根据实际情况调整
  * 老项目中分页组件将接口请求业务代码写在了组件中，需要结合老代码将对应逻辑迁移到页面文件中，此处与老项目中使用方式略有差异，其他组件同理。
  * 如遇其他特殊情况解决不了可与 @卜文豪 取得联系请求协助
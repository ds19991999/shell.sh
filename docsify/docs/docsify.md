> GitHub: https://github.com/docsifyjs/docsify/
> 文档： https://docsify.js.org

很简单，最主要的就是编写一个`index.html`。

GitHub Pages 支持从三个地方读取文件
```
docs/ 目录
master 分支
gh-pages 分支
```
对于docs目录，在设置页面开启 GitHub Pages 功能并选择 master branch /docs folder 选项。

```html
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <meta charset="UTF-8">
  <link rel="stylesheet" href="//unpkg.com/docsify/themes/vue.css">
</head>
<body>
  <div id="app"></div>
  <script>
    window.$docsify = {
      //...一些配置填在这里
    }
  </script>
  <script src="//unpkg.com/docsify/lib/docsify.min.js"></script>
</body>
</html>
```
## 配置
就拿常用的说，不常用的没必要看了。
### repo
```
repo: 'docsifyjs/docsify',
// or
repo: 'https://github.com/docsifyjs/docsify/'	
```
### 自定义导航栏
```
// 加载 _navbar.md
loadNavbar: true,
or
// 自定义文件名加载 nav.md
loadNavbar: 'nav.md'
```
`_navbar.md`文件内容：
```
- Translations
  - [:uk: English](/)
  - [:cn: 中文](/zh-cn/)
  - [:de: Deutsch](/de-de/)
  - [:es: Spanish](/es/)
  - [:ru: Russian](/ru/)
```
效果：
![](https://image.creat.kim/picgo/20190423200700.png)

### 左侧栏
自动渲染文档标题为目录。
```
// 加载 _sidebar.md
loadSidebar: true,
or
// 加载 summary.md
loadSidebar: 'summary.md'
```
`_sidebar.md`文件内容
```
- [Home](/)
- [Supported functions](supported.md)
- [Support table](support-table.md)
- [mermaid](mermaid.md)
- [Markdown in LaTeX](md-in-latex.md)
```
效果：
![](https://image.creat.kim/picgo/20190423201019.png)

同时设置autoHeader的话会为每个页面增加标题，建议同时配置
```
loadSidebar: true
autoHeader: true
```

### 首页文件路径
默认：`README.md` , 一般就用`README.md`作为
```
// 入口文件改为 /home.md
homepage: 'home.md',
or
homepage:
  'https://raw.githubusercontent.com/docsifyjs/docsify/master/README.md'
```

启动封面页
```
coverpage: true,

// 自定义文件名
coverpage: 'cover.md',

// mutiple covers
coverpage: ['/', '/zh-cn/'],

// mutiple covers and custom file name
coverpage: {
  '/': 'cover.md',
  '/zh-cn/': 'cover.md'
}
```
封面用法`_coverpage.md`
```
![logo](_media/icon.svg)

# docsify

> A magical documentation site generator.

* Simple and lightweight (~12kb gzipped)
* Multiple themes
* Not build static html files

[GitHub](https://github.com/docsifyjs/docsify/)
[Get Started](#quick-start)
```

### 文档根目录
```
basePath: '/path/',
or
// 直接渲染其他域名的文档
basePath: 'https://docsify.js.org/',
or
// 甚至直接渲染其他仓库
basePath:
  'https://raw.githubusercontent.com/ryanmcdermott/clean-code-javascript/master/'
```

### logo
侧边栏中出现的网站图标
```
logo: '/_media/icon.svg'
```
### 文档标题
侧边栏顶部
```
name: 'docsify',
nameLink: '/',

or

// 按照路由切换
nameLink: {
  '/zh-cn/': '/zh-cn/',
  '/': '/'
}
```

### 主题色调
```
themeColor: '#3F51B5'
```

### 小屏设备合并导航栏和侧边栏
```
mergeNavbar: true
```

### 显示文档更新日期
```
formatUpdated: '{YYYY}-{MM}-{DD} {HH}:{mm}'
```

### 语言列表
```
fallbackLanguages: ['zh-cn', 'en']
```

## 主题
目前提供五套主题可供选择
```
<link rel="stylesheet" href="//unpkg.com/docsify/themes/vue.css">
<link rel="stylesheet" href="//unpkg.com/docsify/themes/buble.css">
<link rel="stylesheet" href="//unpkg.com/docsify/themes/dark.css">
<link rel="stylesheet" href="//unpkg.com/docsify/themes/pure.css">
<link rel="stylesheet" href="//unpkg.com/docsify/themes/dolphin.css">
```
压缩版
```
<link rel="stylesheet" href="//unpkg.com/docsify/lib/themes/vue.css">
<link rel="stylesheet" href="//unpkg.com/docsify/lib/themes/buble.css">
<link rel="stylesheet" href="//unpkg.com/docsify/lib/themes/dark.css">
<link rel="stylesheet" href="//unpkg.com/docsify/lib/themes/pure.css">
<link rel="stylesheet" href="//unpkg.com/docsify/lib/themes/dolphin.css">
```

第三方主题插件
* [Link](https://jhildenbiddle.github.io/docsify-themeable/#/introduction)

```
<script src="https://cdn.jsdelivr.net/npm/docsify-themeable@0"></script>
```

## 插件
谷歌统计
```
<script>
  window.$docsify = {
    ga: 'UA-XXXXX-Y'
  }
</script>
<script src="//unpkg.com/docsify"></script>
<script src="//unpkg.com/docsify/lib/plugins/ga.js"></script>
```
精准emoji
```
<script src="//unpkg.com/docsify/lib/plugins/emoji.js"></script>
```
引入外链脚本
```
<script src="//unpkg.com/docsify/lib/plugins/external-script.js"></script>
```
图片缩放
```
<script src="//unpkg.com/docsify/lib/plugins/zoom-image.js"></script>
```
添加在GitHub上编辑按钮
```
<script src="//unpkg.com/docsify-edit-on-github/index.js"></script>
plugins: [
  EditOnGithubPlugin.create('https://github.com/njleonzhang/vue-data-tables/blob/master/docs/')
  ]
```
代码块复制到剪贴板
```
<script src="//unpkg.com/docsify-copy-code"></script>
```
Disqus
```
disqus: 'shortname'
<script src="//unpkg.com/docsify/lib/plugins/disqus.min.js"></script>
```
Gitalk
```
<link rel="stylesheet" href="//unpkg.com/gitalk/dist/gitalk.css">
<script src="//unpkg.com/docsify/lib/plugins/gitalk.min.js"></script>
<script src="//unpkg.com/gitalk/dist/gitalk.min.js"></script>
<script>
  const gitalk = new Gitalk({
    clientID: 'Github Application Client ID',
    clientSecret: 'Github Application Client Secret',
    repo: 'Github repo',
    owner: 'Github repo owner',
    admin: ['Github repo collaborators, only these guys can initialize github issues'],
    // facebook-like distraction free mode
    distractionFreeMode: false
  })
</script>
```
分页导航
```
<script src="//unpkg.com/docsify/lib/docsify.min.js"></script>
<script src="//unpkg.com/docsify-pagination/dist/docsify-pagination.min.js"></script>
```
代码高亮
```
<script src="//unpkg.com/docsify"></script>
<script src="//unpkg.com/prismjs/components/prism-bash.js"></script>
<script src="//unpkg.com/prismjs/components/prism-php.js"></script>
<script src="//unpkg.com/prismjs/components/prism-python.js"></script>
<script src="//unpkg.com/prismjs/components/prism-python.js"></script>
<script src="//unpkg.com/prismjs/components/prism-go.js"></script>
```

## 在线编辑和预览Vue
```
<script src="//unpkg.com/vue/dist/vue.min.js"></script>
<script src="//unpkg.com/vuep/dist/vuep.min.js"></script>
<script src="//unpkg.com/docsify/lib/docsify.min.js"></script>
```
 示例
```
 # Vuep 使用

<vuep template="#example"></vuep>

<script v-pre type="text/x-template" id="example">
  <template>
    <div>Hello, {{ name }}!</div>
  </template>

  <script>
    module.exports = {
      data: function () {
        return { name: 'Vue' }
      }
    }
  </script>
</script>
```

## 离线模式
依赖`sw.js`文件
```
 <script>
  if (typeof navigator.serviceWorker !== 'undefined') {
    navigator.serviceWorker.register('sw.js')
  }
</script>
```
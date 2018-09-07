<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
       <div class="media">
           <a href="/user/{{.User.Username}}"><img src="{{.User.Avatar}}" class="avatar" alt="{{.User.Username}}"></a>  
       </div>
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>{{.PageTitle}}</title>
  <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css"/>
  <link rel="stylesheet" href="/static/css/pybbs.css">
  <script src="//cdn.bootcss.com/jquery/2.2.2/jquery.min.js"></script>
  <script src="//cdn.bootcss.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
  <p> 
  <img src="/static/imgs/pic1.jpg" width="100%" height="100%"/> 
  </p>
<body>
<div class="wrapper">

  <nav class="navbar navbar-inverse">
    <div class="container">

      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" style="color:#fff;" href="/">GO首页</a>
      </div>
      <div id="navbar" class="navbar-collapse collapse header-navbar">
        <ul class="nav navbar-nav navbar-right">
          <li>
            <a href="/about">关于</a>
          </li>
          {{if .IsLogin}}
          <li>
            <a href="/user/{{.UserInfo.Username}}">
              {{.UserInfo.Username}}
            </a>
          </li>
          <li>
            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"
               data-hover="dropdown">
              设置
              <span class="caret"></span>
            </a>
            <span class="dropdown-arrow"></span>
            <ul class="dropdown-menu">
              <li><a href="/user/setting">个人资料</a></li>

              <li><a href="/logout">退出</a></li>
            </ul>
          </li>
          {{else}}
          <li><a href="/login">后台管理</a></li>
          {{end}}
        </ul>
      </div>

    </div>
  </nav>

  <div class="container">
    {{.LayoutContent}}
  </div>

</div>

<div class="container">
  <br>
  <br>
</div>
<p> 
 </p>  
</body>
</html>
<%@ page contentType="text/html; charset=utf-8" %>   
<%@ page language="java" %>
<%@ page import="com.mysql.jdbc.Driver" %>
<% String user;
try{user=session.getAttribute("user").toString();}
catch(Exception e){user="";}%>
<html lang="zh-CN">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
  <title>Outlook购书商店</title>

  <!-- Bootstrap -->
  <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

  <!-- HTML5 shim 和 Respond.js 是为了让 IE8 支持 HTML5 元素和媒体查询（media queries）功能 -->
  <!-- 警告：通过 file:// 协议（就是直接将 html 页面拖拽到浏览器中）访问页面时 Respond.js 不起作用 -->
  <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
    .row{
        max-width: 1000px;
        margin-left: auto;
        margin-right: auto;
    }
    .bs-docs-footer {
        padding-top: 50px;
        padding-bottom: 50px;
        margin-top: 100px;
        color: #99979c;
        text-align: center;
        background-color: #2a2730;
    }

    </style>
</head>

<body>
  
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <nav class="navbar navbar-default navbar-static-top">
      <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
            aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="detail.jsp"><img alt="Outlook购书商店" src="img/outlook_s.png"/></a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav">
            <li>
              <a href="index.jsp">Outlook购书商店</a>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">图书分类
                <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
                <li>
                  <a href="http://localhost:8083/outlook/class.jsp?classification=1">小说</a>
                </li>
                <li>
                  <a href="http://localhost:8083/outlook/class.jsp?classification=2">科技</a>
                </li>
                <li>
                  <a href="http://localhost:8083/outlook/class.jsp?classification=3">人文社科</a>
                </li>
                <li>
                  <a href="http://localhost:8083/outlook/class.jsp?classification=4">经管</a>
                </li>
                <li>
                  <a href="http://localhost:8083/outlook/class.jsp?classification=5">励志</a>
                </li>
              </ul>
            </li>
          </ul>
          <form class="navbar-form navbar-left">
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Search">
            </div>
            <button type="submit" class="btn btn-default">搜索</button>
          </form>
          <ul class="nav navbar-nav navbar-right">
            <li>
              <a href="cart.jsp">购物车</a>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">我的账户
                <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
                <li>
                  <a href="check_orders.jsp">查看订单</a>
                </li>
                <li>
                  <a href="change_password.jsp">修改密码</a>
                </li>
                <%
                if(user==null||user.equals("")) out.print("<li><a href=\"login.jsp\">登陆</a></li>");
                else{
                  out.print("<li><a href=\"http://localhost:8083/outlook/Logout\">注销 "+user+"</a></li>");
                }
                %>
              </ul>
            </li>
            <li>
              <a href="manage/order.jsp">管理系统</a>
            </li>
          </ul>
        </div>
        <!-- /.navbar-collapse -->
      </div>
      <!-- /.container-fluid -->
    </nav>
    <iframe frameborder="0" scrolling="no" src="img_show.html" width="100%" height="400px"></iframe>
    <nav aria-label="...">
        <ul class="pager">
            <li id="s1"><a>小说</a></li>
            <li id="s2"><a>科技</a></li>
            <li id="s3"><a>人文社科</a></li>
            <li id="s4"><a>经管</a></li>
            <li id="s5"><a>励志</a></li>
        </ul>
    </nav>
    <div class="row">
      <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
          <img id="i1" style="width: 150px; height: 200px; display: block;" alt="100%x200" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMjQyIDIwMCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSBtZWV0IiB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvMTAwJXgyMDAKQ3JlYXRlZCB3aXRoIEhvbGRlci5qcyAyLjYuMC4KTGVhcm4gbW9yZSBhdCBodHRwOi8vaG9sZGVyanMuY29tCihjKSAyMDEyLTIwMTUgSXZhbiBNYWxvcGluc2t5IC0gaHR0cDovL2ltc2t5LmNvCi0tPjxkZWZzPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+I2hvbGRlcl8xNjMyZTcwNThhZSB0ZXh0IHsgZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEycHQgfSA8L3N0eWxlPjwvZGVmcz48ZyBpZD0iaG9sZGVyXzE2MzJlNzA1OGFlIj48cmVjdCBmaWxsPSIjZWVlZWVlIiB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCIgLz48Zz48dGV4dCB4PSI4OS44NSIgeT0iMTA1LjUyIj4yNDJ4MjAwPC90ZXh0PjwvZz48L2c+PC9zdmc+" data-src="holder.js/150x200" data-holder-rendered="true">
          <div class="caption">
            <h3 id="ht1">Thumbnail label</h3>
            <p id="p1">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a id="b1" class="btn btn-primary" role="button" href="#">加入购物车</a> <a id="d1" href="#" class="btn btn-default" role="button">查看详细</a></p>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
          <img id="i2" style="width: 150px; height: 200px; display: block;" alt="100%x200" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMjQyIDIwMCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSBtZWV0IiB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvMTAwJXgyMDAKQ3JlYXRlZCB3aXRoIEhvbGRlci5qcyAyLjYuMC4KTGVhcm4gbW9yZSBhdCBodHRwOi8vaG9sZGVyanMuY29tCihjKSAyMDEyLTIwMTUgSXZhbiBNYWxvcGluc2t5IC0gaHR0cDovL2ltc2t5LmNvCi0tPjxkZWZzPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+I2hvbGRlcl8xNjMyZTcwOTY1MyB0ZXh0IHsgZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEycHQgfSA8L3N0eWxlPjwvZGVmcz48ZyBpZD0iaG9sZGVyXzE2MzJlNzA5NjUzIj48cmVjdCBmaWxsPSIjZWVlZWVlIiB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCIgLz48Zz48dGV4dCB4PSI4OS44NSIgeT0iMTA1LjUyIj4yNDJ4MjAwPC90ZXh0PjwvZz48L2c+PC9zdmc+" data-src="holder.js/150x200" data-holder-rendered="true">
          <div class="caption">
            <h3 id="ht2">Thumbnail label</h3>
            <p id="p2">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a id="b2" class="btn btn-primary" role="button" href="#">加入购物车</a> <a id="d2" href="#" class="btn btn-default" role="button">查看详细</a></p>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
          <img id="i3" style="width: 150px; height: 200px; display: block;" alt="100%x200" src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMjQyIDIwMCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSBtZWV0IiB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvMTAwJXgyMDAKQ3JlYXRlZCB3aXRoIEhvbGRlci5qcyAyLjYuMC4KTGVhcm4gbW9yZSBhdCBodHRwOi8vaG9sZGVyanMuY29tCihjKSAyMDEyLTIwMTUgSXZhbiBNYWxvcGluc2t5IC0gaHR0cDovL2ltc2t5LmNvCi0tPjxkZWZzPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+I2hvbGRlcl8xNjMyZTcwOTgwMiB0ZXh0IHsgZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEycHQgfSA8L3N0eWxlPjwvZGVmcz48ZyBpZD0iaG9sZGVyXzE2MzJlNzA5ODAyIj48cmVjdCBmaWxsPSIjZWVlZWVlIiB3aWR0aD0iMjQyIiBoZWlnaHQ9IjIwMCIgLz48Zz48dGV4dCB4PSI4OS44NSIgeT0iMTA1LjUyIj4yNDJ4MjAwPC90ZXh0PjwvZz48L2c+PC9zdmc+" data-src="holder.js/150x200" data-holder-rendered="true">
          <div class="caption">
            <h3 id="ht3">Thumbnail label</h3>
            <p id="p3">Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a id="b3" class="btn btn-primary" role="button" href="#">加入购物车</a> <a id="d3" href="#" class="btn btn-default" role="button">查看详细</a></p>
          </div>
        </div>
      </div>
    </div>
    <div style="max-width:300px;margin-left:auto;margin-right:auto;" align="center">
      <button class="btn btn-lg btn-default" type="button" id="more">查看更多</button>
    </div>
    <br/>
</body>
<script>
    function PageLoad(){
      $("#s1").trigger('click');
    }
    window.onload=PageLoad;
</script>
<script>
    $("#s1").click(function(){
      $.get("http://localhost:8083/outlook/GetItem?classification=1", function(result){
        /* var html="";
         for(var i=0;i<result.length;i++){
            html+=result[i].isbn+"\n";
        } 
        alert(html); */
        $("#ht1").html(result[0].name);
        $("#ht2").html(result[1].name);
        $("#ht3").html(result[2].name);
        $("#p1").html("作者："+result[0].author+"<br/>价格："+result[0].price);
        $("#p2").html("作者："+result[1].author+"<br/>价格："+result[1].price);
        $("#p3").html("作者："+result[2].author+"<br/>价格："+result[2].price);
        $("#i1").attr("src", "itemImg/"+result[0].isbn+".jpg");
        $("#i2").attr("src", "itemImg/"+result[1].isbn+".jpg");
        $("#i3").attr("src", "itemImg/"+result[2].isbn+".jpg");
        $("#d1").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[0].isbn);
        $("#d2").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[1].isbn);
        $("#d3").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[2].isbn);
        $("#b1").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[0].isbn);
        $("#b2").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[1].isbn);
        $("#b3").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[2].isbn);
      },"json");
    });
    $("#s2").click(function(){
      $.get("http://localhost:8083/outlook/GetItem?classification=2", function(result){
        $("#ht1").html(result[0].name);
        $("#ht2").html(result[1].name);
        $("#ht3").html(result[2].name);
        $("#p1").html("作者："+result[0].author+"<br/>价格："+result[0].price);
        $("#p2").html("作者："+result[1].author+"<br/>价格："+result[1].price);
        $("#p3").html("作者："+result[2].author+"<br/>价格："+result[2].price);
        $("#i1").attr("src", "itemImg/"+result[0].isbn+".jpg");
        $("#i2").attr("src", "itemImg/"+result[1].isbn+".jpg");
        $("#i3").attr("src", "itemImg/"+result[2].isbn+".jpg");
        $("#d1").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[0].isbn);
        $("#d2").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[1].isbn);
        $("#d3").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[2].isbn);
        $("#b1").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[0].isbn);
        $("#b2").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[1].isbn);
        $("#b3").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[2].isbn);
      },"json");
    });
    $("#s3").click(function(){
      $.get("http://localhost:8083/outlook/GetItem?classification=3", function(result){
        $("#ht1").html(result[0].name);
        $("#ht2").html(result[1].name);
        $("#ht3").html(result[2].name);
        $("#p1").html("作者："+result[0].author+"<br/>价格："+result[0].price);
        $("#p2").html("作者："+result[1].author+"<br/>价格："+result[1].price);
        $("#p3").html("作者："+result[2].author+"<br/>价格："+result[2].price);
        $("#i1").attr("src", "itemImg/"+result[0].isbn+".jpg");
        $("#i2").attr("src", "itemImg/"+result[1].isbn+".jpg");
        $("#i3").attr("src", "itemImg/"+result[2].isbn+".jpg");
        $("#d1").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[0].isbn);
        $("#d2").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[1].isbn);
        $("#d3").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[2].isbn);
        $("#b1").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[0].isbn);
        $("#b2").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[1].isbn);
        $("#b3").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[2].isbn);
      },"json");
    });
    $("#s4").click(function(){
      $.get("http://localhost:8083/outlook/GetItem?classification=4", function(result){
        $("#ht1").html(result[0].name);
        $("#ht2").html(result[1].name);
        $("#ht3").html(result[2].name);
        $("#p1").html("作者："+result[0].author+"<br/>价格："+result[0].price);
        $("#p2").html("作者："+result[1].author+"<br/>价格："+result[1].price);
        $("#p3").html("作者："+result[2].author+"<br/>价格："+result[2].price);
        $("#i1").attr("src", "itemImg/"+result[0].isbn+".jpg");
        $("#i2").attr("src", "itemImg/"+result[1].isbn+".jpg");
        $("#i3").attr("src", "itemImg/"+result[2].isbn+".jpg");
        $("#d1").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[0].isbn);
        $("#d2").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[1].isbn);
        $("#d3").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[2].isbn);
        $("#b1").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[0].isbn);
        $("#b2").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[1].isbn);
        $("#b3").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[2].isbn);
      },"json");
    });
    $("#s5").click(function(){
      $.get("http://localhost:8083/outlook/GetItem?classification=5", function(result){
        $("#ht1").html(result[0].name);
        $("#ht2").html(result[1].name);
        $("#ht3").html(result[2].name);
        $("#p1").html("作者："+result[0].author+"<br/>价格："+result[0].price);
        $("#p2").html("作者："+result[1].author+"<br/>价格："+result[1].price);
        $("#p3").html("作者："+result[2].author+"<br/>价格："+result[2].price);
        $("#i1").attr("src", "itemImg/"+result[0].isbn+".jpg");
        $("#i2").attr("src", "itemImg/"+result[1].isbn+".jpg");
        $("#i3").attr("src", "itemImg/"+result[2].isbn+".jpg");
        $("#d1").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[0].isbn);
        $("#d2").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[1].isbn);
        $("#d3").attr("href","http://localhost:8083/outlook/detail.jsp?isbn="+result[2].isbn);
        $("#b1").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[0].isbn);
        $("#b2").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[1].isbn);
        $("#b3").attr("href","http://localhost:8083/outlook/AddToChart?isbn="+result[2].isbn);
      },"json");
    });         
</script>

</html>
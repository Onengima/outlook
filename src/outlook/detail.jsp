<%@ page contentType="text/html; charset=utf-8" %>   
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
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
    .c{
      max-width: 800px;
      padding: 15px;
      margin: 0 auto;
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
    <div class="row">
    <%
    String isbn=request.getParameter("isbn");
	Connection conn;
	Statement sql=null;
	ResultSet rs=null;
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://139.199.155.77:3306/store?serverTimezone=UTC","root","john159753");
		sql=conn.createStatement();
		rs=sql.executeQuery("select * from book where isbn='"+isbn+"'");
    rs.next();
    out.print("<div class=\"panel panel-default c\">"+
    "<img style=\"width: 150px; height: 200px; display: block;\" alt=\"100%x200\" src=\"itemImg/"+isbn+".jpg\" data-src=\"holder.js/150x200\" data-holder-rendered=\"true\">"+
      "<div class=\"panel-body\">"+
      "<p>书名：《"+rs.getString(2)+"》</P>"+
      "<p>ISBN："+rs.getString(1)+"</P>"+
      "<p>作者："+rs.getString(3)+"</p>"+
      "<p>价格："+rs.getString(4)+"￥</p>"+
      "<p>出版社："+rs.getString(6)+"</p>"+
      "<p>简介："+"</p>"+
      "<p>"+rs.getString(5)+"</p><a class=\"btn btn-primary\" role=\"button\" href=\"http://localhost:8083/outlook/AddToChart?isbn="+isbn+"\">加入购物车</a></div></div>");
    	}
    	catch(SQLException e){
    		e.printStackTrace();
    	}
    	catch(ClassNotFoundException e){
            e.printStackTrace();
    	}
    %>
    </div>
    <br/>
     <div align="center" class="well well-lg" style="max-width:800px;margin-left: auto;
        margin-right: auto;">开发人员：2015081010陈嘉豪&nbsp;&nbsp;&nbsp;2015081070张期翔&nbsp;&nbsp;&nbsp;2015081007余展孝&nbsp;&nbsp;&nbsp;2015081008朱万堂</div>
</body>

</html>
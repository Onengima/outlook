<%@ page contentType="text/html; charset=utf-8" %>   
<%@ page language="java" %>
<%@ page import="java.sql.*"%>
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
    .jumbotron {
      max-width: 600px;
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
          <a class="navbar-brand" href="admin.jsp">Outlook管理系统</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav">
            <li>
              <a href="user.jsp">用户信息管理</a>
            </li>
            <li>
              <a href="book.jsp">图书信息管理</a>
            </li>
            <li>
              <a href="order.jsp">订单管理</a>
            </li>
          </ul>
        </div>
        <!-- /.navbar-collapse -->
      </div>
      <!-- /.container-fluid -->
    </nav>

<%
String name=request.getParameter("name");
String pwd=request.getParameter("pwd");
Connection con;
Statement sql;
ResultSet rs;
try{Class.forName("com.mysql.jdbc.Driver").newInstance();}
catch(Exception e){out.print(e);}
try{
    String uri="jdbc:mysql://139.199.155.77:3306/store?serverTimezone=UTC";
    con=DriverManager.getConnection(uri,"root","john159753");
    sql=con.createStatement();
    rs=sql.executeQuery("SELECT password FROM admin where username='"+name+"'");
    if(rs.next()){
        if(pwd.equals(rs.getString("password"))){
            out.println("<div class=\"jumbotron\"><h1>登陆成功!</h1><p><a class=\"btn btn-primary btn-lg\" href=\"admin.jsp\" role=\"button\">点击返回</a></p></div>");
            session.setAttribute("admin",name);
        }
        else out.println("<div class=\"jumbotron\"><h1>登陆失败!</h1><p>密码错误</p><p><a class=\"btn btn-primary btn-lg\" href=\"login.jsp\" role=\"button\">点击重新登陆</a></p></div>");
    }
    else out.println("<div class=\"jumbotron\"><h1>登陆失败!</h1><p>账号不存在</p><p><a class=\"btn btn-primary btn-lg\" href=\"login.jsp\" role=\"button\">点击重新登陆</a></p></div>");
    con.close();
}
catch(SQLException e1){out.print(e1);}
%>
    

</body>

</html>
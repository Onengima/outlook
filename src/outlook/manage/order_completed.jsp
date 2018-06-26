<%@ page contentType="text/html; charset=utf-8" %>   
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html lang="zh-CN">

<% String admin;
try{admin=session.getAttribute("admin").toString();}
catch(Exception e){admin="";}
if(admin==null||admin.equals("")) {
    	response.sendRedirect("login.jsp");
    }%>

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
    .bs-example{
        max-width: 800px;
        margin-left: auto;
        margin-right: auto;
    }
    .form-signin {
      max-width: 330px;
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

    <div class="container">

      <form class="form-signin" method="post" action="order_detail.jsp">
        <h2 class="form-signin-heading">输入要修改的订单号</h2>
        <label class="sr-only" for="inputEmail">订单号</label>
        <input class="form-control" id="inputEmail" autofocus required type="text" placeholder="订单号" name="id">
        <br/>
        <button class="btn btn-lg btn-primary btn-block" type="submit">查找订单</button>
    </form>

    <nav aria-label="...">
        <ul class="pager">
            <li><a href="order.jsp">全部</a></li>
            <li><a href="order_undelivered.jsp">未发货</a></li>
            <li><a href="order_delivered.jsp">已发货</a></li>
            <li><a href="order_completed.jsp">已完成</a></li>
        </ul>
    </nav>
    <div class="bs-example" data-example-id="panel-without-body-with-table">
        <div class="panel panel-default">
            <!-- Default panel contents -->
            <div class="panel-heading">订单一览</div>
    
            <!-- Table -->
            <table class="table">
                <thead>
                    <tr>
                        <th>订单号</th>
                        <th>价格</th>
                        <th>下单时间</th>
                        <th>状态</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
        <%
        
        Connection conn;
    	Statement sql=null;
    	ResultSet rs=null;
        float total=0f;
    		
    	try{
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		conn=DriverManager.getConnection("jdbc:mysql://139.199.155.77:3306/store?serverTimezone=UTC","root","john159753");
    		sql=conn.createStatement();
    		rs=sql.executeQuery("select * from store.order where state=2");
        LinkedList<String> sl=new LinkedList<>();
        sl.add("未发货");
        sl.add("已发货");
        sl.add("已完成");

        String id;
        String price;
        String datetime;
        int state;
            
    		while(rs.next()) {
    			id=rs.getString(1);
                price=rs.getString(8);
                datetime=rs.getString(3);
                state=rs.getInt(4);
                out.println("<tr>\r\n" + 
				"                        <th scope=\"row\">"+id+"</th>\r\n" + 
				"                        <td>"+price+"￥</td>\r\n" + 
				"                        <td>"+datetime+"</td>\r\n" +
        "                        <td>"+sl.get(state).toString()+"</td>"+
				"                        <td><a class=\"btn btn-primary\" role=\"button\" href=\"order_detail.jsp?id="+id+"\">查看详情</a></td>\r\n" + 
				"                    </tr>\r\n");
    		}
    	}
    	catch(SQLException e){
    		e.printStackTrace();
    	}
    	catch(ClassNotFoundException e){
            e.printStackTrace();
    	}
        %>
                </tbody>
            </table>
        </div>
    </div>
    </div>
</body>

</html>
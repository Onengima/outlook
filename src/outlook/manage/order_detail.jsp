<%@ page contentType="text/html; charset=utf-8" %>   
<%@ page language="java" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
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
    .row{
        max-width: 800px;
        margin-left: auto;
        margin-right: auto;
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

    <div class="bs-example" data-example-id="panel-without-body-with-table">
        <div class="panel panel-default">
            <!-- Default panel contents -->
            <div class="panel-heading">订单商品</div>
            <script>
            function deleteFromCart(isbn){
                $.get("http://localhost:8083/outlook/DeleteFromCart?isbn="+isbn);
                alert("删除成功");
                window.location.href="cart.jsp"
            }
            </script>
    
            <!-- Table -->
            <table class="table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>书名</th>
                        <th>价格</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
        <%
        Connection conn;
    	Statement sql=null;
    	ResultSet rs=null;
    	String id=request.getParameter("id");
        float total=0f;
        String address=null;
        String phone=null;
        String name=null;
        String username=null;
        String time=null;
        int state=0;
        String t=null;
    	try{
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		conn=DriverManager.getConnection("jdbc:mysql://139.199.155.77:3306/store?serverTimezone=UTC","root","john159753");
    		sql=conn.createStatement();
    		rs=sql.executeQuery("select * from store.order where id="+id);
    		String cart="";
    		rs.next();
    		try{
                username=rs.getString(2);
                time=rs.getString(3);
                state=rs.getInt(4);
                name=rs.getString(5);
                address=rs.getString(6);
                phone=rs.getString(7);
                t=rs.getString(8);
    			cart=rs.getString(9);

    		}
    		catch(Exception e) {}
    		String regex="[0-9]+";
    		Pattern p=Pattern.compile(regex);
    		Matcher matcher=p.matcher(cart);
            int n=1;
            
    		while(matcher.find()) {
    			String isbn=matcher.group();
                rs=sql.executeQuery("select name,price from book where isbn='"+isbn+"'");
                rs.next();
                String bookname=rs.getString(1);
                String price=rs.getString(2);
                float pt=Float.parseFloat(price);
                total+=pt;
                out.println("<tr>\r\n" + 
				"                        <th scope=\"row\">"+n+"</th>\r\n" + 
				"                        <td>《"+bookname+"》</td>\r\n" + 
				"                        <td>"+price+"￥</td>\r\n" + 
				"                        <td><a class=\"btn btn-primary\" role=\"button\" href=\"detail.jsp?isbn="+isbn+"\">查看详情</a></td>\r\n" + 
				"                    </tr>\r\n");
                n++;
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
    <%
    out.print("<form class=\"form-signin\" method=\"post\" action=\"order_change_confirm.jsp?id="+id+"\">");
    out.print("<div class=\"row\">\r\n" + 
				"        <label for=\"basic-url\">修改订单信息</label>\r\n" + 
				"        <div class=\"input-group\">\r\n" + 
				"            <span class=\"input-group-addon\">收货人姓名</span>\r\n" + 
				"            <input type=\"text\" class=\"form-control\" aria-describedby=\"basic-addon3\" name=\"name\" required value=\""+name+"\">\r\n" + 
				"        </div>\r\n" + 
				"        <br/>\r\n" + 
				"        <div class=\"input-group\">\r\n" + 
				"            <span class=\"input-group-addon\">收货人地址</span>\r\n" + 
				"            <input type=\"text\" class=\"form-control\" aria-describedby=\"basic-addon3\" name=\"address\" required value=\""+address+"\">\r\n" + 
				"        </div>\r\n" + 
				"        <br/>\r\n" + 
				"        <div class=\"input-group\">\r\n" + 
				"            <span class=\"input-group-addon\">收货人手机号</span>\r\n" + 
				"            <input type=\"text\" class=\"form-control\" aria-describedby=\"basic-addon3\" name=\"phone\" required value=\""+phone+"\">\r\n" + 
				"        </div>\r\n" + 
				"        <br/>\r\n" + 
                "        <div class=\"input-group\">\r\n" + 
				"            <span class=\"input-group-addon\">状态(0:未发货 1:已发货 2:已完成）</span>\r\n" + 
				"            <input type=\"text\" class=\"form-control\" aria-describedby=\"basic-addon3\" name=\"state\" required value=\""+state+"\">\r\n" + 
				"        </div>\r\n" + 
				"        <br/>\r\n" + 
				"\r\n" + 
				"    </div>");
                %>
            <div style="max-width:750px;margin-left:auto;margin-right:auto;" align="right">
            <button type="submit" class="btn btn-lg btn-primary" role="button">修改订单</button>
             <a class="btn btn-lg btn-default" role="button">删除订单</a>
            </div>
            <br/>
        </form>
</body>

</html>
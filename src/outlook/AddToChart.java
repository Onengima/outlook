package outlook;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;

/**
 * Servlet implementation class AddToChart
 */
@WebServlet("/AddToChart")
public class AddToChart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToChart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF-8");
		response.setHeader("content-type","text/html;charset=UTF-8");
		HttpSession session=request.getSession();
		String isbn=null;
		isbn=request.getParameter("isbn");
		String username=null;
		try{
			username=session.getAttribute("user").toString();
		}
		catch(Exception e) {username="";}
		if(username==null||username.equals("")) {
			response.sendRedirect("/outlook/login.jsp");
		}

		Connection conn;
		Statement sql=null;
		ResultSet rs=null;
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://139.199.155.77:3306/store?serverTimezone=UTC","root","john159753");
			sql=conn.createStatement();
			rs=sql.executeQuery("select chart from user where username='"+username+"'");
			StringBuffer chart=null;
			rs.next();
			try{
				chart=new StringBuffer(rs.getString(1));
			}
			catch(Exception e) {
				chart=new StringBuffer();
			}
			chart.append(","+isbn);
			sql.executeUpdate("update user set chart='"+chart.toString()+"' where username='"+username+"'");
			response.getWriter().append("<!DOCTYPE html><html lang=\"zh-CN\">\r\n" + 
					"\r\n" + 
					"<head>\r\n" + 
					"  <meta charset=\"utf-8\">\r\n" + 
					"  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n" + 
					"  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n" + 
					"  <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->\r\n" + 
					"  <title>Outlook购书商店</title>\r\n" + 
					"\r\n" + 
					"  <!-- Bootstrap -->\r\n" + 
					"  <link href=\"https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n" + 
					"\r\n" + 
					"  <!-- HTML5 shim 和 Respond.js 是为了让 IE8 支持 HTML5 元素和媒体查询（media queries）功能 -->\r\n" + 
					"  <!-- 警告：通过 file:// 协议（就是直接将 html 页面拖拽到浏览器中）访问页面时 Respond.js 不起作用 -->\r\n" + 
					"  <!--[if lt IE 9]>\r\n" + 
					"      <script src=\"https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js\"></script>\r\n" + 
					"      <script src=\"https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js\"></script>\r\n" + 
					"    <![endif]-->\r\n" + 
					"  <style>\r\n" + 
					"    .jumbotron {\r\n" + 
					"      max-width: 600px;\r\n" + 
					"      padding: 15px;\r\n" + 
					"      margin: 0 auto;\r\n" + 
					"    }\r\n" + 
					"  </style>\r\n" + 
					"</head>\r\n" + 
					"\r\n" + 
					"<body>\r\n" + 
					"  \r\n" + 
					"    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->\r\n" + 
					"    <script src=\"https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js\"></script>\r\n" + 
					"    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->\r\n" + 
					"    <script src=\"https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js\"></script>\r\n" + 
					"    <nav class=\"navbar navbar-default\">\r\n" + 
					"      <div class=\"container-fluid\">\r\n" + 
					"        <!-- Brand and toggle get grouped for better mobile display -->\r\n" + 
					"        <div class=\"navbar-header\">\r\n" + 
					"          <button type=\"button\" class=\"navbar-toggle collapsed\" data-toggle=\"collapse\" data-target=\"#bs-example-navbar-collapse-1\"\r\n" + 
					"            aria-expanded=\"false\">\r\n" + 
					"            <span class=\"sr-only\">Toggle navigation</span>\r\n" + 
					"            <span class=\"icon-bar\"></span>\r\n" + 
					"            <span class=\"icon-bar\"></span>\r\n" + 
					"            <span class=\"icon-bar\"></span>\r\n" + 
					"          </button>\r\n" + 
					"          <a class=\"navbar-brand\" href=\"detail.jsp\"><img alt=\"Outlook购书商店\" src=\"img/outlook_s.png\"/></a>\r\n" + 
					"        </div>\r\n" + 
					"\r\n" + 
					"        <!-- Collect the nav links, forms, and other content for toggling -->\r\n" + 
					"        <div class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\">\r\n" + 
					"          <ul class=\"nav navbar-nav\">\r\n" + 
					"            <li>\r\n" + 
					"              <a href=\"#\">Outlook购书商店</a>\r\n" + 
					"            </li>\r\n" + 
					"            <li class=\"dropdown\">\r\n" + 
					"              <a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">图书分类\r\n" + 
					"                <span class=\"caret\"></span>\r\n" + 
					"              </a>\r\n" + 
					"              <ul class=\"dropdown-menu\">\r\n" + 
					"                <li>\r\n" + 
					"                  <a href=\"#\">Action</a>\r\n" + 
					"                </li>\r\n" + 
					"                <li>\r\n" + 
					"                  <a href=\"#\">Another action</a>\r\n" + 
					"                </li>\r\n" + 
					"                <li>\r\n" + 
					"                  <a href=\"#\">Something else here</a>\r\n" + 
					"                </li>\r\n" + 
					"                <li role=\"separator\" class=\"divider\"></li>\r\n" + 
					"                <li>\r\n" + 
					"                  <a href=\"#\">Separated link</a>\r\n" + 
					"                </li>\r\n" + 
					"                <li role=\"separator\" class=\"divider\"></li>\r\n" + 
					"                <li>\r\n" + 
					"                  <a href=\"#\">One more separated link</a>\r\n" + 
					"                </li>\r\n" + 
					"              </ul>\r\n" + 
					"            </li>\r\n" + 
					"          </ul>\r\n" + 
					"          <form class=\"navbar-form navbar-left\">\r\n" + 
					"            <div class=\"form-group\">\r\n" + 
					"              <input type=\"text\" class=\"form-control\" placeholder=\"Search\">\r\n" + 
					"            </div>\r\n" + 
					"            <button type=\"submit\" class=\"btn btn-default\">搜索</button>\r\n" + 
					"          </form>\r\n" + 
					"          <ul class=\"nav navbar-nav navbar-right\">\r\n" + 
					"            <li>\r\n" + 
					"              <a href=\"#\">购物车</a>\r\n" + 
					"            </li>\r\n" + 
					"            <li class=\"dropdown\">\r\n" + 
					"              <a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">我的账户\r\n" + 
					"                <span class=\"caret\"></span>\r\n" + 
					"              </a>\r\n" + 
					"              <ul class=\"dropdown-menu\">\r\n" + 
					"                <li>\r\n" + 
					"                  <a href=\"#\">Action</a>\r\n" + 
					"                </li>\r\n" + 
					"                <li>\r\n" + 
					"                  <a href=\"#\">Another action</a>\r\n" + 
					"                </li>\r\n" + 
					"                <li>\r\n" + 
					"                  <a href=\"#\">Something else here</a>\r\n" + 
					"                </li>\r\n" + 
					"                <li role=\"separator\" class=\"divider\"></li>\r\n" + 
					"                <li>\r\n" + 
					"                  <a href=\"#\">Separated link</a>\r\n" + 
					"                </li>\r\n" + 
					"              </ul>\r\n" + 
					"            </li>\r\n" + 
					"          </ul>\r\n" + 
					"        </div>\r\n" + 
					"        <!-- /.navbar-collapse -->\r\n" + 
					"      </div>\r\n" + 
					"      <!-- /.container-fluid -->\r\n" + 
					"    </nav>\r\n" + 
					"    <div class=\"jumbotron\"><h1>添加购物车成功!</h1><p><a class=\"btn btn-primary btn-lg\" onclick=\"javascript:history.back(-1)\" role=\"button\">点击返回</a></p></div>\r\n" + 
					"    \r\n" + 
					"\r\n" + 
					"</body>\r\n" + 
					"\r\n" + 
					"</html>");
		}
		catch(SQLException e){
			response.getWriter().append("sql error");
			e.printStackTrace();
		}
		catch(ClassNotFoundException e){
			response.getWriter().append("cnf error");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package outlook;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/**
 * Servlet implementation class GetItem
 */
@WebServlet("/GetItem")
public class GetItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetItem() {
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
		
		String classification=request.getParameter("classification");
		Connection conn;
		Statement sql=null;
		ResultSet rs=null;
		JSONArray ja=new JSONArray();
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://139.199.155.77:3306/store?serverTimezone=UTC","root","john159753");
			sql=conn.createStatement();
			rs=sql.executeQuery("select * from book where classification='"+classification+"'");
			while(rs.next()) {
				JSONObject jo=new JSONObject();
				jo.put("isbn",rs.getString(1));
				jo.put("name",rs.getString(2));
				jo.put("author",rs.getString(3));
				jo.put("price",rs.getString(4));
				jo.put("introduction",rs.getString(5));
				jo.put("press",rs.getString(6));
				jo.put("classification",rs.getString(7));
				ja.add(jo);
				
			}
			System.out.println(ja.toString());
		}
		catch(SQLException e){
			response.getWriter().append("sql error");
			e.printStackTrace();
		}
		catch(ClassNotFoundException e){
			response.getWriter().append("cnf error");
		}
		response.getWriter().append(ja.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

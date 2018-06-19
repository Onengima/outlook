package outlook;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DeleteFromCart
 */
@WebServlet("/DeleteFromCart")
public class DeleteFromCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteFromCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String isbn=request.getParameter("isbn");
		HttpSession session=request.getSession();
		String user=session.getAttribute("user").toString();
		Connection conn;
    	Statement sql=null;
    	ResultSet rs=null;
    	StringBuffer sb=new StringBuffer();
    	try{
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		conn=DriverManager.getConnection("jdbc:mysql://139.199.155.77:3306/store?serverTimezone=UTC","root","john159753");
    		sql=conn.createStatement();
    		rs=sql.executeQuery("select chart from user where username='"+user+"'");
    		String cart="";
    		rs.next();
    		try{
    			cart=rs.getString(1);
    		}
    		catch(Exception e) {}
    		String regex="[0-9]+";
    		Pattern p=Pattern.compile(regex);
    		Matcher matcher=p.matcher(cart);
            int n=0;
    		while(matcher.find()) {
    			String i=matcher.group();
    			if(isbn.equals(i)&&n==0) {
    				n++;
    			}
    			else if(n>0) {
    				sb.append(","+i);
    			}
    			else {
    				sb.append(","+i);
    			}
    		}
    		sql.executeUpdate("update user set chart='"+sb+"' where username='"+user+"'");
    	}
    	catch(SQLException e){
    		e.printStackTrace();
    	}
    	catch(ClassNotFoundException e){
            e.printStackTrace();
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

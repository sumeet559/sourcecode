

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ChangePassword
 */
public class Watched extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_CONNECTION = "jdbc:mysql://localhost:3306/sourcecode";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try{
	    String uid = request.getParameter("uid1");
	    String username = request.getParameter("username");
		String movie1 = request.getParameter("movie1");
	    if(db_check(uid, movie1)){
	       String temp ;
	            temp = "Movie has been watched";
	        request.setAttribute("error", temp);
	        request.setAttribute("mov", movie1);
	        request.getRequestDispatcher("loggedin.jsp").forward(request, response);
	    }
	    else{
	        String temp = "Movie not watched";
	        request.setAttribute("error", temp);
	        request.setAttribute("mov", movie1);
	        request.getRequestDispatcher("loggedin.jsp").forward(request, response);
	    }
	    }
	    catch(SQLException e){
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
	
	private boolean db_check(String uid, String movie1) throws SQLException{
        Connection dbConnection = null;
        //PreparedStatement preparedStatementselect = null;
        ResultSet rs1 = null;
        boolean rev = true;
        String selectSQL = "Select movie from people where uid='" + uid +"'" ;
        //System.out.println(selectSQL);
        
        try {
            dbConnection = getDBConnection();
            
            Statement smnt = dbConnection.createStatement ();
            
            rs1 = smnt.executeQuery (selectSQL); 
            
            while(rs1.next()){
                String p = rs1.getString("movie");
                if (p.equals(movie1))
                    {rev = true;break;}
                else
                    {rev = false;continue;}
            }
 
        } catch (SQLException e) {
 
            System.out.println(e.getMessage());
            dbConnection.rollback();
 
        } System.out.println(rev);
        return rev;
    }
	
	private static Connection getDBConnection() {
        
        Connection dbConnection = null;
 
        try {
 
            Class.forName(DB_DRIVER);
 
        } catch (ClassNotFoundException e) {
 
            System.out.println(e.getMessage());
 
        }
 
        try {
 
            dbConnection = DriverManager.getConnection(DB_CONNECTION, DB_USER,DB_PASSWORD);
            System.out.println("Connection Established");
            return dbConnection;
 
        } catch (SQLException e) {
 
            System.out.println(e.getMessage());
 
        }
 
        return dbConnection;
 
    }

}

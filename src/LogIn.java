import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Statement;
import java.sql.ResultSet;


/**
 * Servlet implementation class LogIn
 */
public class LogIn extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
	private static final String DB_CONNECTION = "jdbc:mysql://localhost:3306/sourcecode";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "1234";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogIn() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] vals = new String[3];
		String username1 = request.getParameter("username");
		String password1 = request.getParameter("pwd");
		HttpSession session=request.getSession();
        session.setAttribute("user", username1); 
        String name1 = request.getParameter("uid");
	        session.setAttribute("uid", name1); 
		  vals[0] = username1;
		  vals[1] = password1;
		  vals[2] = name1;
		  for(int i = 0; i < 3; i++){
			  System.out.println(vals[i]);
		  }
		  try{
		  
			  if(db_check(vals)){
				  RequestDispatcher rq=request.getRequestDispatcher("/loggedin.jsp");
	              rq.forward(request, response);
			  }
			  else{
				  String messages = "Invalid Username or Password";
				  request.setAttribute("messages", messages);
				  request.getRequestDispatcher("index.jsp").forward(request,response);
			}
		  }
		  catch(SQLException e){
			  e.printStackTrace();
		  }
	}
	
	private boolean db_check(String[] arg) throws SQLException{
		Connection dbConnection = null;
		//PreparedStatement preparedStatementselect = null;
		ResultSet rs1 = null;
		boolean rev = true;
		String selectSQL = "Select pwd,uid from approve_user where USER_NAME='" + arg[0] +"'" ;
		//System.out.println(selectSQL);
		
		try {
			dbConnection = getDBConnection();
			
			Statement smnt = dbConnection.createStatement ();
			
			rs1 = smnt.executeQuery (selectSQL); 
			
			if(rs1.next()){
				//System.out.println("in here");
				String p2 = rs1.getString("uid");
				String p = rs1.getString("PWD");
				if (p.equals(arg[1]) && p2.equals(arg[2]))
					rev = true;
				else
					rev = false;
			}
			else{
				rev = false;
				//System.out.println("among here");
			}
 
		} catch (SQLException e) {
 
			System.out.println(e.getMessage());
			dbConnection.rollback();
 
		} finally {
 
			if (dbConnection != null) {
				dbConnection.close();
			}
		}
		System.out.println(rev);
		return rev;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
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
 
	}}
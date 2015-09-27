import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class SignUp
 */
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
	private static final String DB_CONNECTION = "jdbc:mysql://localhost:3306/sourcecode";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "1234";
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	private static void db_insert(String[] arg) throws SQLException{
		Connection dbConnection = null;
		PreparedStatement preparedStatementInsert = null;
			
		String insertTableSQL = "INSERT INTO approve_user"
					+ "(user_name, pwd,uid) VALUES"
					+ "(?,?,?)";
		try {
				dbConnection = getDBConnection();
	 
				dbConnection.setAutoCommit(false);
	 
				preparedStatementInsert = dbConnection.prepareStatement(insertTableSQL);
				
				//preparedStatementInsert.setInt(1, 1);
				preparedStatementInsert.setString(1, arg[0]);
				preparedStatementInsert.setString(2, arg[1]);
				preparedStatementInsert.setString(3, arg[2]);
				preparedStatementInsert.executeUpdate();
				
				dbConnection.commit();
	 
				System.out.println("Done!");
	 
			} catch (SQLException e) {
	 
				System.out.println(e.getMessage());
				//dbConnection.rollback();
	 
			} finally {
	 
				if (preparedStatementInsert != null) {
					preparedStatementInsert.close();
				}
	 
				if (dbConnection != null) {
					dbConnection.close();
				}
	 
			}
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] vals = new String[3];
		String username1 = request.getParameter("username");
		String password1 = request.getParameter("pwd");
		String name1 = request.getParameter("uid");
		  HttpSession session=request.getSession();
	        session.setAttribute("uid", name1); 
		  
		  vals[0] = username1;
		  vals[1] = password1;
		  vals[2] = name1;
		  for(int i = 0; i < 3; i++){
			  System.out.println(vals[i]);
		  }
		  try{
		  
			  db_insert(vals);
			  RequestDispatcher rq=request.getRequestDispatcher("/reg_done.html");
              rq.forward(request, response);
			}
		  catch(SQLException e){
			  e.printStackTrace();
		  }
	}

}


import java.io.*;
import java.sql.*;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ValidateName
 */
public class ValidateName extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
	private static final String DB_CONNECTION = "jdbc:mysql://localhost:3306/discussion_board";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "1234";
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try{
		//Person p1 = new Person(1, "sumeet", "tiwari", "pune@gmail.com", "123456");
		String got_value = request.getParameter("username");
		String uid= request.getParameter("uid");
		boolean passed = validateName(got_value,uid);
		//System.out.println("passed is: " + passed);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-cache");
		response.setStatus(HttpServletResponse.SC_OK);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		//String message = "This username " + request.getParameter("username") + " has already been taken.";
		String message = "0";
		if (passed) {
			        //message = "Username available.";
			        message = "1";
		}
		//String resultStrJson = gson.toJson(p1);
		//out.print("{\"person\":"+resultStrJson+"}");
		String resultStrJson = gson.toJson(message);
		out.print("{\"message\":"+resultStrJson+"}");
		out.close();
		out.flush();
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		catch (Exception e){
			System.out.println("QuoteMgmtAction - getTerms(): Exception occured:" + e);
			e.printStackTrace();
	    }
	}
	
	private boolean validateName(String name,String uid) throws SQLException{
			Connection dbConnection = null;
			//PreparedStatement preparedStatementselect = null;
			ResultSet rs1 = null;
			boolean rev = true;
			String selectSQL = "Select * from approve_user where USER_NAME='" + name +"'and uid='"+uid+"'" ;
			//System.out.println(selectSQL);
			
			try {
				dbConnection = getDBConnection();
				
				Statement smnt = dbConnection.createStatement ();
				
				rs1 = smnt.executeQuery (selectSQL); 
				
				if(rs1.next()){
					//System.out.println("in here");
					rev = false;
				}
				else{
					rev = true;
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
	
	private static Connection getDBConnection() {
		 
		Connection dbConnection = null;
 
		try {
 
			Class.forName(DB_DRIVER);
 
		} catch (ClassNotFoundException e) {
 
			System.out.println(e.getMessage());
 
		}
 
		try {
 
			dbConnection = DriverManager.getConnection(DB_CONNECTION, DB_USER,DB_PASSWORD);
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
		// TODO Auto-generated method stub
	}

}

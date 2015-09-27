<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Suggestions from your side</title>
<h><font size="5" color="red">suggestions from your side</font></h>
</head>
<body>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*;" %>
<% 

java.sql.Connection con1;
java.sql.Statement s1;
java.sql.ResultSet rs1;
java.sql.PreparedStatement pst1;

con1=null;
s1=null;
pst1=null;
rs1=null;

// Remember to change the next line with your own environment 
String url1= "jdbc:mysql://localhost:3306/sourcecode";
String id1= "root";
String pass1 = "1234";
try{

Class.forName("com.mysql.jdbc.Driver");
con1 = java.sql.DriverManager.getConnection(url1, id1, pass1);

}catch(ClassNotFoundException cnfex){
cnfex.printStackTrace();
}
int uid1 = Integer.parseInt((String)request.getSession().getAttribute("uid"));
String sql1= "select movie_watched,rec_to from movie where uid="+uid1;
try{
s1 = con1.createStatement();
rs1 = s1.executeQuery(sql1);
%>
<%
while( rs1.next() ){
%>
							<h2>Suggested:</h2> <p><%= rs1.getString(1)%> to  <%= rs1.getString(2)%></p>
							<%
}
%>
		<%

}
catch(Exception e){e.printStackTrace();}
finally{
if(rs1!=null) rs1.close();
if(s1!=null) s1.close();
if(con1!=null) con1.close();
}

%>
</body>
</html>
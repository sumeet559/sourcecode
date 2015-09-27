<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Suggestions for you and others</title>
<h><font size="7" color="red">Suggestions for you and others</font></h>
</head>
<body>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*;" %>
<% 

java.sql.Connection con2;
java.sql.Statement s2;
java.sql.ResultSet rs2;
java.sql.PreparedStatement pst2;

con2=null;
s2=null;
pst2=null;
rs2=null;

// Remember to change the next line with your own environment 
String url2= "jdbc:mysql://localhost:3306/sourcecode";
String id2= "root";
String pass2 = "1234";
try{

Class.forName("com.mysql.jdbc.Driver");
con2 = java.sql.DriverManager.getConnection(url2, id2, pass2);

}catch(ClassNotFoundException cnfex){
cnfex.printStackTrace();
}
int uid2 = Integer.parseInt((String)request.getSession().getAttribute("uid"));
String sql2= "select movie_watched,rec_to from movie where uid!="+uid2;
try{
s2 = con2.createStatement();
rs2 = s2.executeQuery(sql2);
%>
<%
while( rs2.next() ){
%>
							<h2><font size="5" color="blue">Suggested: </font></h2><p><font size="4" color="black"><%= rs2.getString(1)%> to  <%= rs2.getString(2)%></font></p>
							<%
}
%>
		<%

}
catch(Exception e){e.printStackTrace();}
finally{
if(rs2!=null) rs2.close();
if(s2!=null) s2.close();
if(con2!=null) con2.close();
}

%>
</body>
</html>
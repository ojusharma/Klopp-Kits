<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<style>
	table {
		border-collapse: collapse;
		width: 30%;
		
	}
</style>
</head>
<body>
<h1>Customer  Info</h1>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information in a table 
String sql = "SELECT * FROM customer WHERE userid = ?";
try{
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, userName);
	ResultSet rst = pstmt.executeQuery();
	out.println("<table border=1>");
	
	while(rst.next()){
		
		out.println("<tr><td><b>CustomerId</b>"+"</td><td>"+rst.getString(1)+"</td></tr>");
		out.println("<tr><td><b>First Name</b>"+"</td><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr><td><b>Last Name</b>"+"</td><td>"+rst.getString(3)+"</td></tr>");
		out.println("<tr><td><b>Email</b>"+"</td><td>"+rst.getString(4)+"</td></tr>");
		out.println("<tr><td><b>Phone</b>"+"</td><td>"+rst.getString(5)+"</td></tr>");
		out.println("<tr><td><b>Address</b>"+"</td><td>"+rst.getString(6)+"</td></tr>");
		out.println("<tr><td><b>City</b>"+"</td><td>"+rst.getString(7)+"</td></tr>");
		out.println("<tr><td><b>Province</b>"+"</td><td>"+rst.getString(8)+"</td></tr>");
		out.println("<tr><td><b>Postal Code</b>"+"</td><td>"+rst.getString(9)+"</td></tr>");
		out.println("<tr><td><b>Country</b>"+"</td><td>"+rst.getString(10)+"</td></tr>");
		out.println("<tr><td><b>UserId</b>"+"</td><td>"+rst.getString(11)+"</td></tr>");

		
	}
	out.println("</table>");
	closeConnection();
}
catch (SQLException ex) {
	out.println(ex);
}

// Make sure to close connection
%>

</body>
</html>


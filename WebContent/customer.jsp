<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
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
		
		out.println("<tr><td>"+"CustomerId"+"</td><td>"+rst.getString(1)+"</td></tr>");
		out.println("<tr><td>"+"Name"+"</td><td>"+rst.getString(2)+"</td></tr>");
		out.println("<tr><td>"+"Address"+"</td><td>"+rst.getString(3)+"</td></tr>");
		out.println("<tr><td>"+"City"+"</td><td>"+rst.getString(4)+"</td></tr>");
		out.println("<tr><td>"+"Province"+"</td><td>"+rst.getString(5)+"</td></tr>");
		out.println("<tr><td>"+"Postal Code"+"</td><td>"+rst.getString(6)+"</td></tr>");
		out.println("<tr><td>"+"Country"+"</td><td>"+rst.getString(7)+"</td></tr>");
		out.println("<tr><td>"+"Phone"+"</td><td>"+rst.getString(8)+"</td></tr>");

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


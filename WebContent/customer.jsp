<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<style>
	body {
		font-family: Arial, sans-serif;
		margin: 20px;
		text-align: center;
	}

	table {
		border-collapse: collapse;
		width: 60%;
		margin: 20px auto; /* Center the table */
	}

	table, th, td {
		border: 1px solid #ddd;
	}

	th, td {
		padding: 12px;
		text-align: left;
	}

	th {
		background-color: #f2f2f2;
	}

	h1 {
		color: #333;
	}
</style>
</head>
<body>
	<%@ include file="header.jsp" %>
<h1>Customer  Profile</h1>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// TODO: Print Customer information in a table 
String sql = "SELECT * FROM customer WHERE userid = ?";
String sql2 = "SELECT orderId,orderDate,totalAmount FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId WHERE userId = ?";
try{
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	pstmt.setString(1, userName);
	pstmt2.setString(1, userName);
	ResultSet rst = pstmt.executeQuery();
	ResultSet rst2 = pstmt2.executeQuery();
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
	%>
	<h1>Your Order History</h1>
	<%
	
		out.println("<table border=1>");
		out.print("<tr><th>Order Id</th><th>Date & Time </th><th>Total Amount</th></tr>");
		
		while(rst2.next()){

			out.println("<tr><td>"+rst2.getString(1)+"</td>");
			out.println("<td>"+rst2.getString(2)+"</td>");
			out.println("<td>"+rst2.getString(3)+"</td>");
			out.println("</tr>");	
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


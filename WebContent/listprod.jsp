<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Klopp's Grocery</title>
<style>
	table {
		border-collapse: collapse;
		width: 100%;
	}
	th, td {
		border: 2px solid #D3D3D3;
		padding: 8px;
		text-align: left;
	}
	th {
		background-color: #Fdb0c0;
	}
	.add-to-cart-link {
		color: blue;
	}
</style>

</head>
<body>
	<%@ include file="header.jsp" %>

<h1 align="center">Product Search</h1>
<h2>Search for the products you want to buy:</h2>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Make the connection
getConnection();

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

if(name == null) {
	//Make a table to display the results
out.println("<h3>Lisiting All Products:</h3>");
out.println("<table >");
out.println("<tr><th>Add to Cart</th><th>Product Name</th><th>Price ($)</th></tr>");
PreparedStatement sql = con.prepareStatement("SELECT productName, productPrice, productId FROM product ORDER BY productName");
ResultSet rst = sql.executeQuery();

	// Print out the ResultSet
	while(rst.next()) {
		out.print("<tr><td><a href=\"addcart.jsp?id=" + rst.getInt(3) + "&name=" + rst.getString(1) + "&price=" + rst.getString(2) + "\" class=\"add-to-cart-link\">Add to Cart</a>"
			+ "</td><td>" + "<a href=\"product.jsp?id=" + rst.getInt(3) + "\" class=\"product-link\">"+ rst.getString(1) +"</a>" + "</td><td>" + rst.getString(2) + "</td></tr>");
	}
	out.println("</table>");
	rst.close();
}

else
	{
			
		
	out.println("<h3>Products that contain '" + name + "' :</h3>");
	out.println("<table >");
	out.println("<tr><th>Add to Cart</th><th>Product Name</th><th>Price ($)</th></tr>");
	PreparedStatement sql = con.prepareStatement("SELECT productName, productPrice, productId FROM product WHERE productName LIKE ? ORDER BY productName");
	sql.setString(1, "%" + name + "%");
	ResultSet rst = sql.executeQuery();

	// Print out the ResultSet
	while(rst.next()) {
		out.print("<tr><td><a href=\"addcart.jsp?id=" + rst.getInt(3) + "&name=" + rst.getString(1) + "&price=" + rst.getString(2) + "\" class=\"add-to-cart-link\">Add to Cart</a>"
			+ "</td><td>" + "<a href=\"product.jsp?id=" + rst.getInt(3)+ "\" class=\"product-link\">"+ rst.getString(1) +"</a>" + "</td><td>" + rst.getString(2) + "</td></tr>");
	}

	

	out.println("</table>");
	rst.close();
}

out.println();

// Close connection
closeConnection();
%>

</body>
</html>
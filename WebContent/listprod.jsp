<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Klopp's Grocery</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
    }
    h1, h2, h3 {
        text-align: center;
    }
    table {
        border-collapse: collapse;
        width: 50%;
        margin: 20px auto;
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
    .product-image {
        width: 100px; 
        height: auto;
    }
</style>
</head>
<body>
    <%@ include file="header.jsp" %>
	<img src="img/homepageklopp.gif" alt="Animated GIF" style="display: block; margin: 0 auto; width: 30%;" />
    <h3>Search for the products you want to buy:</h3>

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
out.println("<tr><th>Kit</th><th>Product Name</th><th>Price ($)</th></tr>");
PreparedStatement sql = con.prepareStatement("SELECT productName, productPrice, productId, productImageURL FROM product ORDER BY productName");
ResultSet rst = sql.executeQuery();

	// Print out the ResultSet
	while(rst.next()) {
		String imageURL = rst.getString(4);
		if(imageURL == null || imageURL.equals(""))
		{
			imageURL = "img/no-image.png";
		}
		out.println("<tr><td><a href='product.jsp?id=" + rst.getInt(3) + "'><img src=\"" + imageURL + "\" alt=\"Add to Cart\" style=\"width: 70px; height: 70px;\" /></a>"
				+ "</td><td><a href='product.jsp?id=" + rst.getInt(3) + "' class='product-link'>" + rst.getString(1) + "</a></td>"
				+ "<td>" + rst.getString(2) + "</td></tr>");
	}
	out.println("</table>");
	rst.close();	
}

else
	{
			
		
	out.println("<h3>Products that contain '" + name + "' :</h3>");
	out.println("<table >");
	out.println("<tr><th>Kit</th><th>Product Name</th><th>Price ($)</th></tr>");
	PreparedStatement sql = con.prepareStatement("SELECT productName, productPrice, productId, productImageURL FROM product WHERE productName LIKE ? ORDER BY productName");
	sql.setString(1, "%" + name + "%");
	ResultSet rst = sql.executeQuery();

	// Print out the ResultSet
	while(rst.next()) {
		String imageURL = rst.getString(4);
		if(imageURL == null || imageURL.equals(""))
		{
			imageURL = "img/no-image.png";
		}
		out.println("<tr><td><a href='product.jsp?id=" + rst.getInt(3) + "'><img src=\"" + imageURL + "\" alt=\"Add to Cart\" style=\"width: 70px; height: 70px;\" /></a>"
				+ "</td><td><a href='product.jsp?id=" + rst.getInt(3) + "' class='product-link'>" + rst.getString(1) + "</a></td>"
				+ "<td>" + rst.getString(2) + "</td></tr>");
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
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Klopp Kits</title>
<%@ include file="header.jsp" %>
<style>
    body {
        margin: 0;
        padding: 0;
    }
    h1, h2, h3 {
        text-align: center;
    }
    table {
        border-collapse: collapse;
        width: 60%;
        margin: 20px auto;
    }
    th, td {
        border: 2px solid #D3D3D3;
        padding: 8px;
		text-align: center;
		font-weight: bold;
		font-size: 20px;
    }
    th {
        background-color: #Fdb0c0;
    }
	table img {
            display: block;
            margin: 0 auto;
        }
        .product-link {
            text-decoration: none;
            color: rgb(72, 70, 200);
            transition: color 0.3s; 
        }
        .product-link:hover {
            color: #f00; 
        }
</style>
</head>
<body>
	<img src="img/homepageklopp.gif" alt="Animated GIF" style="display: block; margin: 0 auto; width: 30%; border-radius: 10%; overflow: hidden; margin-bottom: 50px; margin-top: 30px;" />
    <h3>Search for the products! </h3>

    <form method="get" action="index.jsp">
        <input type="text" name="productName" size="50">
        <select name="category">
            <option value="">All</option>
            <option value=1>Premier League</option>
            <option value=2>La Liga</option>
            <option value=3>Indian Super League</option>
            <option value=4>Bundesliga</option>
            <option value=5>Uber Eats Ligue 1</option>
        </select>
        <input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
    </form>
    

<% // Get product name to search for
String name = request.getParameter("productName");
int category =0;
if(request.getParameter("category") != null && request.getParameter("category") != "" && request.getParameter("category").length() != 0)
{ category = Integer.parseInt(request.getParameter("category"));}


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

if(name == null && category == 0) {
	//Make a table to display the results
out.println("<table >");
out.println("<tr><th>Kit</th><th>Product Name</th><th>Category</th><th>Price ($)</th></tr>");
PreparedStatement sql = con.prepareStatement("SELECT productName, productPrice, productId, productImageURL,categoryName FROM product as p JOIN category as c ON p.categoryId = c.categoryId ORDER BY productName");
ResultSet rst = sql.executeQuery();

	// Print out the ResultSet
	while(rst.next()) {
		String imageURL = rst.getString(4);
		if(imageURL == null || imageURL.equals(""))
		{
			imageURL = "img/no-image.png";
		}
		out.println("<tr><td><a href='product.jsp?id=" + rst.getInt(3) + "'><img src=\"" + imageURL + "\" alt=\"Product\" style=\" width: 150px; height: 150px;\" /></a>"
				+ "</td><td><a href='product.jsp?id=" + rst.getInt(3) + "' class='product-link'>" + rst.getString(1) + "</a></td>"
				+ "<td>" + rst.getString(5) + "</td>"+"<td>" + rst.getString(2) + "</td></tr>");
	}
	out.println("</table>");
	rst.close();	
}

else if(name != null) 
	{	
        if(category == 0)
        {
            out.println("<table >");
                out.println("<tr><th>Kit</th><th>Product Name</th><th>Category</th><th>Price ($)</th></tr>");
                PreparedStatement sql = con.prepareStatement("SELECT productName, productPrice, productId, productImageURL,categoryName  FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE ? ORDER BY productName");
            sql.setString(1, "%" + name + "%");
            ResultSet rst = sql.executeQuery();

            // Print out the ResultSet
            while(rst.next()) {
                String imageURL = rst.getString(4);
                if(imageURL == null || imageURL.equals(""))
                {
                    imageURL = "img/no-image.png";
                }
                out.println("<tr><td><a href='product.jsp?id=" + rst.getInt(3) + "'><img src=\"" + imageURL + "\" alt=\"Product\" style=\" width: 150px; height: 150px;\" /></a>"
                    + "</td><td><a href='product.jsp?id=" + rst.getInt(3) + "' class='product-link'>" + rst.getString(1) + "</a></td>"
                    + "<td>" + rst.getString(5) + "</td>"+"<td>" + rst.getString(2) + "</td></tr>");
            }
            out.println("</table>");
            rst.close();
        }  
        else
        {
                PreparedStatement sql = con.prepareStatement("SELECT productName, productPrice, productId, productImageURL,categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE ? AND product.categoryId = ? ORDER BY productName");
            sql.setString(1, "%" + name + "%");
            sql.setInt(2, category);
            ResultSet rst = sql.executeQuery();
                out.println("<table >");
                out.println("<tr><th>Kit</th><th>Product Name</th><th>Category</th><th>Price ($)</th></tr>");
            // Print out the ResultSet
            while(rst.next()) {
                String imageURL = rst.getString(4);
                if(imageURL == null || imageURL.equals(""))
                {
                    imageURL = "img/no-image.png";
                }
                out.println("<tr><td><a href='product.jsp?id=" + rst.getInt(3) + "'><img src=\"" + imageURL + "\" alt=\"Product\" style=\" width: 150px; height: 150px;\" /></a>"
                    + "</td><td><a href='product.jsp?id=" + rst.getInt(3) + "' class='product-link'>" + rst.getString(1) + "</a></td>"
                    + "<td>" + rst.getString(5) + "</td>"+"<td>" + rst.getString(2) + "</td></tr>");
            }
            out.println("</table>");
            rst.close();
        }     
    }
    else
    {
        PreparedStatement sql = con.prepareStatement("SELECT productName, productPrice, productId, productImageURL,categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE product.categoryId = ? ORDER BY productName");
        sql.setInt(1, category);
        ResultSet rst = sql.executeQuery();
        out.println("<h3>Products that are in the category: " + rst.getString(5) + " :</h3>");
            out.println("<table >");
            out.println("<tr><th>Kit</th><th>Product Name</th><th>Category</th><th>Price ($)</th></tr>");
        // Print out the ResultSet
        while(rst.next()) {
            String imageURL = rst.getString(4);
            if(imageURL == null || imageURL.equals(""))
            {
                imageURL = "img/no-image.png";
            }
            out.println("<tr><td><a href='product.jsp?id=" + rst.getInt(3) + "'><img src=\"" + imageURL + "\" alt=\"Product\" style=\" width: 150px; height: 150px;\" /></a>"
                + "</td><td><a href='product.jsp?id=" + rst.getInt(3) + "' class='product-link'>" + rst.getString(1) + "</a></td>"
                + "<td>" + rst.getString(5) + "</td>"+"<td>" + rst.getString(2) + "</td></tr>");
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
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Klopp's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }
    table {
        border-collapse: collapse;
        width: 25%;
        margin-bottom: 20px;
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
        display: block;
        margin-bottom: 20px;
        margin-top: 20px;
    }
    .continue-shopping-link {
        color: blue;
        display: block;
    }
    .add-to-cart-link:hover {
        color: red;
    }
    .add-to-cart-link:active {
        color: green;
    }
    .continue-shopping-link:hover {
        color: red;
    }
    .continue-shopping-link:active {
        color: green;
    }
    .product-image {
        max-width: 100%;
        height: auto;
        margin-bottom: 20px;
    }
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<%
String id = request.getParameter("id");

getConnection();

String sql = "SELECT productName, productPrice, productImageURL FROM product WHERE productId = ?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, Integer.parseInt(id));
ResultSet rs = ps.executeQuery();

// TODO: If there is a productImageURL, display using IMG tag
if(rs.next()) {
    String name = rs.getString(1);
    String price = rs.getString(2);
    String imageURL = rs.getString(3);
    out.println("<h1>Product Details</h1>");
out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Price</th></tr>");
out.println("<tr><td>" + id + "</td><td>" + name + "</td><td>" + price + "</td></tr>");
out.println("</table>");
    if(imageURL != null) {
        out.println("<img src=\"" + imageURL + "\" alt=\"Product Image\" />");
    }
}  

// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as getParameter
String url = "displayImage.jsp?id=" + id;

if(Integer.parseInt(id)==1)
{%>

<img src="<%= url %>"/>


<%}		
// TODO: Add links to Add to Cart and Continue Shopping
out.println("\n<a href=\"addcart.jsp?id=" + id + "&name=" + rs.getString(1) + "&price=" + rs.getString(2) + "\" class=\"add-to-cart-link \">Add to Cart</a>");
out.println("<a href=\"listprod.jsp\" class=\"continue-shopping-link\">Continue Shopping</a>");
%>

</body>
</html>


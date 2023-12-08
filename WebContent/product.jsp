<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Klopp Kits - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
    body {

        margin: 20px;
    }
    table {
        border-collapse: collapse;
        width: 25%;
        margin: 20px auto;
    }
    th, td {
        border: 2px solid #D3D3D3;
        padding: 8px;
        text-align: center;
    }
    th {
        background-color: #Fdb0c0;
    }
    h3 {
        text-align: center;
        color: rgb(71, 59, 59)
    }
    .product-image {
        max-width: 100%;
        height: auto;
        margin-bottom: 20px;
    }
    .button-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 150px;
    }

    .button-container form {
        margin: 10px 0;
    }

    .button-container button {
    padding: 10px 20px;
    background-color: transparent;
    color: #000;
    border: 2px solid #000;
    border-radius: 5px;
    cursor: pointer;
    font-size: large;
    }
    .button-container button:hover {
        background-color: #000;
        color: #fff;
    }
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<%
String id = request.getParameter("id");

getConnection();

try{
String sql = "SELECT productName, productPrice, productImageURL, productDesc FROM product WHERE productId = ?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, Integer.parseInt(id));
ResultSet rs = ps.executeQuery();

// TODO: If there is a productImageURL, display using IMG tag
if(rs.next()) {
    String name = rs.getString(1);
    String price = rs.getString(2);
    String imageURL = rs.getString(3);
    out.println("<h1>" + name + "</h1>");
    if(imageURL != null) {
        out.println("<img src=\"" + imageURL + "\" alt=\"Product Image\" />");
    }
    out.println("<h3>" + rs.getString(4) + "</h3>");
out.println("<table><th>Price($)</th></tr>");
out.println("<tr><td>" + price + "</td></tr>");
out.println("</table>");
}  
%>
<div class="button-container">
    <form action="addcart.jsp" method="get">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="name" value="<%= rs.getString(1) %>">
        <input type="hidden" name="price" value="<%= rs.getString(2) %>">
        <button type="submit">Add to Cart</button>
    </form>

    <form action="index.jsp" method="get">
        <button type="submit">Continue Shopping</button>
    </form>
</div>
<%
} catch(Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
</body>
</html>


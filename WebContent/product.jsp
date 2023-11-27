<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
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
out.println("<table class=\"table table-striped\">");
out.println("<tr><th>Product Id</th><th>Product Name</th><th>Price</th></tr>");
out.println("<tr><td>" + id + "</td><td>" + name + "</td><td>" + price + "</td></tr>");
out.println("</table>");
    if(imageURL != null) {
        out.println("<img src=\"" + imageURL + "\" alt=\"Product Image\" />");
    }
}  

		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as getParameter
String url = "displayImage.jsp?id=" + id;
response.sendRedirect(url);
%>
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>


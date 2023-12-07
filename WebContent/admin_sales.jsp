<%@ include file="jdbc.jsp" %>

<%@ include file="auth.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<style>
	table {
        border-collapse: collapse;
        width: 50%;
        margin: 20px auto;
    }
    th, td {
        border: 2px solid #D3D3D3;
        padding: 8px;
		text-align: center;
		font-weight: bold;
		font-size: 15px;
    }
    th {
        background-color: #Fdb0c0;
        font-size: 17px;
    }
</style>
</head>
<body>
    <%@ include file="header.jsp" %>
<h2>Administrator Sales report by Day</h2>
<% 
try{
    getConnection();

    String sql = "SELECT convert(DATE,orderDate) as dates, SUM(totalAmount) as sales ,COUNT (orderID) as Ordercount "
        + "FROM ordersummary "
        + "GROUP BY convert(DATE,orderDate)";
Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery(sql);
out.println("<table border=1>");
out.println("<tr><th>Order Date</th><th>Total Amount</th><th>Total Number of Orders</th></tr>");
while(rst.next()){
    out.println("<tr>");
    out.println("<td>"+rst.getString(1)+"</td>");
    out.println("<td>"+rst.getString(2)+"</td>");
    out.println("<td>"+rst.getString(3)+"</td>");
    out.println("</tr>");
}
out.println("</table>");

//graph here 

closeConnection();
}
catch (SQLException ex) {
    out.println(ex);
}




%>

</body>
</html>
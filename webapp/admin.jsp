<%@ include file="jdbc.jsp" %>

<%@ include file="auth.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<style>
	table {
		border-collapse: collapse;
		width: 30%;
		
	}
</style>
</head>
<body>
    <%@ include file="header.jsp" %>
<h2>Administrator Sales report by Day</h2>
<% 
try{
    getConnection();

    String sql = "SELECT convert(DATE,orderDate) as dates, SUM(totalAmount) as sales "
        + "FROM ordersummary "
        + "GROUP BY convert(DATE,orderDate)";
Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery(sql);
out.println("<table border=1>");
out.println("<tr><th>Order Date</th><th>Total Amount</th></tr>");
while(rst.next()){
    out.println("<tr>");
    out.println("<td>"+rst.getString(1)+"</td>");
    out.println("<td>"+rst.getString(2)+"</td>");
    out.println("</tr>");
}
out.println("</table>");
closeConnection();
}
catch (SQLException ex) {
    out.println(ex);
}




%>

</body>
</html>


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

<h2> Current Registered Customers</h2>
<%try{
    getConnection();
    Statement stmt = con.createStatement();

String customerquery = "SELECT customerId,firstName,lastName,country,email FROM customer";
ResultSet customqrst = stmt.executeQuery(customerquery);
out.println("<table border=1>");
    out.println("<tr><th>Customer Id</th><th>Name</th><th>Country</th><th>E-Mail Id</th></tr>");
    while(customqrst.next()){
        out.println("<tr>");
        out.println("<td>"+customqrst.getString(1)+"</td>");
        out.println("<td>"+customqrst.getString(2)+" "+customqrst.getString(3)+"</td>");
        out.println("<td>"+customqrst.getString(4)+"</td>");
        out.println("<td>"+customqrst.getString(5)+"</td>");
        out.println("</tr>");
    }


closeConnection();
}
catch (SQLException ex) {
    out.println(ex);
}




%>

</body>
</html>
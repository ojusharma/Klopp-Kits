<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<title>Klopp Kits Order List</title>
    <style>
    table {
        border-collapse: collapse;
        width: 80%;
    }
    th, td {
        border: 1px solid black;
        padding: 8px;
        text-align: left;
    }
 </style>
</head>
<body>
    <h1 align = "center">Order List</h1>

    <table>
        <thead>
            <tr>
                <th>OrderId</th>
                <th>&nbsp;Order Date</th>
                <th>&nbsp;Customer Id</th>
                <th>&nbsp;Customer Name</th>
                <th>&nbsp;Total Amount</th>
            </tr>
        </thead>
        <tbody>

        <%
        try {
            // Make connection
            getConnection();

            Statement stmt = con.createStatement();
            PreparedStatement sql1 = con.prepareStatement("SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?");

            // Useful code for formatting currency values
            NumberFormat currFormat = NumberFormat.getCurrencyInstance();

            ResultSet rst = stmt.executeQuery("SELECT orderId, orderDate, o.customerId, firstname, lastname, totalAmount FROM ordersummary AS o JOIN customer AS c ON o.customerId = c.customerId");

            while (rst.next()) {
                out.println("<tr><td>" + rst.getInt(1) + "</td><td>&nbsp;" + rst.getDate(2) + "</td><td>&nbsp;" + rst.getInt(3) + "</td><td>&nbsp;" + rst.getString(4) + " " + rst.getString(5) + "</td><td>&nbsp;" + currFormat.format(rst.getDouble(6)) + "</td></tr>");

                sql1.setInt(1, rst.getInt(1));
                ResultSet rst2 = sql1.executeQuery();

                out.println("<tr><td colspan='5'><table><thead><tr><th>ProductId</th><th>Quantity</th><th>Price</th></tr></thead><tbody>");
                while (rst2.next()) {
                    out.println("<tr><td>" + rst2.getInt(1) + "</td><td>" + rst2.getInt(2) + "</td><td>" + currFormat.format(rst2.getInt(3)) + "</td></tr>");
                }

                out.println("</tbody></table></td></tr>");
                rst2.close();
            }
            stmt.close();
            sql1.close();

            // Close connection
            closeConnection();

        } catch (SQLException e) {
            out.println("SQLException: " + e.getMessage());
        }
        %>

        </tbody>
    </table>
</body>
</html>

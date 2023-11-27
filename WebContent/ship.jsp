<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>	
<title>Klopp's Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	getConnection();
	// TODO: Get order id
	request.getParameter("orderId");

	// TODO: Check if valid order id in database
	if(orderId == null){
		out.println("Invalid order id");
	}
	else
	{
		String sql = "SELECT orderId, productId, quantity, price FROM orderproduct WHERE orderId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(orderId));
		ResultSet rst = pstmt.executeQuery();
		if(rst.next()){
			con.setAutoCommit(false);
			sql = "INSERT INTO shipment (shipmentDate, warehouseId) VALUES (?,1);";
			pstmt = con.prepareStatement(sql);
			pstmt.setTimestamp(1, new java.sql.Timestamp(new Date().getTime()));
			pstmt.executeUpdate();
		}
		else{
			out.println("Invalid order id");
		}
	}

	
	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>

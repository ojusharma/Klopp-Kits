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
    String orderId = request.getParameter("orderId");

    // TODO: Check if valid order id in database
    if(orderId == null){
        throw new Exception("Invalid order id");
    }
    else
    {
        String sql = "SELECT orderId, productId, quantity, price FROM orderproduct WHERE orderId = ?";
        PreparedStatement pstmt = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		pstmt.setInt(1, Integer.parseInt(orderId));
		ResultSet rst = pstmt.executeQuery();
        if(rst.next()){
            // TODO: Start a transaction (turn-off auto-commit)
            con.setAutoCommit(false);

            // TODO: Create a new shipment record. Use the current date for the shipment date.
            String insertShipmentSQL = "INSERT INTO shipment (shipmentDate, shipmentDesc, warehouseId) VALUES (?, ?, ?)";
            PreparedStatement shipmentStmt = con.prepareStatement(insertShipmentSQL);
            shipmentStmt.setTimestamp(1, new Timestamp(System.currentTimeMillis())); // Current date/time
            shipmentStmt.setString(2, "Shipment for Order ID: " + orderId);
            shipmentStmt.setInt(3, 1); 
            shipmentStmt.executeUpdate();

            // TODO: Retrieve all items in order with given id
            rst.beforeFirst();
			boolean ship = true;
            while(rst.next()) {
                int productId = rst.getInt("productId");
                int quantity = rst.getInt("quantity");

                String checkInventorySQL = "SELECT quantity FROM productinventory WHERE productId = ? AND warehouseId = ?";
                PreparedStatement inventoryStmt = con.prepareStatement(checkInventorySQL);
                inventoryStmt.setInt(1, productId);
                inventoryStmt.setInt(2, 1); // Warehouse ID 1
                ResultSet inventoryResult = inventoryStmt.executeQuery();

                if(inventoryResult.next()) {
                    int availableQuantity = inventoryResult.getInt("quantity");
                    if(availableQuantity < quantity) {
                        con.rollback(); // Rollback the transaction
						out.println("<h2>Shipment not done! Insufficient inventory for Product ID: " + productId + "</h2> ");
						ship = false;
                    } 
					else
					{
                        // TODO: Update inventory for each item.
                        String updateInventorySQL = "UPDATE productinventory SET quantity = ? WHERE productId = ? AND warehouseId = ?";
                        PreparedStatement updateInventoryStmt = con.prepareStatement(updateInventorySQL);
                        updateInventoryStmt.setInt(1, availableQuantity - quantity);
                        updateInventoryStmt.setInt(2, productId);
                        updateInventoryStmt.setInt(3, 1); 
                        updateInventoryStmt.executeUpdate();

						out.println("<h3>Ordered Product: " + productId + "&nbsp;&nbsp;&nbsp;Quantity: " + quantity 
							+ "&nbsp;&nbsp;&nbsp;Old Inventory: " + availableQuantity 
							+ "&nbsp;&nbsp;&nbsp;New Inventory: " + (availableQuantity - quantity) + "</h3>");
                    }
                }
            }

			if(ship)
			{
				out.println("<h2>Shipment Placed Successfully</h2>");
			}
            // TODO: Auto-commit should be turned back on
            con.setAutoCommit(true);

        }
        else{
            throw new Exception("Invalid order id");
        }
    }
%>                       				

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>

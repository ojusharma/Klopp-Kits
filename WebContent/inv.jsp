<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>

    <title>Inventory Page</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
            padding-top: 30px;
        }
        th, td {
		border: 2px solid #D3D3D3;
		padding: 8px;
		text-align: center;
        font-weight: bold;
	}
	th {
		background-color: #Fdb0c0;
	}
        a {
            color: blue;
        }
        h1, h2 {
            margin: 20px 0;
        }
        .button-container {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            height: 50px;
            gap: 10px;
        }
    
        .button-container form {
            margin: 3px 0;
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
<form method="get" action="inv.jsp">
    <select name="category">
        <option value=0>All</option>
        <option value=1>Warehouse 1</option>
        <option value=2>Warehouse 2</option>
    </select>
    <input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all Warehouses)
</form>

<%
    getConnection();
    String wId = request.getParameter("category");
    int wIdi = 0;
    if(request.getParameter("category") != null && request.getParameter("category") != "" && request.getParameter("category").length() != 0)
  {   wIdi = Integer.parseInt(request.getParameter("category"));}

    String sql = "SELECT warehouseId ,productInventory.productId, productName ,productInventory.quantity,productInventory.price ,(productInventory.quantity *productInventory.price ) FROM productInventory JOIN product ON productInventory.productId = product.productId WHERE warehouseId = ?";
    String sql2 = "SELECT warehouseId, productInventory.productId , productName ,productInventory.quantity,productInventory.price ,(productInventory.quantity *productInventory.price ) FROM productInventory JOIN product ON productInventory.productId = product.productId ";
    PreparedStatement ps1 = con.prepareStatement(sql);
    PreparedStatement ps2 = con.prepareStatement(sql2);
    ResultSet rs ;
    if (wIdi == 0) {
       rs = ps2.executeQuery();
    }
    else {
        ps1.setInt(1, wIdi);
        rs = ps1.executeQuery();
    }
    out.println("<table border=1>");
		out.print("<tr><th>Warehouse Id</th><th>Product Id</th><th>Product Name </th><th>Quantity </th><th>Price </th><th>Total Inventory value </th></tr>");
    while (rs.next()) {

        out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getString(5) + "</td><td>" + rs.getString(6) +"</tr>");
    }
    
    out.println("</table>");
%>

    <div class="button-container">
        <form action="admin.jsp" method="get">
            <button type="submit">Back</button>
        </form>
    </div>
<%
    con.close();
%>

</body>
</html>
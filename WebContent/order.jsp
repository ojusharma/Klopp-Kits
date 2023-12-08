<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Klopp's Grocery Order Processing</title>
<%@ include file="header.jsp"%>
<style>
	body {
		margin: 20px;
		line-height: 1.6;
	}
	h1 {
		text-align: center;
	}
	table {
		width: 60%;
		border-collapse: collapse;
		margin: 20px auto;
	}
	th, td {
		border: 1px solid #ccc;
		padding: 8px;
		text-align: left;
	}
	th {
		background-color: #Fdb0c0;
	}
	a {
		color: #007bff;
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

<% 
// Get customer id
String custId = request.getParameter("customerId");
String password = request.getParameter("Cpassword");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
boolean isNumber=true;

for(char x : custId.toCharArray())
{
	if(!Character.isDigit(x))
	{
		isNumber = false;
		break;
	}
}

if(!isNumber || custId == null || custId.isEmpty())
{
	out.println("<h3>Customer ID is invalid</h3>");
	out.println("<h3>Go back to previous page and try again!</h3>");
}
else
{
	// Make the connection
	getConnection();

	PreparedStatement sql = con.prepareStatement("SELECT customerId, address, city, state, postalCode, country, firstName, lastName ,password  FROM customer WHERE customerId = ?");
	sql.setString(1, custId);
	ResultSet rst = sql.executeQuery();
	if(!rst.next())
	{
		out.println("<h3>Customer ID is invalid</h3>");
		out.println("<h3>Go back to previous page and try again!</h3>");
		
	}
	else
	{
		// Determine if there are products in the shopping cart
		// If either are not true, display an error message
		if(productList.isEmpty()){

		
		
			out.println("<h3>Cart is Empty!</h3>");
		}
		else
		{
			
			if(password.equals(rst.getString(9))) {
			String customerInfo = rst.getString(7) + " " + rst.getString(8) + " ; Customer ID: " + rst.getString(1);
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

			// Use retrieval of auto-generated keys.
			String sql1 = "INSERT INTO ordersummary (orderDate, totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry, customerId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);	

			pstmt.setDate(1, new java.sql.Date(System.currentTimeMillis())); 
			pstmt.setDouble(2, 0); 
			pstmt.setString(3, rst.getString(2)); 
			pstmt.setString(4, rst.getString(3)); 
			pstmt.setString(5, rst.getString(4)); 
			pstmt.setString(6, rst.getString(5));
			pstmt.setString(7, rst.getString(6)); 
			pstmt.setInt(8, rst.getInt(1));
			pstmt.executeUpdate();
		
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);


			// Insert each item into OrderProduct table using OrderId from previous INSERT
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator1 = productList.entrySet().iterator();
			while (iterator1.hasNext())
				{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator1.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
				String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ( (Integer)product.get(3)).intValue();
				
				PreparedStatement ptsmt3 = con.prepareStatement("INSERT INTO orderProduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)");
				ptsmt3.setInt(1, orderId);
				ptsmt3.setString(2, productId);
				ptsmt3.setInt(3, qty);
				ptsmt3.setDouble(4, pr);
				ptsmt3.executeUpdate();
			}
			
			// Update total amount for order record
			PreparedStatement ptsmt4 = con.prepareStatement("UPDATE ordersummary SET totalAmount=(SELECT SUM(quantity*price) FROM orderProduct WHERE orderId = ?) WHERE orderId = ?");
			ptsmt4.setInt(1, orderId);
			ptsmt4.setInt(2, orderId);
			ptsmt4.executeUpdate();
			
			
			// Print out order summary
			// From showcart.jsp
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();

			out.println("<h1>Your Order Summary</h1>");
			out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
			out.println("<th>Price</th><th>Subtotal</th></tr>");

			double total = 0;
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator2 = productList.entrySet().iterator();
			while (iterator2.hasNext()) 
			{	Map.Entry<String, ArrayList<Object>> entry = iterator2.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				if (product.size() < 4)
				{
					out.println("Expected product with four entries. Got: "+product);
					continue;
				}
				
				out.print("<tr><td>"+product.get(0)+"</td>");
				out.print("<td>"+product.get(1)+"</td>");

				out.print("<td align=\"center\">"+product.get(3)+"</td>");
				Object price = product.get(2);
				Object itemqty = product.get(3);
				double pr = 0;
				int qty = 0;
				
				try
				{
					pr = Double.parseDouble(price.toString());
				}
				catch (Exception e)
				{
					out.println("Invalid price for product: "+product.get(0)+" price: "+price);
				}
				try
				{
					qty = Integer.parseInt(itemqty.toString());
				}
				catch (Exception e)
				{
					out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
				}		

				out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
				out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
				out.println("</tr>");
				total = total +pr*qty;
			}
				out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
					+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
				out.println("</table>");
				
				out.println("<h2>Order Completed. Shipping Soon...</h2>");
				out.println("<h3>Your Order Reference Number: " + orderId + "</h3>");
				out.println("<h3>Shipping to Customer: " + customerInfo + "</h2>");

				// Clear cart if order placed successfully
				productList.clear();
				%>

				<div class="button-container">
					<form action="index.jsp" method="get">
						<button type="submit">Shop Again!</button>
					</form>
				</div>
					<%
			keys.close();
		   }
		   else
		   {
			out.println("Incorrect password please try again!");
		   }
		}
	}
	rst.close();
	//Closing connection
	closeConnection();
}	



%>
</BODY>
</HTML>


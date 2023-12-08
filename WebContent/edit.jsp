<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
<style>
	body {
		font-family: Arial, sans-serif;
		margin: 20px;
		text-align: center;
	}

	table {
        border-collapse: collapse;
        width: 40%;
        margin: 20px auto;
    }
    th, td {
        border: 2px solid #D3D3D3;
        padding: 8px;
		text-align: center;
		font-weight: bold;
		font-size: 16px;
    }
    th {
        background-color: #Fdb0c0;
    }
	h1 {
		color: #333;
	}
	.button-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100px;
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
    
        #editForm div {
            margin-bottom: 10px;
        }
    
        #editForm label {
            display: inline-block;
            width: 150px; 
        }
    
        #editForm input {
            width: 200px; 
        }
        button[type="submit"] {
            padding: 10px 20px;
     background-color: transparent;
     color: #000;
    border: 2px solid #000;
    border-radius: 5px;
    cursor: pointer;
    font-size: large;
        }
        button[type="submit"]:hover {
            background-color: #000;
            color: #fff;
        }
    
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<h1>Customer  Profile</h1>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
try{ 
    getConnection();
    String id  = (String)session.getAttribute("EditCid");
    String sql = "SELECT * FROM customer WHERE customerID = ?";
    PreparedStatement stmt = con.prepareStatement(sql);
    if(id!=null && id.length()>0){
        
        stmt.setInt(1, Integer.parseInt(id));
        ResultSet rst = stmt.executeQuery();
        while(rst.next()){
            %>
            <form id="editForm">
                <div>
                    <label for="FirstName">First Name:</label>
                    <input type="text" id="firstName" name="firstName" value="<%= rst.getString(2) %>">
                </div>
                <div>
                    <label for="lastName">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" value="<%= rst.getString(3) %>">
                </div>
            
                <div>
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= rst.getString(4) %>">
                </div>
            
                <div>
                    <label for="phonenum">Phone Number:</label>
                    <input type="tel" id="phonenum" name="phonenum" value="<%= rst.getString(5) %>">
                </div>
            
                <div>
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="<%= rst.getString(6) %>">
                </div>
            
                <div>
                    <label for="city">City:</label>
                    <input type="text" id="city" name="city" value="<%= rst.getString(7) %>">
                </div>
            
                <div>
                    <label for="state">State:</label>
                    <input type="text" id="state" name="state" value="<%= rst.getString(8) %>">
                </div>
            
                <div>
                    <label for="postalCode">Postal Code:</label>
                    <input type="text" id="postalCode" name="postalCode" value="<%= rst.getString(9) %>">
                </div>
            
                <div>
                    <label for="country">Country:</label>
                    <input type="text" id="country" name="country" value="<%= rst.getString(10) %>">
                </div>
             
                <div>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="<%= rst.getString(12) %>">
                </div>
            
                <div>
                    <% %>
                    <input type="hidden" name="submission" value=true>
                    <button type="submit">Submit</button>
                </div>
            </form>
            
        
            <%
                    if(request.getParameter("firstName")!=null && request.getParameter("firstName").length()>0){
                        String firstName = request.getParameter("firstName");
                        PreparedStatement stmt1 = con.prepareStatement("UPDATE customer SET firstName = ? WHERE customerID = ?");
                        stmt1.setString(1, firstName);
                        stmt1.setInt(2, Integer.parseInt(id));
                        stmt1.executeUpdate();
                        
                        }
                    if(request.getParameter("lastName")!=null && request.getParameter("lastName").length()>0){
                        String lastName = request.getParameter("lastName");
                        PreparedStatement stmt2 = con.prepareStatement("UPDATE customer SET lastName = ? WHERE customerID = ?");
                        stmt2.setString(1, lastName);
                        stmt2.setInt(2, Integer.parseInt(id));
                        stmt2.executeUpdate();
                        
                        }

                    if(request.getParameter("email")!=null && request.getParameter("email").length()>0){
                        String email = request.getParameter("email");
                        PreparedStatement stmt3 = con.prepareStatement("UPDATE customer SET email = ? WHERE customerID = ?");
                        stmt3.setString(1, email);
                        stmt3.setInt(2, Integer.parseInt(id));
                        stmt3.executeUpdate();
                        
                        }
                    if(request.getParameter("phonenum")!=null && request.getParameter("phonenum").length()>0){
                        String phonenum = request.getParameter("phonenum");
                        PreparedStatement stmt4 = con.prepareStatement("UPDATE customer SET phonenum = ? WHERE customerID = ?");
                        stmt4.setString(1, phonenum);
                        stmt4.setInt(2, Integer.parseInt(id));
                        stmt4.executeUpdate();
                        
                        }
                    if(request.getParameter("address")!=null && request.getParameter("address").length()>0){
                        String address = request.getParameter("address");
                        PreparedStatement stmt5 = con.prepareStatement("UPDATE customer SET address = ? WHERE customerID = ?");
                        stmt5.setString(1, address);
                        stmt5.setInt(2, Integer.parseInt(id));
                        stmt5.executeUpdate();
                        
                        }
                    if(request.getParameter("city")!=null && request.getParameter("city").length()>0){
                        String city = request.getParameter("city");
                        PreparedStatement stmt6 = con.prepareStatement("UPDATE customer SET city = ? WHERE customerID = ?");
                        stmt6.setString(1, city);
                        stmt6.setInt(2, Integer.parseInt(id));
                        stmt6.executeUpdate();
                        
                        }
                    if(request.getParameter("state")!=null && request.getParameter("state").length()>0){
                        String state = request.getParameter("state");
                        PreparedStatement stmt7 = con.prepareStatement("UPDATE customer SET state = ? WHERE customerID = ?");
                        stmt7.setString(1, state);
                        stmt7.setInt(2, Integer.parseInt(id));
                        stmt7.executeUpdate();
                        
                        }
                    if(request.getParameter("postalCode")!=null && request.getParameter("postalCode").length()>0){
                        String postalCode = request.getParameter("postalCode");
                        PreparedStatement stmt8 = con.prepareStatement("UPDATE customer SET postalCode = ? WHERE customerID = ?");
                        stmt8.setString(1, postalCode);
                        stmt8.setInt(2, Integer.parseInt(id));
                        stmt8.executeUpdate();
                        
                        }
                    if(request.getParameter("country")!=null && request.getParameter("country").length()>0){
                        String country = request.getParameter("country");
                        PreparedStatement stmt9 = con.prepareStatement("UPDATE customer SET country = ? WHERE customerID = ?");
                        stmt9.setString(1, country);
                        stmt9.setInt(2, Integer.parseInt(id));
                        stmt9.executeUpdate();
                        
                        }
                  
                    if(request.getParameter("password")!=null && request.getParameter("password").length()>0){
                        String password = request.getParameter("password");
                        PreparedStatement stmt11 = con.prepareStatement("UPDATE customer SET password = ? WHERE customerID = ?");
                        stmt11.setString(1, password);
                        stmt11.setInt(2, Integer.parseInt(id));
                        stmt11.executeUpdate();
                        }
                
                        if (request.getParameter("submission") != null) {
                            
                            response.sendRedirect("customer.jsp");
                        }

                    
                
            
                }
                  
                    
    }
    else{
        out.println("No customer found");
        }
        closeConnection();
}
    
   
   
    
    

catch (SQLException ex) {
	out.println(ex);
}
%>
</body>
</html>
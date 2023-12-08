<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Klopp Kits Checkout</title>
    <%@ include file="header.jsp" %>
    <style>
        body {
            margin: 20px;
            color: #333;
        }
        h1 {
            text-align: center;
            margin-bottom: 0px;
        }
        h2 {
            margin-bottom: 20px;
        }
        form {
            max-width: 300px;
            margin: 0 ;
            padding: 20px;
        }
        input[type="password"],
        input[type="submit"],
        input[type="text"],
        input[type="reset"] {
            margin-bottom: 15px;
        }

    </style>
</head>
<body>
<%String userName = (String) session.getAttribute("authenticatedUser");
if(userName != null){
    try
    {
        getConnection();
        Statement stmt = con.createStatement();
        String sql = "SELECT customerId,password FROM customer WHERE userid =?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, userName);
        ResultSet rs = ps.executeQuery();
        if(rs.next())
        {
            String source = "order.jsp?customerId=" + rs.getString(1) + "&Cpassword=" + rs.getString(2);
%>            
            <jsp:forward page="<%= source %>"/>
<%
        }
    }
    catch(Exception e)
    {
        out.println("Error: " + e.getMessage());
    }
    
    %>
<%}
else{%>
<h1 align="center">Checkout Authentication</h1>
<img src="img/checkout-icon-style-vector.png" alt="Profile" style="display: block; margin: 0 auto; width: 15%; border-radius: 10%; overflow: hidden; margin-bottom: 20px; margin-top: 30px;" />
<h2>Enter your customer ID and password to complete the transaction:</h2>

<center>
    <form method="get" action="order.jsp">
        <label for="customerId"><b>Customer ID:</b></label>
        <input type="text" name="customerId" size="50">
        
        <label for="Cpassword"><b>Password:</b></label>
        <input type="password" name="Cpassword" size="50">
        
        <input type="submit" value="Submit" style=" padding: 10px 20px; margin-top: 30px; background-color: transparent; color: #000; border: 2px solid #000; border-radius: 5px; cursor: pointer; font-size: small;"
        onmouseover="this.style.backgroundColor='green'; this.style.color='#fff';" onmouseout="this.style.backgroundColor='transparent'; this.style.color='#000';">
        <input type="reset" value="Reset" style=" padding: 10px 20px; margin-top: 30px; background-color: transparent; color: #000; border: 2px solid #000; border-radius: 5px; cursor: pointer; font-size: small;"
        onmouseover="this.style.backgroundColor='#000'; this.style.color='#fff';" onmouseout="this.style.backgroundColor='transparent'; this.style.color='#000';">
    </form>
    
  </center>
  
<%}%>
</body>
</html>
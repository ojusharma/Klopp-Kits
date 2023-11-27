<!DOCTYPE html>
<html>
<head>
    <title>Klopp's Grocery CheckOut Line</title>
    <style>
        body {
            font-family: Arial, sans-serif;
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

<h1 align="center">Checkout Authentication</h1>
<h2>Enter your customer ID and password to complete the transaction:</h2>

<form method="get" action="order.jsp">
    <label for="customerId">Customer ID:</label>
    <input type="text" name="customerId" size="50">
    
    <label for="Cpassword">Password:</label>
    <input type="password" name="Cpassword" size="50">
    
    <input type="submit" value="Submit">
    <input type="reset" value="Reset">
</form>

</body>
</html>
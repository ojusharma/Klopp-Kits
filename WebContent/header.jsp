<!DOCTYPE html>
<html>
<head>
    <title>Klopp Kits</title>
    <style>
        body {
            margin: 8px 0;
            padding: 0;
            font-family: 'Montserrat', sans-serif;
            text-align: center;
            background-image: url('img/background1.jpg');
            background-size: cover; 
            background-repeat: no-repeat;
        }

        .header {
            padding-bottom: 5px;
            padding-top: 5px;
        }

        .header a {
            color: #000000;
            font-size: 36px;
            text-decoration: none;
            font-weight: bold; 
            transition: color 0.3s ease;
        }

        .header a:hover {
            color: #0055cc;
        }

        .header-links {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px;
            margin-top: 20px;
        }

        .header-links a {
            text-decoration: none;
            color: #2d4358;
            font-size: 16px;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .header-links a:hover {
            color: #cc0000;
        }

        .signed-in {
            color: #0066CC;
            font-size: 16px;
            margin-top: 5px;
            font-weight: bold;
        }

        hr {
            margin-top: 5px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="index.jsp"><img src="img/logo.png" alt="Klopp Kits Logo" width="300" height="80"></a>
        <div class="header-links">
            <% if(session.getAttribute("authenticatedUser") == null) { %>
            <a href="login.jsp">Login</a>
            <%}%>
            <a href="listorder.jsp">List All Orders</a>
            <a href="customer.jsp">Customer Info</a>
            <a href="admin.jsp">Administrators</a>
            <% 
                String userName1 = (String) session.getAttribute("authenticatedUser");
                if (userName1 != null) {%>
             <a href="logout.jsp">Log out</a>
                    <%out.println("<div class='signed-in'>Signed in as: " + userName1 + "</div>");
                }
            %>
        </div>
    </div>
    <hr>
</body>
</html>

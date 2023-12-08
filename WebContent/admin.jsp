<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<style>

    .button-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 250px;
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
</style>
</head>
<body>
    <%@ include file="header.jsp"%> 
    <%
    int admin=-1;
    if((session.getAttribute("isAdmin")).toString()==null)
    {
        session.setAttribute("isAdmin", 0);
    }
    else{
        admin = (int)session.getAttribute("isAdmin");
    }
    
    if(admin!=1){
    	out.println("<h1>You are not authorized to access this page</h1>");
    }
    else{
    %>
    <h2>Administrator Panel</h2>

    <div class="button-container">
        <form action="admin_sales.jsp" method="get">
            <button type="submit">Sales Report</button>
        </form>

        <form action="admin_cust.jsp" method="get">
            <button type="submit">Customer Information</button>
        </form>
        <form action="loaddata.jsp" method="get">
            <button type="submit">Restore Database</button>
        </form>
        <form action="inv.jsp" method="get">
            <button type="submit">Inventory</button>
        </form>
    </div>
    <%}%>

</body>
</html>

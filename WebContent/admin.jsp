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
        height: 150px;
    }

    .button-container form {
        margin: 10px 0;
    }

    .button-container button {
        padding: 10px 20px;
        background-color: #3498db;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .button-container button:hover {
        background-color: #2980b9;
    }
</style>
</head>
<body>
    <%@ include file="header.jsp" %>
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
    </div>

</body>
</html>

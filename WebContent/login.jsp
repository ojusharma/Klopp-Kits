<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<body>
	<%@ include file="header.jsp" %>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Login to System</h3>
<img src="img/profile-pic.png" alt="Profile" style="display: block; margin: 0 auto; width: 15%; border-radius: 10%; overflow: hidden; margin-bottom: 20px; margin-top: 30px;" />

<%
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font size=larger>Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font size=larger>Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10" ></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Log In" style=" padding: 10px 20px; margin-top: 30px; background-color: transparent; color: #000; border: 2px solid #000; border-radius: 5px; cursor: pointer; font-size: small;"
onmouseover="this.style.backgroundColor='#000'; this.style.color='#fff';" onmouseout="this.style.backgroundColor='transparent'; this.style.color='#000';">
</form>

</div>

</body>
</html>


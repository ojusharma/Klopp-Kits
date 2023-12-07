<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="jdbc.jsp" %>

<%

// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
String idToRemove = request.getParameter("id");
productList.remove(idToRemove);
session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="jdbc.jsp" %>

<%


@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{
	productList = new HashMap<String, ArrayList<Object>>();
}
String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
Integer quantity = new Integer(1);

// Store product information in an ArrayList
ArrayList<Object> product = new ArrayList<Object>();
product.add(id);
product.add(name);
product.add(price);
product.add(quantity);
if (productList.containsKey(id))
{
    product = productList.get(id);
    int curAmount = ((Integer) product.get(3)).intValue();
    
    
    product.set(3, new Integer(curAmount - 1));

    // Check if the new amount is zero
    if (curAmount == 1) {
        productList.remove(id);
    }

    session.setAttribute("productList", productList);
}
else {
    productList.put(id, product);
    session.setAttribute("productList", productList);
}
%>
<jsp:forward page="showcart.jsp" />

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="jdbc.jsp" %>

<%

@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

	try{
if (productList == null)
{	
	productList = new HashMap<String, ArrayList<Object>>();
}

String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
Integer quantity = new Integer(1);

ArrayList<Object> product = new ArrayList<Object>();
product.add(id);
product.add(name);
product.add(price);
product.add(quantity);

getConnection();
if (productList.containsKey(id))
{	
	
	String sql = "SELECT SUM(quantity),productId FROM productInventory WHERE productId = ? Group by productId";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setInt(1, Integer.parseInt(id));
	ResultSet rs = ps.executeQuery();
	if(rs.next())
	{
	int qty = rs.getInt(1);
	
	product = (ArrayList<Object>) productList.get(id);
	int curAmount = ((Integer) product.get(3)).intValue();
		if(curAmount< qty)
		{
			product.set(3, new Integer(curAmount+1));
		}
		else
		{
			out.println("<script>alert('Product limit reached');</script>");
		}
	}
}
else
{
	String sql = "SELECT SUM(quantity),productId FROM productInventory WHERE productId = ? GROUP BY productId";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setInt(1, Integer.parseInt(id));
	ResultSet rs = ps.executeQuery();
	if(rs.next())
	{
	int qty = rs.getInt(1);
	
	if(qty==0)
	{
		out.println("<script>alert('Product out of stock');</script>");
	}
	else
	{	productList.put(id,product);}
	}
}

session.setAttribute("productList", productList);
closeConnection();
}
catch(Exception e)
{
	out.println("Error: " + e);
}
%>
<jsp:forward page="showcart.jsp" />
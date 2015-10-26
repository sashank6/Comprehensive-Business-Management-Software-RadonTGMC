<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    HttpSession ses=request.getSession();
    String userid=null;
    try
    {
    userid=(String)ses.getAttribute("userid");
    long hh=Long.parseLong(userid);
    if(hh>=300000&&hh<400000||hh==666)
    {
    }
    else
    response.sendRedirect("home.jsp");
    }
    catch(Exception e)
    {
    response.sendRedirect("home.jsp");
    }
    
    
     %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body>
     <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        <a href="logout.jsp" style="float:right; color:white; font-size:16px; ">Log out</a>
    </h1>


<ul>
    <li><a href="admin_send_message.jsp">Send Message</a></li>
    <li><a href="view_retailer_messages.jsp">View Messages</a></li>
    <li><a href="view_products.jsp">View Products</a></li>
    <li><a href="retailer_view_orders.jsp">View Orders</a></li>
    </ul>
<br/>
<br/>
<h2>Welcome Retailer</h2>
</body>
</html>
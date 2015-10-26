<%-- 
    Document   : view_products
    Created on : 11 Apr, 2013, 9:56:30 AM
    Author     : Aneesh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="sashank.Sashank"%>
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        <br/><br/>
        <table border="1">
        <th>Model No:</th><th>Make</th><th>Quantity</th><th>MRP</th><th>Buy @</th>
   <%
    Sashank obj=new Sashank();
    Connection con=obj.getCon();
    PreparedStatement pstmt=con.prepareStatement("select pid,modelno,make,qty,mrp,sp from rad_act_inv");
    ResultSet rs=pstmt.executeQuery();
    while(rs.next())
    {
    %>
        <tr>
            <td><%=rs.getString(2)%></td>
            <td><a href="view_prod_desc.jsp?proid=<%=rs.getLong(1)%>"><%=rs.getString(3)%></a></td>
            <td><%=rs.getInt(4)%></td>
            <td><%=rs.getDouble(5)%></td>
            <td><%=rs.getDouble(6)%></td>
            
        </tr>
        <%
    }
    %>
    </table>
    </body>
</html>

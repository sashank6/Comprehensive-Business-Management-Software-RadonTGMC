<%-- 
    Document   : retailer_view_orders
    Created on : 11 Apr, 2013, 1:15:58 PM
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
        <title>Retailer View Orders</title>
        <link type="text/css" rel="stylesheet" href="style.css"/>
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
        <table border="1">
            <th>Order ID</th><th>Quantity</th><th>Product ID</th><th>Price Per Unit</th><th>Status</th><th>Date of Order</th><th>Estimated Order of Delivery</th>
        <%
            Sashank obj=new Sashank();
            Connection con=obj.getCon();
            PreparedStatement pstmt=con.prepareStatement("select *from rad_odrder_ret where rid=?");
            pstmt.setLong(1, Long.parseLong(userid));
            ResultSet rs=pstmt.executeQuery();
            while(rs.next())
            {
            
        %>
            <tr>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getInt(2)%></td>
                <td><%=rs.getLong(3)%></td>
                <td><%=rs.getDouble(4)%></td>
                <td><%
                int x=rs.getInt(5);
                if(x==0)
                    out.println("Awaiting Admin Approval");
                else
                    if(x==1)
                        out.println("Approved");
                else
                        if(x==2)
                            out.println("Intransit");
                else
                            if(x==3)
                                out.println("Delivered/Completed");
                else
                                if(x==4)
                                    out.println("Order Cancelled By Admin");%>
                <td><%=rs.getDate(6)%></td>
                <td><%=rs.getDate(7)%></td>
                
            </tr>
        <%
            }
            %>
        </table>
    </body>
</html>

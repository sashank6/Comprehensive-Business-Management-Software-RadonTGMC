<%-- 
    Document   : admin_view_act_inv
    Created on : 23 Mar, 2013, 11:49:06 AM
    Author     : Aneesh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="sashank.Sashank"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <%@ page import="java.io.IOException" %>
    <%
    HttpSession ses=request.getSession();
    long userid;
    try
    {
    userid=Long.parseLong((String)ses.getAttribute("userid"));
    if(userid!=666)
    throw new  IOException("Invalid User");
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
        <title>View Active Inventory</title>
        <script type="text/javascript">
            
            function fun1(a)
            {
                window.location="admin_pro_edit.jsp?proid="+a;
            }
            
        </script>
        <link rel="stylesheet" type="text/css" href="style.css"/>
    </head>
    <body>
       <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        <a href="logout.jsp" style="float:right; color:white; font-size:16px; ">Log out</a>
    </h1>
    



<ul>
    <li><a>Retailers</a>
        <ul>
            <li><a href="admin_view_retailer_list.jsp">View Retailers</a></li>
            <li><a href="admin_view_retailer_pending.jsp">Pending Orders</a></li>
            <li><a href="retailer_order_status.jsp">Order Status</a></li>
                
        </ul>
    
    </li>
    <li><a>Vendors</a>
    <ul>
        <li><a href="admin_view_vendor_list.jsp">View Vendors</a></li>
        <li><a href="admin_raise_po.jsp">Raise Purchase Order</a></li>
        <li><a href="admin_view_po.jsp">View Purchase Orders</a></li>
        <li><a href="admin_approve_pay.jsp">Approve Payments</a></li>
    </ul>
        </li>
    <li><a>Transactions</a>
    <ul>
        <li><a href="admin_view_cash_position.jsp">View Cash Position</a></li>
        <li><a href="admin_view_account_statement.jsp">View Account Statement</a></li>
        <li><a href="add_cash_transaction.jsp">Add Cash Transaction</a></li>
    </ul>
        </li>
    <li><a>Inventory</a>
    <ul>
        <li><a href="admin_view_res_inv.jsp">View reserve Inventory</a></li>
        <li><a href="admin_view_act_inv.jsp">View Active Inventory</a></li>
        <li><a href="admin_add_quantity.jsp">Add Quantity</a></li>
    </ul></li>
    <li><a>Products</a>
    <ul>
        <li><a href="admin_view_cat.jsp">View Category</a></li>
        <li><a href="admin_add_category.jsp">Add Category</a></li>
        <li><a href="admin_add_product_sale.jsp">Add New Product</a></li>
    </ul>
        </li>
        <li><a>Messages</a>
            <ul>
                <li><a href="admin_view_message.jsp">View Messages</a></li>
                <li><a href="admin_send_message.jsp">Send Message</a></li>
            </ul></li>
</ul>
<br/>
<br/>
        <table border="1">
            <th>Product ID</th><th>Make</th><th>Model No</th><th>Quantity</th><th>Selling Price</th><th>MRP</th><th>Minimum Order</th><th>Delivery Time</th>
            <%
                Sashank obj=new Sashank();
                Connection con=obj.getCon();
                PreparedStatement pstmt=con.prepareStatement("select pid,make,modelno,qty,sp,mrp,minorder,mumin from rad_act_inv");
                ResultSet rs=pstmt.executeQuery();
                while(rs.next())
                {
                    out.println("<tr onclick=\"fun1("+rs.getLong(1)+")\">");
                    out.println("<td>"+rs.getLong(1)+"</td>");
                    out.println("<td>"+rs.getString(2)+"</td>");
                    out.println("<td>"+rs.getString(3)+"</td>");
                    out.println("<td>"+rs.getInt(4)+"</td>");
                    out.println("<td>"+rs.getDouble(5)+"</td>");
                    out.println("<td>"+rs.getDouble(6)+"</td>");
                    out.println("<td>"+rs.getInt(7)+"</td>");
                    out.println("<td>"+rs.getInt(8)+"</td>");
                    out.println("</tr>");
                }
                
    
            %>
        </table>
    </body>
</html>

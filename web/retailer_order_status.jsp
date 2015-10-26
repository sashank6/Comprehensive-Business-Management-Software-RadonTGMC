<%-- 
    Document   : retailer_order_status
    Created on : 11 Apr, 2013, 3:11:05 PM
    Author     : Aneesh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="sashank.Sashank"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Retailer Orders</title>
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
            <th>Order ID</th><th>Quantity</th><th>Product ID</th><th>Price Per Unit</th><th>Total Order Value</th><th>Date of Order</th><th>Date of Delivery</th><th>Retailer ID</th><th>Status</th>
        <%
        Sashank obj=new Sashank();
        Connection con=obj.getCon();
        PreparedStatement pstmt=con.prepareStatement("select *from rad_odrder_ret");
        ResultSet rs=pstmt.executeQuery();
        while(rs.next())
        {
        
        
        %>
        <tr>
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getInt(2)%></td>
            <td><a href="admin_view_prod_detail.jsp?proid=<%=rs.getLong(3)%>"><%=rs.getLong(3)%></a></td>
            <td><%=rs.getDouble(4)%></td>
            <td><%=rs.getInt(2)*rs.getDouble(4)%></td>
            <td><%=rs.getDate(6)%></td>
            <td><%=rs.getDate(7)%></td>
            <td><a href="view_retailer_details.jsp?retailer=<%=rs.getLong(8)%>"><%=rs.getLong(8)%></a></td>
            <td><%
            int x=rs.getInt(5);
            if(x==0)
                out.println("Awaiting Admin Approval");
            else
                if(x==1)
                    out.println("Order Accepted");
            else
                    if(x==2)
                        out.println("Intransit");
            else
                        if(x==3)
                            out.println("Delivered/Completed");
            else
                            if(x==4)
                                out.println("Order Cancelled");
%></td>
        </tr>
        <%}%>
        </table>
    </body>
</html>

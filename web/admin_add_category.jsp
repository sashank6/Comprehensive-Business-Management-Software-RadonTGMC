<%-- 
    Document   : admin_add_category
    Created on : 22 Mar, 2013, 10:50:06 PM
    Author     : Aneesh
--%>

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
        <title>Add Category</title>
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
        <form action="admin_add_cat" method="POST">
            <table border="1">
                <tr>
                    <td>Parent Category</td>
                    <td><input type="text" name="parcat"/></td>
                </tr>
                <tr>
                    <td>Child Category</td>
                    <td><input type="text" name="chicat"/></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Add Category"/></td>
                </tr>
            </table>
        </form>
    </body>
</html>

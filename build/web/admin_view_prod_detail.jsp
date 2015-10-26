<%-- 
    Document   : view_prod_desc
    Created on : 11 Apr, 2013, 10:11:28 AM
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
    if(hh==666)
    {
    }
    else
    response.sendRedirect("home.jsp");
    }
    catch(Exception e)
    {
    response.sendRedirect("home.jsp");
    }
    
    String pid=request.getParameter("proid");
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
        <%
    
    
            
            Sashank obj=new Sashank();
            Connection con=obj.getCon();
            PreparedStatement pstmt=con.prepareStatement("select *from rad_act_inv where pid=?");
            pstmt.setLong(1, Long.parseLong(pid));
            ResultSet rs=pstmt.executeQuery();
            while(rs.next())
            {
            
        %>
        <tr>
            <td>Make</td>
            <td><%=rs.getString(2)%></td>
        </tr>
        <tr>
            <td>Model No:</td>
            <td><%=rs.getString(3)%></td>
        </tr>
        <tr>
            <td>Quantity Available</td>
            <td id="qtyid"><%=rs.getInt(4)%></td>
        </tr>
        <tr>
            <td>MRP</td>
            <td><%=rs.getDouble(5)%></td>
        </tr>
        <tr>
            <td>Selling Price</td>
            <td><%=rs.getDouble(6)%></td>
        </tr>
        <tr>
            <td>Cost Price</td>
            <td><%=rs.getDouble(7)%></td>
        </tr>
        <tr>
            <td>Description</td>
            <td><%=rs.getString(8)%></td>
        </tr>
        <tr>
            <td >Minimum Order Quantity</td>
            <td id="minorder"><%=rs.getInt(10)%></td>
        </tr>
        <tr>
            <td>Shipping Cost</td>
            <td><%=rs.getDouble(11)%></td>
        </tr>
        <tr>
            <td>Shipping Time(in days)</td>
            <td><%=rs.getInt(13)%></td>
        </tr>
        <%
            }
            %>
    </table>
    <br/>
    <br/>
   
    </body>
</html>

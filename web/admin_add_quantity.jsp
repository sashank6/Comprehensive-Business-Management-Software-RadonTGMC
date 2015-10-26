<%-- 
    Document   : admin_add_quantity
    Created on : 23 Mar, 2013, 1:29:56 PM
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
        <title>Add Quantity to Active Inventory</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function fun()
            {
                var make=document.getElementById("make").options[document.getElementById("make").selectedIndex].value;
                var p=$.ajax({
                    type:"POST",
                    url:"return_act_inv_model",
                    async:false,
                    dataType:"html",
                    data:{make:make}
                    
                    
                    
                }).responseText;
                document.getElementById("model").innerHTML=p;
            }
            function fun2()
            {
                 var make=document.getElementById("make").options[document.getElementById("make").selectedIndex].value;
                var model=document.getElementById("model").options[document.getElementById("model").selectedIndex].value;
                var p1=$.ajax({
                     type:"POST",
                     url:"return_qty_admin",
                     async:false,
                     dataType:"html",
                     data:{make:make,model:model}
                  }).responseText;
                  document.getElementById("qtyr").innerHTML=p1;
            }
            function add()
            {
                var make=document.getElementById("make").options[document.getElementById("make").selectedIndex].value;
                var model=document.getElementById("model").options[document.getElementById("model").selectedIndex].value;
                var qty=document.getElementById("qty").value;
        var p=$.ajax({
                    type:"POST",
                    url:"admin_add_quantity",
                    async:false,
                    dataType:"html",
                    data:{make:make,model:model,qty:qty}
                    
                    
                    
                }).responseText;
            }
        </script>
        <link rel="stylesheet" type="text/css" href="style.css"/>
    </head>
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
            <tr>
                <td>Make</td>
                <td>
            <select id="make" onchange="fun()">
                <option>None</option>
                <%
                    Sashank obj=new Sashank();
                    Connection con=obj.getCon();
                    PreparedStatement pstmt=con.prepareStatement("select distinct make from rad_act_inv");
                    ResultSet rs=pstmt.executeQuery();
                    while(rs.next())
                    {
                        out.println("<option>"+rs.getString(1)+"</option>");
                    }
                    
                    
                %>
            </select>
                </td>
            </tr>
            <tr>
                <td>Product Name</td>
                <td>
                    <select id="model" onchange="fun2()">
                        
                    </select>
                </td>
            </tr>
            <tr>
                <td>Quantity to Be Added</td>
                <td>
                    <input type="text" id="qty"/>
                </td>
            </tr>
            <tr>
                <td>Quantity in Reserve Inventory</td>
                <td id="qtyr"></td>
            </tr>
            <tr>
                <td colspan="2"><input type="button" value="Add" onclick="add()"/></td>
            </tr>
        </table>
    </body>
</html>

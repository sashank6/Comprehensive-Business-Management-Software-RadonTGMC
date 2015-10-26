<%-- 
    Document   : admin_pro_edit
    Created on : 23 Mar, 2013, 12:33:06 PM
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
    
    String proid1=request.getParameter("proid");
            long proid=Long.parseLong(proid1);
     %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function fun()
            {
                var proid="<%=proid%>";
                var mrp=document.getElementById("mrp").value;
                var sp=document.getElementById("sp").value;
                var desc=document.getElementById("desc").value;
                var kw=document.getElementById("kw").value;
                var minorder=document.getElementById("minorder").value;
                var shipcost=document.getElementById("shipcost").value;
                var dtime=document.getElementById("dtime").value;
                var p=$.ajax({
                    type:"POST",
                    url:"admin_pro_edit",
                    async:false,
                    dataType:"html",
                    data:{proid:proid,mrp:mrp,sp:sp,desc:desc,kw:kw,minorder:minorder,shipcost:shipcost,dtime:dtime}
                    
                    
                    
                }).responseText;
                alert(p);
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
        <table border="1" align="center">
        <%
            
            Sashank obj=new Sashank();
            Connection con=obj.getCon();
            PreparedStatement pstmt=con.prepareStatement("select *from rad_act_inv where pid=?");
            pstmt.setLong(1, proid);
            ResultSet rs=pstmt.executeQuery();
            String desc="",kw="";
            double sp=0,mrp=0,shipcost=0;
            int minorder=0,dtime=0;
            while(rs.next())
            {
                mrp=rs.getDouble(5);
                sp=rs.getDouble(6);
                desc=rs.getString(8);
                kw=rs.getString(9);
                minorder=rs.getInt(10);
                shipcost=rs.getDouble(11);
                dtime=rs.getInt(13);
            }
            
        
        %>
        <tr>
            <td>MRP</td>
            <td><input type="text" id="mrp" value="<%=mrp%>"/></td>
        </tr>
        <tr>
            <td>Selling Price</td>
            <td><input type="text" id="sp" value="<%=sp%>"/></td>
        </tr>
        <tr>
            <td>Description</td>
            <td><textarea id="desc"><%=desc%></textarea></td>
        </tr>
        <tr>
            <td>Keywords</td>
            <td><textarea id="kw"><%=kw%></textarea></td>
        </tr>
        <tr>
            <td>Minimum Order Quantity</td>
            <td><input type="text" id="minorder" value="<%=minorder%>"/></td>
        </tr>
        <tr>
            <td>Shipping Cost</td>
            <td><input type="text" id="shipcost" value="<%=shipcost%>"/></td>               
        </tr>
        <tr>
            <td>Delivery Time</td>
            <td><input type="text" id="dtime" value="<%=dtime%>"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="button" value="Update" onclick="fun()"/></td>
        </tr>
        </table>
    </body>
</html>

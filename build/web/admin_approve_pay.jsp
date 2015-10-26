
<%@page import="java.io.IOException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="sashank.Sashank"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Vendor Payment Approval</title>
        <script type="text/javascript" src="jquery.js"></script>
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
            <th>PO ID</th><th>Vendor Name</th><th>Quantity</th><th>Model No</th><th>Make</th><th>Order Value</th><th>Status</th><th>Order Time</th><th>Payment Type</th><th>Actions</th>
            <%
    int x;
          Sashank obj=new Sashank();
          Connection con=obj.getCon();
          PreparedStatement pstmt=con.prepareStatement("select *from rad_po_ven where status=5 AND payment=1");
          ResultSet rs=pstmt.executeQuery();
          while(rs.next())
          {
              out.println("<tr>");
              out.println("<td>");String gui;
              gui=rs.getString(1);
              out.println(gui);
              out.println("</td>");
              out.println("<td>");
             long useridd=rs.getLong(2);
             PreparedStatement pstmt2=con.prepareStatement("select cname from rad_vendor where userid=?");
             pstmt2.setLong(1, useridd);
             ResultSet rs2=pstmt2.executeQuery();
             String companyname="";
             while(rs2.next())
                 companyname=rs2.getString(1);
             out.println(companyname);
              out.println("</td>");
              out.println("<td>");
              int qty=rs.getInt(3);
              out.println(qty);
              out.println("</td>");
              out.println("<td>");
              out.println(rs.getString(4));
              out.println("</td>");
              out.println("<td>");
              out.println(rs.getString(5));
              out.println("</td>");
              out.println("<td>");
              //out.println(rs.getDouble(6)*qty);
              double pricree=rs.getDouble(6);
              out.println(pricree*qty);
              out.println("</td>");
              out.println("<td>");
               x=rs.getInt(7);
              out.println("Order Completed");
              out.println("</td>");
              out.println("<td>");
              out.println(rs.getTimestamp(8));
              out.println("</td>");
              int yy=rs.getInt(9);
              out.println("<td>");
              if(yy==0)
                  out.println("Immediate");
              else
                  out.println("Deferred");
              out.println("</td>");
              out.println("<td>");
              out.println("<input type=\"button\" value=\"Approve Payment\" onclick=\"fun(\'"+gui+"\',"+useridd+","+pricree*qty+")\"/>");              
              out.println("</td>");
              out.println("</tr>");
               
          }
          out.println("</table>");
          
         %>
            
        </table>
         <script type="text/javascript">
            function fun(order,vid,tv)
            {
                var p=$.ajax({
                type:"POST",
                url:"approve_pay_ven",
                async:false,
                dataType:"html",
                data:{poid:order,vid:vid,tv:tv}
                }).responseText;
                alert(p);
                window.location="admin_approve_pay.jsp";
                
                
            }
        </script>
    </body>
</html>

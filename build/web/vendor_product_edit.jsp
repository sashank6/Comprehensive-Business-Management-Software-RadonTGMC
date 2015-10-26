<%-- 
    Document   : vendor_product_edit
    Created on : 22 Mar, 2013, 9:05:24 PM
    Author     : Aneesh
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="sashank.Sashank"%>
<%
    HttpSession ses=request.getSession();
    long userid=-1;
    try
    {
    userid=Long.parseLong((String)ses.getAttribute("userid"));
        
    }
    catch(Exception e)
    {
    response.sendRedirect("home.jsp");
    }
    
    //String cat=request.getParameter("cat");
    
    
     %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Product</title>
        <link rel="stylesheet" type="text/css" href="style.css"/>
    </head>
    <body>
         <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        <a href="logout.jsp" style="float:right; color:white; font-size:16px; ">Log out</a>
    </h1>
        <ul>
    <li>
        <% 
out.println("<a href=\"view_vendor_details.jsp?vid="+userid+"\">View Profile</a>");
%>
    </li>
    <li><a>Messages</a>
        <ul>
            <li><a href="retailer_send_message.jsp">Send Messages</a></li>
            <li><a href="view_messages.jsp">View Messages</a></li>
        </ul>
    </li>
    <li>
        <a>Products</a>
        <ul>
            <li><a href="vendor_addproducts.jsp"> Add Products</a></li>
            <li><a href="vendor_products_list.jsp?cat=0">View Product List</a></li>
        </ul>
    </li>
    <li>
        <a href="vendor_view_po.jsp">View Purchase Orders</a>
    </li>
    <li><a href="vendor_view_payments.jsp">View Payments</a></li>
</ul>
    <br/>
    <br/>
        <%
            String make=request.getParameter("make");
            String model=request.getParameter("model");
            Sashank obj=new Sashank();
            Connection con=obj.getCon();
            PreparedStatement pstmt=con.prepareStatement("select *from v_"+userid+"_products where make=? and modelno=?");
            pstmt.setString(1, make);
            pstmt.setString(2, model);
            ResultSet rs=pstmt.executeQuery();
            double cprice=0,mrp=0;
            int qty=0;
            String desc="";
            while(rs.next())
            {
            cprice=rs.getDouble(3);
            mrp=rs.getDouble(4);
            desc=rs.getString(5);
            int avbl=rs.getInt(6);
            qty=rs.getInt(7);
            }
            
            
        %>
        
        
            <table border="1">
                <tr>
                    <td>Make</td><td id="make"><%=make%></td>
                </tr>
                <tr>
                    <td>Model</td><td id="model"><%=model%></td>
                </tr>
                <tr>
                    <td>Selling Price</td><td><input type="text" id="cprice" value="<%=cprice%>"</td>
                </tr>
                <tr>
                    <td>MRP</td><td><input type="text" id="mrp" value="<%=mrp%>"</td>
                </tr>
                <tr>
                    <td>Description</td><td><textarea id="desc"><%=desc%></textarea></td>
                </tr>
                <tr>
                    <td>Quantity</td><td><input type="text" id="qty" value="<%=qty%>"/></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="button" value="Update" onclick="funk()"/></td>
                </tr>
                
            </table>
                <script type="text/javascript">
                    function funk()
                    {
                       
                        var make=document.getElementById("make").innerHTML;
                        var model=document.getElementById("model").innerHTML;
                        var price=document.getElementById("cprice").value;
                        var qty=document.getElementById("qty").value;
                        var desc=document.getElementById("desc").value;
                        var mrp=document.getElementById("mrp").value;
                        
                        window.location="vendor_product_edit?make="+make+"&model="+model+"&qty="+qty+"&desc="+desc+"&price="+price+"&mrp="+mrp;
                    }
                </script>
    </body>
</html>

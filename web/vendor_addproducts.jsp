<%-- 
    Document   : vendor_addproducts
    Created on : 19 Mar, 2013, 9:26:28 PM
    Author     : Aneesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
     %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vendor Add Products</title>
        <script type="text/javascript">
            function funcy()
            {
                var make=document.getElementById("make").value;
                var modelno=document.getElementById("modelno").value;
                var price=document.getElementById("price").value;
                var qty=document.getElementById("qty").value;
                var mrp=document.getElementById("mrp").value;
                var desc=document.getElementById("desc").value;
                var descv=/^[A-Za-z0-9\s\.]{20,1980}$/;
                var makev=/^[A-Za-z0-9\s]{3,}$/;
                var modelnov=/^[A-Za-z0-9/-\s]{3,}$/;
                var pricev=/^[0-9]{1,}.[0-9]*/;
                var qtyv=/^[0-9]{1,}$/;
                if(makev.test(make)&&modelnov.test(modelno)&&pricev.test(mrp)&&pricev.test(price)&&qtyv.test(qty)&&descv.test(desc))
                    return true;
                else
                    {
                        alert("Invalid Format");
                    return false;
                    }
                
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
        <form method="POST" onsubmit="return funcy();" action="vendor_add_products">
            <table>
                <tr>
                    <td>
                        Make
                    </td>
                    <td>
                        <input type="text" id="make" name="make"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        Model No
                    </td>
                    <td>
                        <input type="text" name="model" id="modelno"/>
                    </td>
                </tr>
                
                <tr>
                    <td>
                        Price
                    </td>
                    <td>
                        <input type="text" name="price" id="price"/>
                    </td>
                </tr>
                
                <tr>
                    <td>
                        Quantity
                    </td>
                    <td>
                        <input type="text" name="qty" id="qty"/>
                    </td>
                </tr>
                
                <tr>
                    <td>
                        MRP
                    </td>
                    <td>
                        <input type="text" name="mrp" id="mrp"/>
                    </td>
                </tr>
                
                <tr>
                    <td>
                        Availability
                    </td>
                    <td>
                        <input type="radio" name="avb" id="avb" value="Yes"><label>Yes</label>
                        <input type="radio" name="avb" id="avb1" value="No"><label>No</label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Description
                    </td>
                    <td>
                        <textarea id="desc" name="desc"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><input type="submit" value="Add Product"/></td>
                </tr>
            </table>
            
        </form>
    </body>
</html>

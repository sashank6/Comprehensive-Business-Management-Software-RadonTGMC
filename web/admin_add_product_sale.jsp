<%-- 
    Document   : admin_add_product_sale
    Created on : 22 Mar, 2013, 11:23:07 PM
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
        <title>Add Product Sale</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            var makert,makert1;
            function fun()
            {
                 var makert1=document.getElementById("parentcat").options[document.getElementById("parentcat").selectedIndex].value;
                  if(document.getElementById("parentcat").selectedIndex!=0)
                      {
        
                    var p=$.ajax({
                     type:"POST",
                     url:"return_child_cat",
                     async:false,
                     dataType:"html",
                     data:{parentcat:makert1}
                  }).responseText;
                  document.getElementById("chicat").innerHTML=p;
                      }
                  
            }
            
            function fun1()
            {
               makert=document.getElementById("make1").options[document.getElementById("make1").selectedIndex].value;
                  if(document.getElementById("make1").selectedIndex!=0)
                      {
        
                    var p=$.ajax({
                     type:"POST",
                     url:"return_modelno_admin",
                     async:false,
                     dataType:"html",
                     data:{make:makert}
                  }).responseText;
                 
                  document.getElementById("model1").innerHTML=p;
                      }
                    
            }
            var makert2;
            function fun3()
            {
                 makert2=document.getElementById("model1").options[document.getElementById("model1").selectedIndex].value;
                var p=$.ajax({
                     type:"POST",
                     url:"return_cost_admin",
                     async:false,
                     dataType:"html",
                     data:{make:makert,model:makert2}
                  }).responseText;
                 
                  document.getElementById("costpu").innerHTML=p;
                  var p1=$.ajax({
                     type:"POST",
                     url:"return_qty_admin",
                     async:false,
                     dataType:"html",
                     data:{make:makert,model:makert2}
                  }).responseText;
                 
                  document.getElementById("qty").innerHTML=p1;
                  
                  document.getElementById("costpu").innerHTML=p;
                  var p2=$.ajax({
                     type:"POST",
                     url:"return_mrp_admin",
                     async:false,
                     dataType:"html",
                     data:{make:makert,model:makert2}
                  }).responseText;
                 
                  document.getElementById("mrp").innerHTML=p2;
            }
            function addprod()
            {
                
                var parentcat=document.getElementById("parentcat").options[document.getElementById("parentcat").selectedIndex].value;
                var childcat=document.getElementById("chicat").options[document.getElementById("chicat").selectedIndex].value;
                var make=document.getElementById("make1").options[document.getElementById("make1").selectedIndex].value;
                var model=document.getElementById("model1").options[document.getElementById("model1").selectedIndex].value;
                var qty=document.getElementById("qtytrnfs").value;
                var sp=document.getElementById("sp").value;
                var desc=document.getElementById("desc").value;
                var kw=document.getElementById("kw").value;
                var min=document.getElementById("minorder").value;
                var scost=document.getElementById("shipcost").value;
                var dtime=document.getElementById("shipde").value;
                var aqty=document.getElementById("qty").innerHTML;
                var cmrp=document.getElementById("mrp").innerHTML;
                var cp=document.getElementById("costpu").innerHTML;
                cp=parseFloat(cp);
                aqty=parseInt(aqty);
                cmrp=parseFloat(cmrp);
                if(aqty<qty||cmrp<sp)
                    alert("Specified quantity is More than Availability or Cannot Sell more than MRP");
                else
                    {
                        var p=$.ajax({
                            type:"POST",
                            url:"add_product_toact_admin",
                            async:false,
                            dataType:"html",
                            data:{make:make,pcat:parentcat,ccat:childcat,model:model,mrp:cmrp,sp:sp,qty:qty,dtime:dtime,desc:desc,kw:kw,shipcost:scost,minorder:min,cp:cp}
                            
                            
                            
                        }).responseText;
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
                <td>Parent Category</td>
                <td><select id="parentcat" onchange="fun()">
                        <option>None</option>
        <%
        Sashank obj=new Sashank();
        Connection con=obj.getCon();
        PreparedStatement pstmt=con.prepareStatement("select distinct parentcat from rad_pro_catid order by parentcat");
        ResultSet rs=pstmt.executeQuery();
        while(rs.next())
        {
            out.println("<option>"+rs.getString(1)+"</option>");
        }
        
        
        
        %>
                    </select></td>
        </tr>
        <tr>
            <td>Child Category</td>
            <td>
                <select id="chicat">
                    
                </select>
                
            </td>
        </tr>
        <tr>
            <td>Make</td>
            <td>
                <select id="make1" onchange="fun1()">
                    <option>None</option>
                    <%
                    pstmt=con.prepareStatement("select make from rad_res_inv where qty>0");
                    rs=pstmt.executeQuery();
                    while(rs.next())
                        out.println("<option>"+rs.getString(1)+"</option>");
                    
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td>Model No</td>
            <td><select id="model1" onchange="fun3()">
                    
                </select></td>
        </tr>
        <tr>
            <td>Cost Per Unit</td>
            <td id="costpu">
                
            </td>
        </tr>
        <tr>
            <td>Quantity Available</td>
            <td id="qty">
                
            </td>
        </tr>
        <tr>
            <td>
                MRP
            </td>
            <td id="mrp">
                
            </td>
        </tr>
        <tr>
            <td>Quantity to be Transferred</td>
            <td>
                <input type="text" id="qtytrnfs"/>
            </td>
        </tr>
        <tr>
            <td>Selling Price</td>
            <td>
                <input type="text" id="sp"/>
            </td>
        </tr>
        <tr>
            <td>Description</td>
            <td><textarea id="desc"></textarea>
            </td>
        </tr>
        <tr>
            <td>Keywords</td>
            <td><textarea id="kw"></textarea></td>
        </tr>
        <tr>
            <td>Minimum Order Quantity</td>
            <td><input type="text" id="minorder"/></td>
        </tr>
        <tr>
            <td>Shipping Cost</td>
            <td><input type="text" id="shipcost"/></td>
        </tr>
        <tr>
            <td>Delivery time(in days)</td>
            <td><input type="text" id="shipde"/></td>
        </tr>
        
        
        </table>
                <input type="button" value="Add Product" onclick="addprod()"/>
    </body>
</html>

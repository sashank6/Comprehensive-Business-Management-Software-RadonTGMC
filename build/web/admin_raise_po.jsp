<%-- 
    Document   : admin_raise_po
    Created on : 19 Mar, 2013, 11:38:52 PM
    Author     : Aneesh
--%>

<%@page import="sashank.Sashank"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
        <title>Raise Purchase Order</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
        function listmodels()
        {
           
        var makert=document.getElementById("selections1").options[document.getElementById("selections1").selectedIndex].value;
        if(document.getElementById("selections1").selectedIndex==0)
            {
                
            }
            else
                {
        var p=$.ajax({
        type:"POST",
        url:"admin_listmodels",
        async:false,
        data:{make:makert},
        dataType:"html"
                    }).responseText;
                    
                    if(p==0)
                        {
                            alert("Something Went Wrong");
                            
                        }
                        else
                            document.getElementById("modelno1").innerHTML=p;
                }
                            
        }
        function getPrices()
        {
            var makert=document.getElementById("selections1").options[document.getElementById("selections1").selectedIndex].value;
            var makert1=document.getElementById("modelno1").options[document.getElementById("modelno1").selectedIndex].value; 
            var qty1=document.getElementById("qty").value;
        var p=$.ajax({
        type:"POST",
        url:"GetPricesVendorsPO",
        async:false,
        data:{make:makert,model:makert1,qty:qty1},
        dataType:"html"
                    }).responseText;
                   
                    if(p==0)
                        {
                            alert("Something Went Wrong");
                            
                        }
                        else
                            document.getElementById("onedork").innerHTML=p;
                            
        }
        function fungh(a,yuse)
        {
           
           
            var make=document.getElementById("selections1").options[document.getElementById("selections1").selectedIndex].value;
            var model=document.getElementById("modelno1").options[document.getElementById("modelno1").selectedIndex].value;
            var qty=document.getElementById("qty").value;
            var pymt=document.getElementById("pymt").options[document.getElementById("pymt").selectedIndex].value;
            var amt=document.getElementById("amt2").innerHTML;
           
            if(parseFloat(amt)<(parseFloat(yuse)*parseInt(qty)))
                alert("Insufficient Funds");
            else
                {
                    var p=$.ajax({
                    type:"POST",
                    url:"admin_raise_po",
                    async:false,
                    data:{make1:make,model1:model,vid1:a,qty1:qty,price1:yuse,pymt1:pymt},
                    dataType:"html"
                    }).responseText;
                    if(p==1)
                        alert("Transaction Successful");
                    else
                        alert("Transaction Failed");
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
                <td>
                    Make
                </td>
                <td>
                    <select id="selections1" onchange="listmodels();">
                        <option>None</option>
                <%
    Sashank obj=new Sashank();
    Connection con=obj.getCon();
    PreparedStatement pstmt=con.prepareStatement("select userid from rad_login where userclass=3 and accountstat=1");
    ResultSet rs=pstmt.executeQuery();
    while(rs.next())
    {
        long venuserid=rs.getLong(1);
        PreparedStatement pstmt1=con.prepareStatement("select make from v_"+venuserid+"_products");
        ResultSet rs1=pstmt1.executeQuery();
        while(rs1.next())
        {
            String maker1=rs1.getString(1);
            if(!obj.verifymake(maker1))
                obj.pushmaker(maker1);
        }
    }
    
    int makerct=obj.makerctc();
    for(int i=0;i<makerct;i++)
        out.println("<option>"+obj.popmaker()+"</option>");
           
    
    
    %>
    </select>
    </td>
            </tr>
            <tr>
                <td>
                    Model No
                </td>
                <td>
                    <select id="modelno1">
                        
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    Quantity
                </td>
                <td>
                    <input type="text" id="qty"/>
                </td>
            </tr>
            <tr>
                <td>
                    Payment Type
                </td>
                <td>
                    <select id="pymt">
                        <option>Immediate</option>
                        <option>Deferred</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    Available Funds
                </td>
                 <% 
    Sashank obj1=new Sashank();
    Connection con1=obj.getCon();
    PreparedStatement pstmt3=con1.prepareStatement("select amt from rad_cash_table where id=1");
    ResultSet rs3=pstmt3.executeQuery();
    double amt=0;
    while(rs3.next())
    {
        amt=rs3.getDouble(1);
    }
    
    con1.close();
    pstmt3.close();
    rs3.close();
                    %>
                <td id="amt2">
                   
                  <%=amt%>  
                </td>
            </tr>
        </table>
    <br/>
    <input type="button" value="Get Prices" onclick="getPrices();"/>
    <br/>
    <table id="onedork" border="1">
        
    </table>
    </body>
</html>

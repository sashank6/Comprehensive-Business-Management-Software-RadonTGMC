<%@page import="com.ibm.db2.jcc.DB2Driver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*" %>
    <%
    HttpSession ses=request.getSession();
    String userid;
    try
    {
    userid=(String)ses.getAttribute("userid");
    long a=Long.parseLong(userid);
    if(a==666)
    {}
    else
    response.sendRedirect("home.jsp");
    }
    catch(Exception e)
    {
    response.sendRedirect("home.jsp");
    } 
     %>
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Vendor List</title>
<script type="text/javascript" src="jquery.js"></script>
<link rel="stylesheet" type="text/css" href="style.css"/>
<script type="text/javascript">
var pageno=1;
var tcount=0;var type3=4;
function getCount(cat,type)
{
tcount=$.ajax({
type:"POST",
url:"getPageNumbers",
async:false,
data:{cat:cat,type:type},
dataType:"html"
}).responseText;
pageno=1;

}
function onloadlist(cat,type)
{
document.getElementById("hulk").selectedIndex=4;
getCount(3,4);
displayData(4,1);
type3=document.getElementById("hulk").selectedIndex;
}
function prevPage()
{
if(pageno>1)
{
pageno--;
displayData(type3,pageno);
}
else
alert("Invalid Request");
}
function nextpage()
{
if(pageno==tcount)
alert("There is no Next Page");
else
{
pageno++;
displayData(type3,pageno);
}
}
function displayData(type,pageno)
{
var tg=$.ajax({
type:"POST",
url:"viewAllList",
async:false,
data:{cat:3,pageno:pageno,type:type},
dataType:"html"
}).responseText;
document.getElementById("kiwi").innerHTML=tg;
}
function refreshdata()
{
var type3=document.getElementById("hulk").selectedIndex;
getCount(3,type3);
displayData(type3,pageno);

}



</script>
</head>
<body onload="onloadlist()">
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
<h2>View Vendor List</h2>
<select id="hulk">
<option>Permanently Disabled</option>
<option>Active</option>
<option>Freezed</option>
<option>Unapproved</option>
<option>All</option>
</select>&nbsp;
<input type="button" value="Modify List" onclick="refreshdata()"/>
<br/>
<div id="kiwi">


</div>
<br/>
<input type="button" value="Previous Page" onclick="prevPage()"/>&nbsp;
<input type="button" value="Next Page" onclick="nextpage()"/>&nbsp;

</body>
</html>
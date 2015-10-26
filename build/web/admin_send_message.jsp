<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Send Message</title>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
function send()
{
var to=document.getElementById("toad").value;
var sub=document.getElementById("sub").value;
var msg=document.getElementById("msg").value;

var fdg=new RegExp("[0-9]");
var tov=true;
if(tov)
{
var t=$.ajax({
type:"POST",
url:"sendMessage",
async:false,
data:{to:to,sub:sub,msg:msg},
dataType:"html"

}).responseText;
alert(t);

}
else
alert("Incorrect To Address");



}



</script>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body style="font-family:Tahoma">
   <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        <a href="logout.jsp" style="float:right; color:white; font-size:16px; ">Log out</a>
    </h1>
    



<!--<ul>
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
</ul>-->
<br/>
<br/>
<table>
<tr>
<td>To:</td>
<td><input type="text" id="toad" style="width:373pt"/></td>
</tr>
<tr>
<td>Subject:</td>
<td><input type="text" id="sub" style="width: 373pt"/></td>
</tr>
<tr>
<td>Message</td>
<td valign="top"><textarea cols="80" rows="20" id="msg"></textarea></td>
</tr>
<tr>
<td colspan="2" align="center"><input type="button" value="Send Message" onclick="send()"/></td>
</tr>
</table>
</body>
</html>
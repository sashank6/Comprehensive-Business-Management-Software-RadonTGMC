<%@page import="sashank.Sashank"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.io.*" %>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Cash Transaction</title>
<script type="text/javascript">
<%
Sashank obj=new Sashank();
Connection con=obj.getCon();PreparedStatement pstmt=con.prepareStatement("select amt from rad_cash_table where id=1");
ResultSet rs=pstmt.executeQuery();
double fgh=-1;
while(rs.next())
fgh=rs.getDouble(1);
%>
var x=<%=fgh%>;

function getset()
{
var a=document.getElementById("cool").selectedIndex;
if(a==1)
{

document.getElementById("justice").innerHTML="<p>Amount Available is: "+x;
}
else
document.getElementById("justice").innerHTML="";
}

function validate()
{
if(document.getElementById("cool").selectedIndex==0)
{
var amt=document.getElementById("amt").value;
var amtp=new RegExp("[^A-z]$");
var amtv=false;
var aamt=parseFloat(amt);
if(amtp.test(amt)&&amt.length>0&&aamt>0)
amtv=true;
var desc=document.getElementById("desc").value;
var descv=false;
if(desc.length>0)
descv=true;
if(amtv&&descv)
return true;
return false;
}
else
{
if(document.getElementById("cool").selectedIndex==1)
{
var amt=document.getElementById("amt").value;
var amtp=new RegExp("[^A-z]$");
var amtv=false;
var aamt=parseFloat(amt);
if(amtp.test(amt)&&amt.length>0&&aamt>0)
amtv=true;
var desc=document.getElementById("desc").value;
var descv=false;
if(desc.length>0)
descv=true;
if(amtv&&descv&&amt<=x)
return true;
else
{
alert("Insufficient Balance");
return false;
}
}
}
}


</script>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body style="font-family:Tahoma">
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
<div id="justice">
</div>
<form onsubmit="return validate()" method="POST" action="addCashTransaction">
<table border="1">
<tr>
<td>Type of Transaction:</td>
<td><select id="cool" name="cool" onchange="javascript:getset()"><option>CR</option><option>DR</option></select></td>
</tr>
<tr>
<td>Amount:<sup>*</sup></td>
<td><input type="text" id="amt" name="amt"/></td>
</tr>
<tr>
<td>Description:<sup>*</sup></td>
<td><input type="text" id="desc" name="desc"/></td>
</tr>
<tr>
<td colspan="2" align="center"><input type="submit" value="Submit"/></td>
</tr>
</table>
</form>

</body>
</html>
<%@page import="sashank.Sashank"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import="java.io.IOException" %>
     <%@ page import="java.sql.*" %>
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
<title>View Account Statement</title>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
<%

            Sashank obj=new Sashank();
            Connection con=obj.getCon();
PreparedStatement pstmt=con.prepareStatement("select count(*) from rad_account_table");
ResultSet rs=pstmt.executeQuery();
long a=-1;
while(rs.next())
a=rs.getLong(1);
long tpno=(a/20)+1;
%>
var tpageno=<%=tpno%>;
var pageno=1;
function displayData(a)
{
var f=$.ajax({
type:"POST",
url:"displayAccountData",
async:false,
data:{pageno:a},
dataType:"html"



}).responseText;
document.getElementById("one").innerHTML=f;

}
function nextPage()
{
if(pageno==tpageno)
alert("No Data in next Page");
else
{
pageno++;
displayData(pageno);
}
}
function prevPage()
{
if(pageno>1)
{
pageno--;
displayData(pageno);
}
else
alert("You are viewing first page");
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
<body onload="displayData(1)">
<div id="one">

</div>
<input type="button" value="Previous Page" onclick="prevPage()"/>&nbsp;
<input type="button" value="Next Page" onclick="nextPage()"/>&nbsp;
</body>
</html>
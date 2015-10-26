<%@page import="sashank.Sashank"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="java.sql.*" %>
    <%
    HttpSession ses=request.getSession();
    long user=-1;
    try
    {
    user=Long.parseLong((String)ses.getAttribute("userid"));
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
<title>View Retailer Details</title>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
    function cool(a)
    {
        window.location="edit_retailer.jsp?retailerid="+a;
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
<%
long retailer=Long.parseLong(request.getParameter("retailer"));
if(user==retailer)
{

            Sashank obj=new Sashank();
            Connection con=obj.getCon();
PreparedStatement pstmt1=con.prepareStatement("select accountstat from rad_login where userid=?");
pstmt1.setLong(1, retailer);
ResultSet rs1=pstmt1.executeQuery();
int statuss=-1;
while(rs1.next())
statuss=rs1.getInt(1);
String status1=null;
switch(statuss)
{
case 0:
status1="Permanently Diasabled";
break;
case 1:
status1="Active";
break;
case 2:
status1="Freezed";
break;
case 3:
status1="Waiting for Approval";
break;
}

PreparedStatement pstmt=con.prepareStatement("select *from rad_retailer where userid=?");
pstmt.setLong(1, retailer);
ResultSet rs=pstmt.executeQuery();
out.println("<table border=\"1\">");
while(rs.next())
{
out.println("<tr>");
out.println("<td>Userid</td>");
out.println("<td>"+rs.getLong(1)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Company Name</td>");
out.println("<td>"+rs.getString(2)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Contact No</td>");
out.println("<td>"+rs.getLong(3)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>City</td>");
out.println("<td>"+rs.getString(4)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Street Address</td>");
out.println("<td>"+rs.getString(5)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Last Purchase date</td>");
out.println("<td>"+rs.getDate(6)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>TIN/TAN</td>");
out.println("<td>"+rs.getLong(7)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Email id</td>");
out.println("<td>"+rs.getString(8)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Assigned Employee id/Name</td>");
out.println("<td>"+rs.getLong(9)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Total Business</td>");
out.println("<td></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Account Status</td>");
out.println("<td>"+status1+"</td>");
out.println("</tr>");

}
out.println("</table>");

}
else
if(user==666)
{
DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
Connection con=DriverManager.getConnection("jdbc:db2://127.0.0.1:50000/radone","Aneesh","blah");
String status1=null;
int statuss=-1;
try
{
PreparedStatement pstmt1=con.prepareStatement("select accountstat from rad_login where userid=?");
pstmt1.setLong(1, retailer);
ResultSet rs1=pstmt1.executeQuery();
statuss=-1;
while(rs1.next())
{
statuss=rs1.getInt(1);
}
status1=null;
switch(statuss)
{
case 0:
status1="Permanently Diasabled";
break;
case 1:
status1="Active";
break;
case 2:
status1="Freezed";
break;
case 3:
status1="Waiting for Approval";
break;
}
pstmt1.close();
rs1.close();
}
catch(Exception e)
{
out.println("Exception Caught");
}

PreparedStatement pstmt=con.prepareStatement("select *from rad_retailer where userid=?");
pstmt.setLong(1, retailer);
ResultSet rs=pstmt.executeQuery();
out.println("<table border=\"1\">");
while(rs.next())
{
out.println("<tr>");
out.println("<td>Userid</td>");
out.println("<td>"+rs.getLong(1)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Company Name</td>");
out.println("<td>"+rs.getString(2)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Contact No</td>");
out.println("<td>"+rs.getLong(3)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>City</td>");
out.println("<td>"+rs.getString(4)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Street Address</td>");
out.println("<td>"+rs.getString(5)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Last Purchase date</td>");
out.println("<td>"+rs.getDate(6)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>TIN/TAN</td>");
out.println("<td>"+rs.getLong(7)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Email id</td>");
out.println("<td>"+rs.getString(8)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Assigned Employee id/Name</td>");
out.println("<td>"+rs.getLong(9)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Total Business</td>");
out.println("<td></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Account Status</td>");
out.println("<td>"+status1+"</td>");
out.println("</tr>");
}
out.println("</table>");
if(statuss==3)
{
out.println("<input type=\"button\" value=\"Approve\" onclick=\"hulk_app1(1)\"/>");
out.println("<input type=\"button\" value=\"Reject\" onclick=\"hulk_app(2)\"/>");
out.println("<input type=\"button\" value=\"Permanently Disable\" onclick=\"hulk_app(0)\"/>");
}
else
if(statuss==1)
{
out.println("<input type=\"button\" value=\"Freeze\" onclick=\"hulk_app(2)\"/>");
out.println("<input type=\"button\" value=\"Permanently Disable\" onclick=\"hulk_app(0)\"/>");
}
else
if(statuss==2)
{
out.println("<input type=\"button\" value=\"De Freeze\" onclick=\"hulk_app(1)\"/>");

out.println("<input type=\"button\" value=\"Permanently Disable\" onclick=\"hulk_app(0)\"/>");
}
out.println("<input type=\"button\" value=\"Edit\" onclick=\"cool("+retailer+")\"/>");
out.println("<script type=\"text/javascript\">");
out.println("function hulk_app(a){");
out.println("var p=$.ajax({type:\"POST\",url:\"update_retailer_status\",async:false,data:{retailer:"+retailer+",status:a},dataType:\"html\"}).responseText;alert(p);}");
out.println("</script>");
out.println("<script type=\"text/javascript\">");
out.println("function hulk_app1(a){");
out.println("var p=$.ajax({type:\"POST\",url:\"add_retailer_admin\",async:false,data:{retailer:"+retailer+",status:a},dataType:\"html\"}).responseText;alert(p);}");
out.println("</script>");





}
else
out.println("Sorry You Do not Access to this Page");
%>
</body>
</html>
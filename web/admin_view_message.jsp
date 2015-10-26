<%@page import="sashank.Sashank"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%
    HttpSession ses=request.getSession();
    String userid="";
    try
    {
    userid=(String)ses.getAttribute("userid"); 
    if(userid==null)
    response.sendRedirect("home.jsp");
    else
    if(userid.equals(""))
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
<title>View Messages</title>
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
<%
 try
 {

           Sashank obj=new Sashank();
           Connection con=obj.getCon();
String tablename="m_"+userid+"_messages";
PreparedStatement pstmt=con.prepareStatement("select mid,address,subject,otime from "+tablename+" where type=1 order by otime desc");
ResultSet rs=pstmt.executeQuery();
out.println("<table border=\"1\">");
out.println("<th>From</th><th>Subject</th><th>Time</th>");
long x;
while(rs.next())
{
out.println("<tr>");
x=rs.getLong(1);
out.println("<td>"+rs.getString(2)+"</td>");
out.println("<td><a href=\"descmessage.jsp?mid="+x+"\">"+rs.getString(3)+"</a></td>");
out.println("<td>"+rs.getTimestamp(4)+"</td>");
out.println("</tr>");
}
out.println("</table>");
		
}
catch(Exception e)
{
out.println("Oops, Something went wrong Please Login again");
}


 %>
 
</body>
</html>
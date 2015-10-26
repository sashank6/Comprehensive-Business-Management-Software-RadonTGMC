<%-- 
    Document   : vendor_view_payments
    Created on : 22 Mar, 2013, 2:00:38 PM
    Author     : Aneesh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="sashank.Sashank"%>
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
        <title>View Payments</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function func(oid)
            {
                var p=$.ajax({
                    type:"POST",
                    url:"vendor_pay_confirm",
                    dataType:"html",
                    async:false,
                    data:{poid:oid}
                    
                    
                    
                }).responseText;
                if(p==1)
                    alert("Transaction Successful");
                else
                    alert("Transaction Failed");
                document.location.reload(true);
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
        <table border="1">
            <th>Payment ID</th><th>Amount</th><th>Status</th>
            <%
                Sashank obj=new Sashank();
                Connection con=obj.getCon();
                PreparedStatement pstmt=con.prepareStatement("select *from v_"+userid+"_payments");
                ResultSet rs=pstmt.executeQuery();
                while(rs.next())
                {
                    out.println("<tr>");
                    String poid=rs.getString(1);
                    out.println("<td>"+poid+"</td>");
                    out.println("<td>"+rs.getDouble(2)+"</td>");
                    int status=rs.getInt(3);
                    if(status==0)
                        out.println("<td><input type=\"button\" value=\"Confirm Payment\" onclick=\"func(\'"+poid+"\')\"/></td>");
                    else
                        if(status==1)
                            out.println("<td>Payment Confirmed</td>");
                    else
                            if(status==2)
                                out.println("<td>Waiting for Admin Approval</td>");
                    else
                                if(status==4)
                                    out.println("<td>Payment Rejected</td>");
                out.println("</tr>");
                }
                
            %>
        </table>
    </body>
</html>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
        
        <title>View Purchase Orders</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
        
            function fun(order,action,pymt,tv,qty,modelno,make)
            {
                var p=$.ajax({
                    type:"POST",
                    url:"vendor_order_status",
                    dataType:"html",
                    async:false,
                    data:{poid:order,action:action,pymt:pymt,tv:tv,model:modelno,make:make,qty:qty}
                    
                    
                    
                }).responseText;
                alert(p);
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
        </ul><br>
        <br/>
        <% 
    Sashank obj=new Sashank();
    Connection con=obj.getCon();
    PreparedStatement pstmt=con.prepareStatement("select poid,qty,modelno,make,price,payment,status from rad_po_ven where status<7 and vid=?");
    pstmt.setLong(1,userid);
    ResultSet rs=pstmt.executeQuery();
    out.println("<table border=\"1\"><th>PO ID</th><th>Quantity</th><th>Model No</th><th>Make</th><th>Price</th><th>Status</th><th>Payment Type</th><th>Total Order Value</th><th>Action to be Performed</th>");
    while(rs.next())
    {
        out.println("<tr>");
        String poid=rs.getString(1);
        out.println("<td>"+poid+"</td>");
        int qty1=rs.getInt(2);
        out.println("<td>"+qty1+"</td>");
        String modeln=rs.getString(3);
        out.println("<td>"+modeln+"</td>");
        String maken=rs.getString(4);
        out.println("<td>"+maken+"</td>");
        double price1=rs.getDouble(5);
        out.println("<td>"+price1+"</td>");
        int pymt=rs.getInt(6);
        if(pymt==0)
            out.println("<td>Immediate</td>");
        else
            out.println("<td>Deferred</td>");
        int status=rs.getInt(7);
        String buttonup="";
        if(status==0)
        {
            out.println("<td>Un-Noticed</td>");
            buttonup="<input type=\"button\" value=\"Accept\" onclick=\"fun(\'"+poid+"\',1,"+pymt+","+price1*qty1+","+qty1+",\'"+modeln+"\',\'"+maken+"\')\"/><input type=\"button\" value=\"Reject\" onclick=\"fun(\'"+poid+"\',1,"+pymt+","+price1*qty1+","+qty1+",\'"+modeln+"\',\'"+maken+"\')\"/>";
            
        }
        else
            if(status==1)
            {
            out.println("<td>Read/Not Responded</td>");
             buttonup="<input type=\"button\" value=\"Accept\" onclick=\"fun(\'"+poid+"\',1,"+pymt+","+price1*qty1+","+qty1+",\'"+modeln+"\',\'"+maken+"\')\"/><input type=\"button\" value=\"Reject\" onclick=\"fun(\'"+poid+"\',1,"+pymt+","+price1*qty1+","+qty1+",\'"+modeln+"\',\'"+maken+"\')\"/>";
            }
        else
                if(status==2)
                {
                    out.println("<td>Accepted</td>");
                    buttonup="<input type=\"button\" value=\"Material Dispatched\" onclick=\"fun(\'"+poid+"\',3,"+pymt+","+price1*qty1+","+qty1+",\'"+modeln+"\',\'"+maken+"\')\"/>";
                }
        else
                    if(status==3)
                        out.println("<td>Rejected</td>");
        else
                        if(status==4)
                            out.println("<td>Material Dispatched. Shipment not yet arrived at Warehouse</td>");
        else
                            if(status==5)
                                out.println("<td>Material Received. Order Completed</td>");
        else
                                if(status==6)
                                    out.println("<td>Order Cancelled</td>");
        
        out.println("<td>"+price1*qty1+"</td>");
        out.println("<td>"+buttonup+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");
    %>
    <%
    pstmt=con.prepareStatement("update rad_po_ven set status=1 where status=0 and vid=?");
    pstmt.setLong(1, userid);
    pstmt.execute();
    
    %>
    </body>
</html>

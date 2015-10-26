<%-- 
    Document   : lm_view_purchaseorders
    Created on : 22 Mar, 2013, 3:06:21 PM
    Author     : Aneesh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="sashank.Sashank"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%
    HttpSession ses=request.getSession();
    long userid=-1;
    try
    {
    userid=Long.parseLong((String)ses.getAttribute("userid"));
    if(userid!=111)
        throw new IOException("Invalid User");
        
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
        <title>JSP Page</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function fun(a)
            {
                var p=$.ajax({
type:"POST",
url:"lm_confirm_material_arrival",
async:false,
data:{poid:a},
dataType:"html"
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
            <li> <a href="admin_send_message.jsp">Send Message</a></li>
            <li><a href="view_messages.jsp">View Messages</a></li>
            <li><a href="lm_view_purchaseorders.jsp">View Purchase Orders</a></li>
        </ul>
        <br/><br/>
        <table border="1">
            <%
                Sashank obj=new Sashank();
                Connection con=obj.getCon();
                PreparedStatement pstmt=con.prepareStatement("select *from rad_po_ven");
                ResultSet rs=pstmt.executeQuery();
                int x;
                while(rs.next())
                {
                   out.println("<tr>");
              out.println("<td>");String gui;
              gui=rs.getString(1);
              out.println(gui);
              out.println("</td>");
              out.println("<td>");
             long useridd=rs.getLong(2);
             PreparedStatement pstmt2=con.prepareStatement("select cname from rad_vendor where userid=?");
             pstmt2.setLong(1, useridd);
             ResultSet rs2=pstmt2.executeQuery();
             String companyname="";
             while(rs2.next())
                 companyname=rs2.getString(1);
             out.println(companyname);
              out.println("</td>");
              out.println("<td>");
              int qty=rs.getInt(3);
              out.println(qty);
              out.println("</td>");
              out.println("<td>");
              out.println(rs.getString(4));
              out.println("</td>");
              out.println("<td>");
              out.println(rs.getString(5));
              out.println("</td>");
              out.println("<td>");
              //out.println(rs.getDouble(6)*qty);
              double pricree=rs.getDouble(6);
              out.println(pricree*qty);
              out.println("</td>");
              out.println("<td>");
               x=rs.getInt(7);
              if(x==0)
                  out.println("Un-Noticed");
              else
                  if(x==1)
                      out.println("Read/Not Responded");
              else
                      if(x==2)
                          out.println("Accepted");
              else
                          if(x==3)
                              out.println("Rejected");
              else
                              if(x==4)
                                  out.println("Material Dispatched. Waiting for Shipment Arrival");
              else
                                  if(x==5)
                                      out.println("Order Completed");
                                  else if(x==6||x==7)
                                      out.println("Cancelled by Admin");
              
              out.println("</td>");
              out.println("<td>");
              out.println(rs.getTimestamp(8));
              out.println("</td>");
              int yy=rs.getInt(9);
              out.println("<td>");
              if(yy==0)
                  out.println("Immediate");
              else
                  out.println("Deferred");
              out.println("</td>");
              out.println("<td>");
              if(x==4)
                  out.println("<input type=\"button\" value=\"Material Received\" onclick=\"fun(\'"+gui+"\')\"/>");
              
              out.println("</td>");
              out.println("</tr>");
                }
                
                
                
            %>
        </table>
    </body>
</html>

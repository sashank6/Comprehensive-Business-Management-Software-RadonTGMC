<%-- 
    Document   : descmessage
    Created on : 22 Mar, 2013, 1:01:45 PM
    Author     : Aneesh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="sashank.Sashank"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="style.css"/>
    </head>
    <body>
         <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        <a href="logout.jsp" style="float:right; color:white; font-size:16px; ">Log out</a>
    </h1>
        <table border="1">
        <%
            String id=request.getParameter("mid");
            
            Sashank obj=new Sashank();
            try
            {
               Connection con=obj.getCon();
               PreparedStatement pstmt=con.prepareStatement("select address,subject,message,otime,type from m_"+userid+"_messages where mid=?");
               pstmt.setLong(1, Long.parseLong(id));
               ResultSet rs=pstmt.executeQuery();
               while(rs.next())
               {
                  out.println("<tr>");
                  out.println("<td>From</td>");
                  out.println("<td>"+rs.getString(1)+"</td>");
                  out.println("</tr>");
                  out.println("<tr>");
                  out.println("<td>Subject</td>");
                  out.println("<td>"+rs.getString(2)+"</td>");
                  out.println("</tr>");
                  out.println("<tr>");
                  out.println("<td colspan=\"2\">"+rs.getString(3)+"</td>");
                  out.println("</tr>");
                  out.println("<tr>");
                  out.println("<td>"+rs.getTimestamp(4)+"</td>");
                  out.println("</tr>");
                  out.println("<tr>");
                  out.println("<td>Type</td>");
                  int g=rs.getInt(5);
                  if(g==1)
                      out.println("<td>Received</td>");
                  else
                      if(g==2)
                          out.println("<td>Sent</td>");
                  out.println("</tr>");
                  
                  
               }
            }
            catch(Exception e)
            {
                
            }
        %>
        </table>
    </body>
</html>

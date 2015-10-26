<%-- 
    Document   : logout
    Created on : 21 Mar, 2013, 11:51:59 PM
    Author     : Aneesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
   HttpSession ses=request.getSession();
   ses.invalidate();
   
    response.sendRedirect("home.jsp");
    
    
    %>
    </body>
</html>

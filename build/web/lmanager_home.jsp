<%-- 
    Document   : lmanager_home.jsp
    Created on : 22 Mar, 2013, 2:29:54 PM
    Author     : Aneesh
--%>

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
        <title>JSP Page</title>
        <script type="text/javascript">
var dfr="<%=userid%>";
if(dfr==666||dfr==111)
{}
else
window.location="home.jsp";
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
        <h2>Welcome Logistics Manager</h2>
        <hr/>
        
        
    </body>
</html>

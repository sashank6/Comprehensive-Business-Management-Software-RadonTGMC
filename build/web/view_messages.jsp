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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body>
     <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        <a href="logout.jsp" style="float:right; color:white; font-size:16px; ">Log out</a>
    </h1>
<%
 try
 {
DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
Connection con=DriverManager.getConnection("jdbc:db2://127.0.0.1:50000/radone","Aneesh","blah");
String tablename="m_"+userid+"_messages";
PreparedStatement pstmt=con.prepareStatement("select mid,address,subject,otime from "+tablename+" where type=1");
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
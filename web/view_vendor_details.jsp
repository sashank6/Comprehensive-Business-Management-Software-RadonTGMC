<%@page import="sashank.Sashank"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%
    HttpSession ses=request.getSession();
    long userid=-1;
    try
    {
    String temp=(String)ses.getAttribute("userid");
    userid=Long.parseLong(temp);     
    
    }
    catch(Exception e)
    {
    response.sendRedirect("home.jsp");
    }
    String vid=null;
    try
    {
    vid=request.getParameter("vid");
    }
    catch(Exception e)
    {
    out.println("Sorry, something went wrong");
    }
    
    
    
    
    
    
    
     %>
    
    
    <%
    
    
    
    
    
    
    
     %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Vendor Profile</title>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
 function fun(a)
    {
        window.location="edit_vendor.jsp?vendorid="+a;
    }</script>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body>
     <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        <a href="logout.jsp" style="float:right; color:white; font-size:16px; ">Log out</a>
    </h1>
    




<%
if(!(userid==666)&&!(userid==Long.parseLong(vid)))
    out.println("Access denied BITCH!");
    else
    {
try
{

            Sashank obj=new Sashank();
            Connection con=obj.getCon();
PreparedStatement pstmt=con.prepareStatement("select a.userid,cname,ctno,city,staddr,regdd,tinno,a.accountstat from rad_login a,rad_vendor b where a.userid=? and b.userid=?");
pstmt.setLong(1, Long.parseLong(vid));
pstmt.setLong(2, Long.parseLong(vid));
ResultSet rs=pstmt.executeQuery();
out.println("<table border=\"1\">");
int ads=-1;
while(rs.next())
{
out.println("<tr>");
out.println("<td>User id:</td>");
out.println("<td>"+rs.getLong(1)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Company Name:</td>");
out.println("<td>"+rs.getString(2)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Contact No:</td>");
out.println("<td>"+rs.getLong(3)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>City:</td>");
out.println("<td>"+rs.getString(4)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Street Address:</td>");
out.println("<td>"+rs.getString(5)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Registration Date</td>");
out.println("<td>"+rs.getDate(6)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>TIN/TAN</td>");
out.println("<td>"+rs.getLong(7)+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Account Status:</td>");
ads=rs.getInt(8);
if(ads==0)
out.println("<td>Permanently Disabled</td>");
else
if(ads==1)
out.println("<td>Active</td>");
else
if(ads==2)
out.println("<td>Freezed</td>");
else
if(ads==3)
out.println("<td>Not Approved</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>Value of Business Till Date:</td>");
out.println("<td></td>");
out.println("</tr>");

}

out.println("</table>");
if(userid==666)
{
out.println("<script type=\"text/javascript\">");
out.println("var fgh="+vid);
out.println("function update(a){");
out.println("var g=$.ajax({type:\"POST\",url:\"addVendorByAdmin\",async:false,data:{status:a,userid:fgh},dataType:\"html\"}).responseText;alert(g);}");
out.println("</script>");
if(ads==0)
{}
else
if(ads==1)
{
out.println("<input type=\"button\" value=\"Freeze\" onclick=\"update(2)\"/>&nbsp;");
out.println("<input type=\"button\" value=\"Permanently Disable\" onclick=\"update(0)\"/>&nbsp;");
}
else
if(ads==2)
{
out.println("<input type=\"button\" value=\"De Freeze\" onclick=\"update(1)\"/>&nbsp;");
out.println("<input type=\"button\" value=\"Permanently Disable\" onclick=\"update(0)\"/>&nbsp;");
}
else
if(ads==3)
{
out.println("<input type=\"button\" value=\"Approve\" onclick=\"update(4)\"/>&nbsp;");
out.println("<input type=\"button\" value=\"Reject\" onclick=\"update(5)\"/>&nbsp;");
out.println("<input type=\"button\" value=\"Permanently Disable\" onclick=\"update(0)\"/>&nbsp;");
}
out.println("<input type=\"button\" value=\"Edit\" onclick=\"fun("+vid+")\"/>");


}
}
catch(Exception e)
{
out.println("Something went wrong please try again or if you receive same error please contact admin.");
}

}

 %>
</body>
</html>
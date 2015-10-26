<%@page import="sashank.Sashank"%>
<%@page import="com.ibm.db2.jcc.DB2Driver"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%
    HttpSession ses=request.getSession(false);
    try
    {
    String userid=(String)ses.getAttribute("userid");
    long h=Long.parseLong(userid);
    if(userid.equals("666"))
    response.sendRedirect("admin_home.jsp");
    else
    if(h>=300000&& h<400000)
    response.sendRedirect("retailer_home.jsp");
    else
    if(h>=200000&&h<300000)
    response.sendRedirect("vendor_home.jsp");
    else
        if(h==111)
            response.sendRedirect("lmanager_home.jsp");
    else
    {
  
            Sashank obj=new Sashank();
            Connection con=obj.getCon();
  PreparedStatement pstmt=con.prepareStatement("select userclass from rad_login where userid=?");
  pstmt.setLong(1, h);
  ResultSet rs=pstmt.executeQuery();
  int a=-1;
  while(rs.next())
  {
  
  a=rs.getInt(1);
  
  }
  if(a==1)
  {
  
  }
    
    }
    
    }
    catch(Exception e)
    {
    }
    
    
     %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css"
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Project Radon</title>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
function loginvalid()
{
var userid=document.getElementById("lid").value;
var pwd=document.getElementById("pwd").value;
if(userid==""||pwd=="")
document.getElementById("result").innerHTML="<p>Blank Spaces Not Allowed</p>";
else
{
var p=$.ajax({
type:"POST",
url:"loginvalidate",
async:false,
data:{userid:userid,pwd:pwd},
dataType:"html"
}).responseText;
var fg=parseInt(userid);
if(p==3)
{
if(fg==666)
window.location="admin_home.jsp";
else
if(fg>=300000 && fg<400000)
window.location="retailer_home.jsp";
else
if(fg>=200000 && fg < 300000)
window.location="vendor_home.jsp";
else
    if(fg==111)
        window.location="lmanager_home.jsp";
}
else
if(p==0)
{
document.getElementById("result").innerHTML="<p>Waiting for Administrator Approval</p>";
}
else
if(p==1)
{
document.getElementById("result").innerHTML="<p>Account Locked Please Contact HR/Administrator</p>";
}
else
if(p==2)
{

document.getElementById("result").innerHTML="<p>Account Frozen Cannot Make any transactions.</p>";
}
else
if(p==4)
{
document.getElementById("result").innerHTML="<p>Incorrect Password</p>";
}
else
if(p==6)
{
document.getElementById("result").innerHTML="<p>User Doesn't Exist</p>";
}
else
if(p==5)
{
document.getElementById("result").innerHTML="<p>Exceeded Number of Password Trials. Account Locked</p>";
}
}
}
function checc(e)
{
    if(e.keyCode==13)
        loginvalid();
}
</script>


</head>
<body style="font-family: Tahoma">
    <h1>Project Radon</h1>
    <div style="margin-left:550px; margin-top: 60px;">
<table align="center">
<tr>
<td>Login</td>
<td><input type="text" id="lid"/></td>
</tr>
<tr>
<td>Password</td>
<td><input type="password" id="pwd" onkeypress="checc(event)"/></td>
</tr>
<tr>
<td colspan="2" align="center"><input type="button" value="Login" onclick="loginvalid()"/></td>
</tr>
</table>
        </div>
    <div id="result" align="center" style="margin-top: 20px">


<p><a href="retailer_registration.jsp">Retailer Registration</a>&nbsp;
<a href="vendor_registration.jsp">Vendor Registration</a></p>

</div>
<div>
<%
/*
int a=0;
ServletContext ctx=getServletContext();
try
{
out.println(ctx.getAttribute("users"));
}
catch(Exception e)
{
}
*/
 %>
</div>
</body>
</html>
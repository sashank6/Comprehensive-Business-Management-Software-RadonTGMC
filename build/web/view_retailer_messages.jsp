<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    HttpSession ses=request.getSession();
    String fruit=null;
    long falto=-1;
    try
    {
    fruit=(String)ses.getAttribute("userid");
    falto=Long.parseLong(fruit);
    if(falto>=300000&&falto<400000)
    {
    }
    else
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
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
var userid=<%=falto%>;
var pageno=1;

function nextpage()
{
pageno++;
getData(1,pageno);
}
function prevpage()
{
if(pageno>1)
{
pageno--;
getData(1,pageno);
}
else
alert("Sorry No Previous Pages");

}
function getData(type,pageno)
{
var t=$.ajax({
type:"POST",
url:"retailer_view_messages",
async:false,
data:{userid:userid,type:type,pageno:pageno},
dataType:"html"
}).responseText;
document.getElementById("one").innerHTML=t;

}
</script>
<link rel="stylesheet" type="text/css" href="style.css"/>

</head>
<body onload="getData(1,1)">
     <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        <a href="logout.jsp" style="float:right; color:white; font-size:16px; ">Log out</a>
    </h1>
    <ul>
    <li><a href="admin_send_message.jsp">Send Message</a></li>
    <li><a href="view_retailer_messages.jsp">View Messages</a></li>
    <li><a href="view_products.jsp">View Products</a></li>
    <li><a href="retailer_view_orders.jsp">View Orders</a></li>
    </ul>
    <br/><br/>
<div id="one">

</div>
<br/>
<input type="button" value="Previous Page" onclick="prevpage()"/>
<input type="button" value="Next Page" onclick="nextpage()"/>

</body>
</html>
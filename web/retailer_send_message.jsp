<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Send Message</title>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
function send()
{
var to=document.getElementById("toad").value;
var sub=document.getElementById("sub").value;
var msg=document.getElementById("msg").value;

var fdg=new RegExp("[0-9]");
var tov=true;
if(tov)
{
var t=$.ajax({
type:"POST",
url:"sendMessage",
async:false,
data:{to:to,sub:sub,msg:msg},
dataType:"html"

}).responseText;
alert(t);
document.location.reload(true);

}
else
alert("Incorrect To Address");



}



</script>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body style="font-family:Tahoma">
    <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        <a href="logout.jsp" style="float:right; color:white; font-size:16px; ">Log out</a>
    </h1>
<table>
<tr>
<td>To:</td>
<td><input type="text" id="toad" style="width:373pt"/></td>
</tr>
<tr>
<td>Subject:</td>
<td><input type="text" id="sub" style="width: 373pt"/></td>
</tr>
<tr>
<td>Message</td>
<td valign="top"><textarea cols="80" rows="20" id="msg"></textarea></td>
</tr>
<tr>
<td colspan="2" align="center"><input type="button" value="Send Message" onclick="send()"/></td>
</tr>
</table>
</body>
</html>
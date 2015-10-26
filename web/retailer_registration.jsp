<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    HttpSession ses=request.getSession(false);
    try
    {
    String userid=(String)ses.getAttribute("userid");
    if(userid!=null)
    {    
    response.sendRedirect("index.jsp");
    }
    }
    catch(Exception e)
    {
    }
    
    
     %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Retailer Registration</title>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
var f=false;
var tinv=false;var p;var tinv=false;
function test()
{
var d_tin=document.getElementById("tin").value;
if(!f)
{
f=true;
}
else
if(f)
{
document.getElementById("vtin").innerHTML="Validating";
var fg=new RegExp("[0-9]");
if(fg.test(d_tin))
{
var xmlhttp;
if(window.XMLHttpRequest)
xmlhttp=new XMLHttpRequest();
else
if(window.ActiveXObject())
xmlhttp=new ActiveXObject();
				
xmlhttp.open('POST','retailervalidate',true);
xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
xmlhttp.send("tin="+d_tin);
var av;
xmlhttp.onreadystatechange=function()
{
if(xmlhttp.readyState==4)
{
av=xmlhttp.responseText;

                     
						if(av==0)
                                                    {
						window.document.getElementById("vtin").innerHTML="TIN/PAN Already Registered";
                                                tinv=false;
                                                    }
						else
                                                    {
						window.document.getElementById("vtin").innerHTML="TIN/PAN Available for Registration";
                                               tinv=true;
                                                    }
						
					}
					
				}
				}
				else
				document.getElementById("vtin").innerHTML="Invalid TIN Format";
				
				
				
			
			
f=false;
}
}
function robuts()
{
var cna=document.getElementById("cname").value;
var ctno=document.getElementById("ctno").value;
var city=document.getElementById("city").value;
var tii=document.getElementById("tin").value;
var addr=document.getElementById("addr").value;
var email=document.getElementById("email").value;
var pwd=document.getElementById("pwd").value;
var cnav=true,ctnov=true,cityv=true,addrv=true,pwd=true;
var fg=new RegExp("[0-9]");
var acd=new RegExp("^([a-zA-Z0-9]+)([\.,\-]{0,1}[\_]{0,1})([a-zA-Z0-9])*@([a-zA-Z0-9_-]+)([\\.]+)([a-zA-Z0-9\\._-]+)");
var emailv=true;

if(cna=="")
cnav=false;
if(ctno=="")
ctnov=false;
if(city=="")
cityv=false;
if(addr=="")
addrv=false;
if(email=="")
emailv=false;
if(!fg.test(ctno))
ctno=false;
if(!acd.test(email))
emailv=false;
if(pwd=="")
pwdv=false;

if(cnav&&ctnov&&tinv&&addrv&&cityv&&emailv&&pwdv)
return true;
else
{
alert("Invalid Details");
return false;
}

}
</script>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body style="font-family: Tahoma">
     <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        
    </h1>
<h2>Retailer Registration</h2>
<form method="post" action="RegisterRetailer" onsubmit="return robuts()">
<table>
<tr>
<td>TIN No:/PAN No:</td>
<td><input type="text" id="tin" onfocus="test()" name="itin"></td>
<td id="vtin"></td>
</tr>
<tr>
<td>Company Name:</td>
<td colspan="2"><input type="text" name="cname" id="cname" onfocus="test()"/></td>
</tr>
<tr>
<td>Contact No:</td>
<td colspan="2"><input type="text" name="ctno" id="ctno"/></td></tr>
<tr>
<td>City:</td>
<td colspan="2"><input type="text" name="city" id="city"/></td>
</tr>
<tr>
<td>Address</td>
<td colspan="2"><textarea rows="5" cols="20" name="addr" id="addr"></textarea>
</td>
</tr>
<tr>
<td>Email Id:</td>
<td colspan="2"><input type="text" name="email" id="email"/></td>
</tr>
<tr>
<td>Password:</td>
<td colspan="2"><input type="password" name="pwd" id="pwd"/></td>
</tr>
<tr>
<td align="center" colspan="3"><input type="submit" value="submit" /></td></tr>
</table>
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Vendor Registration</title>
<script type="text/javascript">
tinv=false; var fgh=false;
function validatetin(kill)
{
if(kill==1)
fgh=true;
if(!fgh)
fgh=true;
else
{

var tin=document.getElementById("tin").value;
var tinp=new RegExp("([0-9]+)$");
if(!tinp.test(tin))
document.getElementById("vtin").innerHTML="Invalid TIN/TAN";
else
{
window.document.getElementById("vtin").innerHTML="Validating...";
var xmlhttp;

if(window.XMLHttpRequest)
xmlhttp=new XMLHttpRequest();
else
if(window.ActiveXObject())
xmlhttp=new ActiveXObject();

xmlhttp.open('POST','vendor_validate',true);
xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
xmlhttp.send("tin="+tin);
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
fgh=false;
}
}
function verify_details()
{
var cname=document.getElementById("cname").value;
var cname=/^[A-Za-z0-9\s]{3,}$/; 
var cnamev=false;
if(cnamep.test(cname)&&cname.length>=1)
cnamev=true;

var ctno=document.getElementById("ctno").value;
var ctnop=/^[0-9]{10}$/;
var ctnov=false;
if(ctnop.test(ctno)&&ctno.length==10)
ctnov=true;

var city=document.getElementById("city").value;
var cityp=/^[A-z]$/;
var cityv=false;
if(cityp.test(city)&&city.length>=2)
cityv=true;

var addr=document.getElementById("staddr").value;
var addrv=false;
if(cnamep.test(addr)&&addr.length>=5)
addrv=true;

var pwd=document.getElementById("pwd").value;
var pwdp=/^[A-z0-9]+$/;
var pwdv=false;
if(pwdp.test(pwd))
pwdv=true;
validatetin(1);
if(pwdv&&cityv&&ctnov&&addrv&&cnamev)
return true;
return false;
}
</script>
<link rel="stylesheet" type="text/css" href="style.css"/>
</head>
<body style="font-family:Tahoma">
     <h1>
        <a href="admin_home.jsp" style="color:white">Project Radon</a>
        
    </h1>
<form  onsubmit="return verify_details()" method="POST" action="RegisterVendor">
<table>
<tr>
<td>TIN/TAN:</td>
<td><input type="text" id="tin" name="tin" onfocus="validatetin(0)"/></td>
<td id="vtin"></td>
</tr>
<tr>
<td>Company Name:</td>
<td colspan="2"><input type="text" id="cname" name="cname" onfocus="validatetin(0)"/></td>
</tr>
<tr>
<td>Contact No:</td>
<td colspan="2"><input type="text" id="ctno" name="ctno"/></td>
</tr>
<tr>
<td>City:</td>
<td colspan="2"><input type="text" id="city" name="city"/></td>
</tr>
<tr>
<td>Street Address</td>
<td colspan="2"><textarea rows="5" cols="15" id="staddr" name="staddr"></textarea></td>
</tr>
<tr>
<td>Password:</td>
<td colspan="2"><input type="password" id="pwd" name="pwd"/></td>
</tr>
<tr>
<td colspan="3" align="center"><input type="submit" value="Register"/></td>
</tr>
</table>
</form>
</body>
</html>
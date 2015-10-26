<!DOCTYPE html>
<html>
    <head>
        <title>Project Radon</title>
        <style type="text/css">
            *
            {
                margin: 0px;
               
            }
            body
            {
                 background: -webkit-radial-gradient(circle, #FFB300, #FFC640);
            }
            h1
            {
                background-color: maroon;
                color:whitesmoke;
                padding: 10px;
                
            }
        </style>
    </head>
    <body>
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
<td><input type="password" id="pwd"/></td>
</tr>
<tr>
<td colspan="2" align="center"><input type="button" value="Login" onclick="loginvalid();"/></td>
</tr>
</table>
<div id="result" align="center">

</div>
                <br/>
<div>
<p><a href="retailer_registration.jsp">Retailer Registration</a>&nbsp;
<a href="vendor_registration.jsp">Vendor Registration</a></p>

</div>
            </div>
    </body>
</html>
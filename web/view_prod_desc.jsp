<%-- 
    Document   : view_prod_desc
    Created on : 11 Apr, 2013, 10:11:28 AM
    Author     : Aneesh
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="sashank.Sashank"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    HttpSession ses=request.getSession();
    String userid=null;
    try
    {
    userid=(String)ses.getAttribute("userid");
    long hh=Long.parseLong(userid);
    if(hh>=300000&&hh<400000||hh==666)
    {
    }
    else
    response.sendRedirect("home.jsp");
    }
    catch(Exception e)
    {
    response.sendRedirect("home.jsp");
    }
    
    String pid=request.getParameter("proid");
     %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Product Description</title>
        
        <script type="text/javascript">
            function check()
            {
                var x=document.getElementById("qtyid").innerHTML;
                x=parseInt(x);
                var q=document.getElementById("orderqty").value;
               // alert(x+"  ]"+q);
                var min=document.getElementById("minorder").innerHTML;
                //alert(min);
                min=parseInt(min);
                //alert(min);
                if(q<=x&&q>=min)
                   {
                       window.location="ret_pace_order?pid="+<%=pid%>+"&qty="+q;
                   }
                else
                    alert("There is violation in Order Policy");
                    
            }
            </script>
            <link rel="stylesheet" type="text/css" href="style.css"/>
    </head>
    <body>
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
        <br/>
        <br/>
        <table border="1">
        <%
    
    
            
            Sashank obj=new Sashank();
            Connection con=obj.getCon();
            PreparedStatement pstmt=con.prepareStatement("select *from rad_act_inv where pid=?");
            pstmt.setLong(1, Long.parseLong(pid));
            ResultSet rs=pstmt.executeQuery();
            while(rs.next())
            {
            
        %>
        <tr>
            <td>Make</td>
            <td><%=rs.getString(2)%></td>
        </tr>
        <tr>
            <td>Model No:</td>
            <td><%=rs.getString(3)%></td>
        </tr>
        <tr>
            <td>Quantity Available</td>
            <td id="qtyid"><%=rs.getInt(4)%></td>
        </tr>
        <tr>
            <td>MRP</td>
            <td><%=rs.getDouble(5)%></td>
        </tr>
        <tr>
            <td>Selling Price</td>
            <td><%=rs.getDouble(6)%></td>
        </tr>
        <tr>
            <td>Description</td>
            <td><%=rs.getString(8)%></td>
        </tr>
        <tr>
            <td >Minimum Order Quantity</td>
            <td id="minorder"><%=rs.getInt(10)%></td>
        </tr>
        <tr>
            <td>Shipping Cost</td>
            <td><%=rs.getDouble(11)%></td>
        </tr>
        <tr>
            <td>Shipping Time(in days)</td>
            <td><%=rs.getInt(13)%></td>
        </tr>
        <%
            }
            %>
    </table>
    <br/>
    <br/>
    <table border="1">
        <tr>
            <td>Quantity to be ordered</td>
            <td><input type="text" id="orderqty"/></td>
        </tr>
        <tr> 
            <td colspan="2" align="center">
        <input type="button" onclick="check()" value="Place Order" />
            </td>
    </tr>
    </table>
    </body>
</html>

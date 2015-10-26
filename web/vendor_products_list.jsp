<%-- 
    Document   : vendor_products_list
    Created on : 19 Mar, 2013, 10:50:30 PM
    Author     : Aneesh
--%>


<%@page import="sashank.Sashank"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
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
    
    String cat=request.getParameter("cat");
    
    
     %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Products List</title>
        <script type="text/javascript">
            function getdata()
            {
                
                var index=document.getElementById("selections").selectedIndex;
                window.location="vendor_products_list.jsp?cat="+index;
            }
            function edit(make,model)
            {
                window.location="vendor_product_edit.jsp?make="+make+"&model="+model;
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
    <li>
        <% 
out.println("<a href=\"view_vendor_details.jsp?vid="+userid+"\">View Profile</a>");
%>
    </li>
    <li><a>Messages</a>
        <ul>
            <li><a href="retailer_send_message.jsp">Send Messages</a></li>
            <li><a href="view_messages.jsp">View Messages</a></li>
        </ul>
    </li>
    <li>
        <a>Products</a>
        <ul>
            <li><a href="vendor_addproducts.jsp"> Add Products</a></li>
            <li><a href="vendor_products_list.jsp?cat=0">View Product List</a></li>
        </ul>
    </li>
    <li>
        <a href="vendor_view_po.jsp">View Purchase Orders</a>
    </li>
    <li><a href="vendor_view_payments.jsp">View Payments</a></li>
</ul>
    <br/>
    <br/>
        <select id="selections">
            <option>All</option>
            <option>Available</option>
            <option>Unavailable</option>
        </select> 
        <input type="button" value="Get Data" onclick="getdata()"/>
        <%
         String sql="";
         int cat1=Integer.parseInt(cat);
         if(cat1==0)
             sql="select make,modelno,cprice,mrp,avbl,qty from v_"+String.valueOf(userid)+"_products";
         else
             if(cat1==1)
                sql="select make,modelno,cprice,mrp,avbl,qty from v_"+String.valueOf(userid)+"_products where avbl=1"; 
             else
                 if(cat1==2)
                     sql="select make,modelno,cprice,mrp,avbl,qty from v_"+String.valueOf(userid)+"_products where avbl=0";
         Sashank obj=new Sashank();
         Connection con=obj.getCon();
         PreparedStatement pstmt=con.prepareStatement(sql);
       ResultSet rs=pstmt.executeQuery();
       out.println("<table border=\"1\">");
       out.println("<th>Make</th><th>Model No:</th><th>Price</th><th>MRP</th><th>Availability</th><th>Qty</th>");
       while(rs.next())
       {
           out.println("<tr onclick=\"edit(\'"+rs.getString(1)+"\',\'"+rs.getString(2)+"\')\">");
           out.println("<td>");
           out.println(rs.getString(1));
           out.println("</td>");
            out.println("<td>");
           out.println(rs.getString(2));
           out.println("</td>");
            out.println("<td>");
           out.println(rs.getDouble(3));
           out.println("</td>");
            out.println("<td>");
           out.println(rs.getDouble(4));
           out.println("</td>");
            out.println("<td>");
           int ad=rs.getInt(5);
           if(ad==1)
               out.println("Available");
           else
               out.println("Unavailable");
           out.println("</td>");
            out.println("<td>");
           out.println(rs.getLong(6));
           out.println("</td>");
           out.println("</tr>");
       }
         out.println("</table>");
        %>
            
    </body>
</html>

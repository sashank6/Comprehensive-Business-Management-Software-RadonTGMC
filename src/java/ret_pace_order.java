/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sashank.Sashank;

/**
 *
 * @author Aneesh
 */
public class ret_pace_order extends HttpServlet {
 protected void doGet(HttpServletRequest rq, HttpServletResponse res) throws IOException
{
    PrintWriter pw = null;
    Sashank obj=new Sashank();
     try {
         pw=res.getWriter();
         
         HttpSession ses=rq.getSession();
         long userid=Long.parseLong((String)ses.getAttribute("userid"));
         long pid=Long.parseLong(rq.getParameter("pid"));
         int qty=Integer.parseInt(rq.getParameter("qty"));
         pw.println("<html><head><title>Order Placement for "+userid+"</title></head><body>");
         
         Connection con=obj.getCon();
         PreparedStatement pstmt=con.prepareStatement("select qty,sp,mumin from rad_act_inv where pid=?");
         pstmt.setLong(1, pid);
         ResultSet rs=pstmt.executeQuery();
         double sp = 0;
         int avbqty = 0;
         int delay=0;
         while(rs.next())
         {
             avbqty=rs.getInt(1);
             sp=rs.getDouble(2);
             delay=rs.getInt(3);
         }
         if(qty<=avbqty)
         {
             pstmt=con.prepareStatement("select rad_ret_oid.nextval from sysibm.sysdummy1");
             rs=pstmt.executeQuery();
             long id=0;
             while(rs.next())
             {
                 id=rs.getLong(1);
             }
             
        pstmt=con.prepareCall("{call buy_product(?,?,?,?,?,?)}");
        pstmt.setLong(1, userid);
        pstmt.setDouble(2, sp);
        pstmt.setInt(3, qty);
        pstmt.setLong(4, pid);
        pstmt.setInt(5, delay);
        pstmt.setLong(6, id);
        pstmt.execute();
        pw.println("<h2>Your order has been successfully added.</h2>");
        pw.println("<br/>");
        pw.println("<br/>");
        pw.println("<table border=\"1\">"
                + "<tr>"
                + "<td>Order ID</td>"
                + "<td>RET"+id+"</td>"
                + "</tr>"
                + "<tr>"
                + "<td>"
                + "Price per Quantity"
                + "</td>"
                + "<td>"+sp
                + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td>"
                + "Quantity"
                + "</td>"
                + "<td>"+qty
                + "</td>"
                + "</tr>"
                + "<tr>"
                + "<td>"
                + "Total price"
                + "</td>"
                + "<td>"+(qty*sp)
                + "</td>"
                + "</tr>"
                + "</table>");
        obj.sendMessage(String.valueOf(userid), "666", "New Order Placed", "New Order Placed with order id RET"+id);
         }
         else
         {
             pw.println("Sorry, Quantity Exceeded cannot place order");
         }
        
     } catch (SQLException ex) {
         pw.println("0");
         Logger.getLogger(ret_pace_order.class.getName()).log(Level.SEVERE, null, ex);
     }
    
}
}

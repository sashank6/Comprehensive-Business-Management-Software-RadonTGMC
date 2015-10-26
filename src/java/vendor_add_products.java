/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sashank.Sashank;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Aneesh
 */
public class vendor_add_products extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   @Override
   protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
   {
       PrintWriter pw=res.getWriter();
       try {
           String make=rq.getParameter("make");
           make=make.toUpperCase();
           String model=rq.getParameter("model");
           model=model.toUpperCase();
           String price=rq.getParameter("price");
           String qty=rq.getParameter("qty");
           String mrp=rq.getParameter("mrp");
           String avb=rq.getParameter("avb");
           String desc=rq.getParameter("desc");
           int avbg=-1;
           if(avb.equalsIgnoreCase("Yes"))
               avbg=1;
           else
               avbg=0;
           HttpSession ses=rq.getSession();
           String user=(String) ses.getAttribute("userid");
           
           Sashank obj=new Sashank();
           Connection con=obj.getCon();
           PreparedStatement pstmt=con.prepareStatement("insert into v_"+user+"_products(make,modelno,cprice,mrp,desc,avbl,qty) values(?,?,?,?,?,?,?)");
           pstmt.setQueryTimeout(8);
           pstmt.setString(1, make);
           pstmt.setString(2, model);
           pstmt.setDouble(3, Double.parseDouble(price));
           pstmt.setDouble(4,Double.parseDouble(mrp));
           pstmt.setString(5, desc);
           pstmt.setInt(6, avbg);
           pstmt.setInt(7, Integer.parseInt(qty));
           pstmt.execute();
           pw.println("<html><head><title>Product Addition</title><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"/></head><body>");
           pw.println(" <h1>\n" +
"        <a href=\"admin_home.jsp\" style=\"color:white\">Project Radon</a>\n" +
"        <a href=\"logout.jsp\" style=\"float:right; color:white; font-size:16px; \">Log out</a>\n" +
"    </h1><br/><br/>");
           pw.println("<p>Product Insertion Successful</p>");
           
       } catch (SQLException ex) {
           Logger.getLogger(vendor_add_products.class.getName()).log(Level.SEVERE, null, ex);
       pw.println("Product Insertion Unsuccessful. This may be due to time out or discrepancy in Information. Please contact Admin.");
       }
      
      
   }
}

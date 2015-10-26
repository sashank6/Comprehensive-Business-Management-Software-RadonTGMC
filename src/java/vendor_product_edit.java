/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
public class vendor_product_edit extends HttpServlet {
 protected void doGet(HttpServletRequest rq, HttpServletResponse res) throws IOException
{ PrintWriter pw=res.getWriter();
     try {
         HttpSession ses=rq.getSession();
         String userid=(String)ses.getAttribute("userid");
         String make=rq.getParameter("make");
         String model=rq.getParameter("model");
         String price=rq.getParameter("price");
         String qty=rq.getParameter("qty");
         String desc=rq.getParameter("desc");
         String mrp=rq.getParameter("mrp");
         Sashank obj=new Sashank();
         Connection con=obj.getCon();
         PreparedStatement pstmt=con.prepareStatement("update v_"+userid+"_products set cprice=?,mrp=?,desc=?,qty=? where make=? and modelno=?");
         pstmt.setDouble(1, Double.parseDouble(price));
         pstmt.setDouble(2, Double.parseDouble(mrp));
         pstmt.setString(3, desc);
         pstmt.setInt(4,Integer.parseInt(qty));
         pstmt.setString(5, make);
         pstmt.setString(6, model);
         pstmt.execute();
         pw.println("Product Update Successful");
     } catch (SQLException ex) {
         Logger.getLogger(vendor_product_edit.class.getName()).log(Level.SEVERE, null, ex);
         pw.println("Product Update Not Successful");
     
     }
    
}
}

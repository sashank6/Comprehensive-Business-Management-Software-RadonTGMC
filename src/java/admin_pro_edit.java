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
import sashank.Sashank;

/**
 *
 * @author Aneesh
 */
public class admin_pro_edit extends HttpServlet {
 protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{
    String proid=rq.getParameter("proid");
    String mrp=rq.getParameter("mrp");
    String sp=rq.getParameter("sp");
    String desc=rq.getParameter("desc");
    String kw=rq.getParameter("kw");
    String minorder=rq.getParameter("minorder");
    String shipcost=rq.getParameter("shipcost");
    String dtime=rq.getParameter("dtime");
    Sashank obj=new Sashank();
    PrintWriter pw=res.getWriter();
     try {
         Connection con=obj.getCon();
         PreparedStatement pstmt=con.prepareStatement("update rad_act_inv set mrp=?,sp=?,desc=?,keywords=?,minorder=?,shipcost=?,mumin=? where pid=?");
         pstmt.setDouble(1, Double.parseDouble(mrp));
         pstmt.setDouble(2,Double.parseDouble(sp));
         pstmt.setString(3, desc);
         pstmt.setString(4, kw);
         pstmt.setInt(5,Integer.parseInt(minorder));
         pstmt.setDouble(6,Double.parseDouble(shipcost));
         pstmt.setInt(7, Integer.parseInt(dtime));
         pstmt.setLong(8, Long.parseLong(proid));
         pstmt.execute();
         pw.println("1");
         
     } catch (SQLException ex) {
         Logger.getLogger(admin_pro_edit.class.getName()).log(Level.SEVERE, null, ex);
         pw.println("0");
     }
}
}

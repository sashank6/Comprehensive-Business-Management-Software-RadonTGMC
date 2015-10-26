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
import sashank.Sashank;

/**
 *
 * @author Aneesh
 */
public class add_product_toact_admin extends HttpServlet {
 protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{
    PrintWriter pw=res.getWriter();
    String pcat=rq.getParameter("pcat");
    String ccat=rq.getParameter("ccat");
    String make=rq.getParameter("make");
    String model=rq.getParameter("model");
    String mrp=rq.getParameter("mrp");
    String sp=rq.getParameter("sp");
    String cp=rq.getParameter("cp");
    String desc=rq.getParameter("desc");
    String kw=rq.getParameter("kw");
    String minorder=rq.getParameter("minorder");
    String shipcost=rq.getParameter("shipcost");
    String dtime=rq.getParameter("dtime");
    String qty=rq.getParameter("qty");
    Sashank obj=new Sashank();
    Connection con = null;
    PreparedStatement pstmt;
     try {
         con=obj.getCon();
         con.setAutoCommit(false);
         pstmt=con.prepareStatement("update rad_res_inv set qty=qty-? where make=? and modelno=?");
         pstmt.setInt(1, Integer.parseInt(qty));
         pstmt.setString(2, make);
         pstmt.setString(3, model);
         pstmt.execute();
         pstmt=con.prepareStatement("select id from rad_pro_catid where parentcat=? and childcat=?");
         pstmt.setString(1, pcat);
         pstmt.setString(2,ccat);
         ResultSet rs=pstmt.executeQuery();
         int catid=0;
         while(rs.next())
             catid=rs.getInt(1);
         pstmt=con.prepareStatement("insert into rad_act_inv values(rad_pro_id.nextval,?,?,?,?,?,?,?,?,?,?,?,?)");
         pstmt.setString(1, model);
         pstmt.setString(2,make);
         pstmt.setInt(3, Integer.parseInt(qty));
         pstmt.setDouble(4,Double.parseDouble(mrp));
         pstmt.setDouble(5, Double.parseDouble(sp));
         pstmt.setDouble(6, Double.parseDouble(cp));
         pstmt.setString(7, desc);
         pstmt.setString(8, kw);
         pstmt.setInt(9, Integer.parseInt(minorder));
         pstmt.setDouble(10,Double.parseDouble(shipcost));
         pstmt.setInt(11,catid);
         pstmt.setInt(12, Integer.parseInt(dtime));
         pstmt.execute();
         pstmt=con.prepareStatement("commit");
         pstmt.execute();
         pw.println("1");
         
         
         
     } catch (SQLException ex) {
         Logger.getLogger(add_product_toact_admin.class.getName()).log(Level.SEVERE, null, ex);
     try
     {
         pstmt=con.prepareStatement("rollback");
         pstmt.execute();
         pw.println("0");
     }
     catch(Exception e)
     {
        pw.println("2");
     }
     
     
     }
     try {
         con.setAutoCommit(true);
     } catch (SQLException ex) {
         Logger.getLogger(add_product_toact_admin.class.getName()).log(Level.SEVERE, null, ex);
     }
     try {
         con.close();
     } catch (SQLException ex) {
         Logger.getLogger(add_product_toact_admin.class.getName()).log(Level.SEVERE, null, ex);
     }
    
}
}

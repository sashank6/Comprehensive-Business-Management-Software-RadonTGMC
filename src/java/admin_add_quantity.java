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
public class admin_add_quantity extends HttpServlet {
 protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{
    String make=rq.getParameter("make");
    String model=rq.getParameter("model");
    String qty=rq.getParameter("qty");
    PrintWriter pw=res.getWriter();
    Sashank obj=new Sashank();
    Connection con = null;
    PreparedStatement pstmt;
     try {
         con=obj.getCon();
         con.setAutoCommit(false);
         pstmt=con.prepareStatement("update rad_res_inv set qty=qty-? where make=? and modelno=?");
         pstmt.setLong(1, Long.parseLong(qty));
         pstmt.setString(2, make);
         pstmt.setString(3, model);
         pstmt.execute();
         pstmt=con.prepareStatement("update rad_act_inv set qty=qty+? where make=? and modelno=?");
         pstmt.setLong(1, Long.parseLong(qty));
         pstmt.setString(2, make);
         pstmt.setString(3, model);
         pstmt.execute();
         pstmt=con.prepareStatement("commit");
         pstmt.execute();
         pw.println("1");
     } catch (SQLException ex) {
        try {
            Logger.getLogger(admin_add_quantity.class.getName()).log(Level.SEVERE, null, ex);
        pstmt=con.prepareStatement("rollback");
        pstmt.execute();
        con.setAutoCommit(true);
        con.close();
        } catch (SQLException ex1) {
            Logger.getLogger(admin_add_quantity.class.getName()).log(Level.SEVERE, null, ex1);
        }
     
     }
}
}

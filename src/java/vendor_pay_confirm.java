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
public class vendor_pay_confirm extends HttpServlet {
 protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{
    PrintWriter pw=res.getWriter();
     try {
         
         String poid=rq.getParameter("poid");
         Sashank obj=new Sashank();
         Connection con=obj.getCon();
         HttpSession ses=rq.getSession();
         String userid=(String)ses.getAttribute("userid");
         PreparedStatement pstmt=con.prepareStatement("update v_"+userid+"_payments set status=1 where poid=?");
         pstmt.setString(1, poid);
         pstmt.execute();
         pw.println("1");
     } catch (SQLException ex) {
         Logger.getLogger(vendor_pay_confirm.class.getName()).log(Level.SEVERE, null, ex);
     pw.println("0");
     }
    
}
}

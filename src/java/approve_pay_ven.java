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
public class approve_pay_ven extends HttpServlet {
 protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{PreparedStatement pstmt;
Connection con = null;
PrintWriter pw=res.getWriter();
     try {
         String poid=rq.getParameter("poid");
         String vid=rq.getParameter("vid");
         String tv=rq.getParameter("tv");
         Sashank obj=new Sashank();
         con=obj.getCon();
         con.setAutoCommit(false);
         pstmt=con.prepareStatement("update rad_cash_table set amt=amt-? where id=2");
         pstmt.setDouble(1, Double.parseDouble(tv));
         pstmt.execute();
         pstmt=con.prepareStatement("update v_"+vid+"_payments set status=0 where poid=?");
         pstmt.setString(1, poid);
         pstmt.execute();
         pstmt=con.prepareStatement("update rad_po_ven set payment=2 where poid=?");
         pstmt.setString(1, poid);
         pstmt.execute();
         pstmt=con.prepareStatement("commit");
         pstmt.execute();
         
         pw.println("1");
     } catch (SQLException ex) {
    try {
        Logger.getLogger(approve_pay_ven.class.getName()).log(Level.SEVERE, null, ex);
        pstmt=con.prepareStatement("rollback");
        pstmt.execute();
        pw.println("0");
    } catch (SQLException ex1) {
        Logger.getLogger(approve_pay_ven.class.getName()).log(Level.SEVERE, null, ex1);
        pw.println("2");
    }
     }
     try {
         con.setAutoCommit(true);
         con.close();
     } catch (SQLException ex) {
         Logger.getLogger(approve_pay_ven.class.getName()).log(Level.SEVERE, null, ex);
     }
     
    
}
}

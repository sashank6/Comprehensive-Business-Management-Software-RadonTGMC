
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.*;
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
public class cancel_po extends HttpServlet 
{
    @Override
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        try {
            String porder=rq.getParameter("poid");
            String status=rq.getParameter("status");
            String vid=rq.getParameter("vid");
            String tv=rq.getParameter("tv");
            Sashank obj=new Sashank();
            Connection con=obj.getCon();
            if(Integer.parseInt(status)==0)
            {
              PreparedStatement pstmt=con.prepareStatement("update rad_po_ven set status=7 where poid=?");
            pstmt.setString(1, porder);
            pstmt.execute(); 
            pstmt=con.prepareStatement("delete from v_"+vid+"_payments where poid=?");
            pstmt.setString(1, porder);
            pstmt.execute();
            }
            else
            if(Integer.parseInt(status)==1)
            {
             PreparedStatement pstmt=con.prepareStatement("update rad_po_ven set status=6 where poid=?");
            pstmt.setString(1, porder);
            pstmt.execute();
                obj.sendMessage("666", vid, "Purchase Order Cancelled", "We are sorry to inform you that the Purchase Order "+porder+" has been terminated due to inevitable circumstances. We hope you understand.");
            }
            PreparedStatement pstmt=con.prepareStatement("update rad_cash_table set amt=amt-? where id=2");
            pstmt.setDouble(1, Double.parseDouble(tv));
            pstmt.execute();
            pstmt=con.prepareStatement("insert into rad_account_table values(?,?,current_timestamp,?,?)");
            pstmt.setString(1, porder+"-C");
            pstmt.setDouble(2, Double.parseDouble(tv));
            pstmt.setString(3, "Purchase Order Cancelled.");
            pstmt.setString(4,"CR");
            pstmt.execute();
            String query3="update v_"+vid+"_payments set status=4 where poid=\'"+porder+"\'";
             Statement stmt=con.createStatement();
             stmt.addBatch(query3);
             stmt.executeBatch();
            
            
            pw.println("1");
            
        } catch (SQLException ex) {
            Logger.getLogger(cancel_po.class.getName()).log(Level.SEVERE, null, ex);
            pw.println("0");
        }
        
    }
}

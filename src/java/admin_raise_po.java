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
public class admin_raise_po extends HttpServlet 
{
    @Override
    protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        try {
            String make=rq.getParameter("make1");
            String model=rq.getParameter("model1");
            String price=rq.getParameter("price1");
            String qty=rq.getParameter("qty1");
            String vid=rq.getParameter("vid1");
            String pymt=rq.getParameter("pymt1");
            Sashank obj=new Sashank();
            Connection con=obj.getCon();
            PreparedStatement pstmt=con.prepareStatement("select rad_po_id.nextval from sysibm.sysdummy1");
            ResultSet rs=pstmt.executeQuery();
           // pstmt.close();
            String poid="PO";
            while(rs.next())
            {
                poid+=rs.getLong(1);
            }
            
            String desc="Purchase order for "+make+" "+model+" for the price of "+price+" with quantity "+qty;
            pstmt=con.prepareStatement("insert into rad_account_table values(?,?,current_timestamp,?,?)");
            pstmt.setString(1, poid);
            pstmt.setDouble(2, Double.parseDouble(price)*Integer.parseInt(qty));
            pstmt.setString(3, desc);
            pstmt.setString(4, "DR");
            pstmt.execute();
            
            //pstmt.close();
            int no=pymt.equals("Immediate")?0:1;
            pstmt=con.prepareStatement("insert into rad_po_ven values(?,?,?,?,?,?,0,current_timestamp,?)");
            pstmt.setString(1, poid);
            pstmt.setLong(2, Long.parseLong(vid));
            pstmt.setInt(3, Integer.parseInt(qty));
            pstmt.setString(4, model);
            pstmt.setString(5, make);
            pstmt.setDouble(6, Double.parseDouble(price));
            pstmt.setInt(7, no);
            pstmt.execute();
            String vaufle=obj.sendMessage("666", vid , "Purchase Order Raised "+poid, desc);
            int no1=pymt.equals("Something went wrong please Try again")?0:1;
            if(no1==0)
            {
              throw new IOException();  
            }
        
            pstmt=con.prepareStatement("update rad_cash_table set amt=amt+? where id=2");
            pstmt.setDouble(1, Double.parseDouble(price)*Integer.parseInt(qty));
            pstmt.execute();
            String sql23="insert into v_"+vid+"_payments values(?,?,2)";
            pstmt=con.prepareStatement(sql23);
            pstmt.setString(1, poid);
            pstmt.setDouble(2, Double.parseDouble(price)*Integer.parseInt(qty));
            pstmt.execute();
            pw.println("1");
        } catch (Exception ex) {
            Logger.getLogger(admin_raise_po.class.getName()).log(Level.SEVERE, null, ex);
            pw.println("0");
        }
    }

  
}

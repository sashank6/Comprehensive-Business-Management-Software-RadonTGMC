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
public class accept_ret_order extends HttpServlet {
 protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{PrintWriter pw=res.getWriter();
     try {
         
         Sashank obj=new Sashank();
         Connection con=obj.getCon();
         HttpSession ses=rq.getSession();
         int userid=Integer.parseInt((String)ses.getAttribute("userid"));
         if(userid==666)
         {
             String orderid=rq.getParameter("orderid");
             String status=rq.getParameter("status");
             PreparedStatement pstmt;
             if(Integer.parseInt(status)==1)
             {
                 pstmt=con.prepareStatement("select r.cp, t.price, t.qty,t.rid from rad_act_inv r,rad_odrder_ret t where t.pid=r.pid and t.id=?");
                 pstmt.setString(1, orderid);
                 ResultSet rs=pstmt.executeQuery();
                 double cp = 0,price = 0;
                 int qty = 0;
                 long vid=0;
                 while(rs.next())
                 {
                     cp=rs.getDouble(1);
                     price=rs.getDouble(2);
                     qty=rs.getInt(3);
                     vid=rs.getLong(4);
                 }
                 double total=price*qty;
                 double profit=(price-cp)*qty;
                 con.setAutoCommit(false);
                 pstmt=con.prepareStatement("update rad_odrder_ret set status=1 where id=?");
                 pstmt.setString(1, orderid);
                 pstmt.setQueryTimeout(5);
                 pstmt.execute();
                 pstmt=con.prepareStatement("insert into rad_account_table values(?,?,current_timestamp,?,?)");
                 pstmt.setString(1, orderid);
                 pstmt.setDouble(2,total);
                 pstmt.setString(3, "Sales Order of Rs "+total+" with Order id "+orderid);
                 pstmt.setString(4, "CR");
                 pstmt.execute();
                 pstmt=con.prepareStatement("update rad_cash_table set amt=amt+? where id=5");
                 pstmt.setDouble(1, profit);
                 pstmt.execute();
                 con.commit();
                 con.setAutoCommit(true);
                 obj.sendMessage("666", String.valueOf(vid), "Order Accepted", "<p>We are pleased to Inform you the order no:"+orderid+" has been accepted by the company. We will ship the order soon and intimate you as early as possible.<br/><br/>Thank You for Shopping with us.</p>");
             }
             else
             {
                 pstmt=con.prepareStatement("update rad_odrder_ret set status=4 where id=?");
                 pstmt.setString(1, orderid);
                 pstmt.setQueryTimeout(5);
                 pstmt.execute();
             }
             pw.println("Request Processed Successfully");
         }
         else
             pw.println("Unauthorized Access");
     } catch (SQLException ex) {
         pw.println("Unable to Process Request");
         Logger.getLogger(accept_ret_order.class.getName()).log(Level.SEVERE, null, ex);
     }
    
}
}

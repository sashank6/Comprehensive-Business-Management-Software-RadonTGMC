import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sashank.Sashank;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Aneesh
 */
public class update_retailer_details extends HttpServlet {
@Override
protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{
    PrintWriter pw=res.getWriter();
    try {
        String cname="",city="",staddr="",email="";
                cname=rq.getParameter("cname1");
                staddr=rq.getParameter("staddr1");
                email=rq.getParameter("email1");
                city=rq.getParameter("city1");
                String ctno=rq.getParameter("ctno1");
                String pan_tin=rq.getParameter("pan_tin1");
                String emp_id=rq.getParameter("emp_id1");
                String userid=rq.getParameter("userid");
                Sashank obj=new Sashank();
                Connection con=obj.getCon();
               
               PreparedStatement pstmt=con.prepareStatement("update rad_retailer set cname=?,staddr=?,email=?,city=?,ctno=?,pan_tin=? where userid=?");
               pstmt.setQueryTimeout(5);
               pstmt.setString(1, cname);
                pstmt.setString(2,staddr);
                pstmt.setString(3, email);
                pstmt.setString(4,city);
                pstmt.setLong(5, Long.parseLong(ctno));
                pstmt.setLong(6, Long.parseLong(pan_tin));
                pstmt.setLong(7, Long.parseLong(userid));
                pstmt.execute();
                pw.println("1");
                
    } catch (SQLException ex) {
        Logger.getLogger(update_retailer_details.class.getName()).log(Level.SEVERE, null, ex);
        ex.printStackTrace();
        pw.println("0");
    }
            
            
}

  
}

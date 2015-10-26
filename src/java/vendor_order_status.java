/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
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
public class vendor_order_status extends HttpServlet {
 protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{
    PrintWriter pw=res.getWriter();
     try {
         Sashank obj=new Sashank();
         Connection con=obj.getCon();
         String poid=rq.getParameter("poid");
         String action=rq.getParameter("action");
         String pymtty=rq.getParameter("pymt");
         String tv=rq.getParameter("tv");
         String qty1=rq.getParameter("qty");
         String model=rq.getParameter("model");
         String make=rq.getParameter("make");
         HttpSession ses=rq.getSession();
         long userid;
         userid = Long.parseLong((String)ses.getAttribute("userid"));
         String query;
         String query2;
         if(Integer.parseInt(action)==1&&Integer.parseInt(pymtty)==0)
         {
           query="update rad_po_ven set status=2 where poid=\'"+poid+"\'";
           query2="update rad_cash_table set amt=amt-"+tv+" where id=2";
           String query3="update v_"+String.valueOf(userid)+"_payments set status=0 where poid=\'"+poid+"\'";
           String query4="update v_"+userid+"_products set qty=qty-"+qty1+" where make=\'"+make+"\' and modelno=\'"+model+"\'";
          //pw.println(query4);
           Statement stmt=con.createStatement();
           stmt.addBatch(query);
           stmt.addBatch(query2);
           stmt.addBatch(query3);
           stmt.addBatch(query4);
           stmt.executeBatch();
           
         }
         else
             if(Integer.parseInt(action)==1&&Integer.parseInt(pymtty)==1)
             {
                  query="update rad_po_ven set status=2 where poid=\'"+poid+"\'";
                  String query4="update v_"+userid+"_products set qty=qty-"+qty1+" where make=\'"+make+"\' and modelno=\'"+model+"\'";
                  Statement stmt=con.createStatement();
           stmt.addBatch(query);
            stmt.addBatch(query4);
            stmt.executeBatch();
             }
         else
             if(Integer.parseInt(action)==2)
             {
                query="update rad_po_ven set status=3 where poid=\'"+poid+"\'";
                 query2="update rad_cash_table set amt=amt-"+tv+" where id=2";
                 String query4="insert into rad_account_table values(\'"+poid+"-C\',"+tv+",current_timestamp,\'Purchase Order Cancelled\',\'CR\')";
                 String query3="update v_"+String.valueOf(userid)+"_payments set status=4 where poid=\'"+poid+"\'";
                 Statement stmt=con.createStatement();
           stmt.addBatch(query);
           stmt.addBatch(query2);
           stmt.addBatch(query3);
           stmt.addBatch(query4);
           stmt.executeBatch();
             }
         else
                 if(Integer.parseInt(action)==3)
                 {
                 query="update rad_po_ven set status=4 where poid=\'"+poid+"\'";
                   Statement stmt=con.createStatement();
           stmt.addBatch(query);
           stmt.executeBatch();
                 }
         
     } catch (SQLException ex) {
         Logger.getLogger(vendor_order_status.class.getName()).log(Level.SEVERE, null, ex);
     }
    
}
}

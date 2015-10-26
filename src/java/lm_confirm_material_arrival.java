/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


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
public class lm_confirm_material_arrival extends HttpServlet {
 protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{
    PrintWriter pw=res.getWriter();
    PreparedStatement pstmt = null;
    Connection con = null;
     try {
         Sashank obj=new Sashank();
         con=obj.getCon();
        con.setAutoCommit(false);
         String poid=rq.getParameter("poid");
         pstmt=con.prepareStatement("select vid,qty,modelno,make,price,payment from rad_po_ven where poid=?");
         pstmt.setString(1, poid);
         long vid = 0,qty = 0,payment;
         String modelno = null,make = null;
         double price = 0;
         ResultSet rs=pstmt.executeQuery();
         while(rs.next())
         {
             vid=rs.getLong(1);
             qty=rs.getLong(2);
             modelno=rs.getString(3);
             make=rs.getString(4);
             price=rs.getDouble(5);
             payment=rs.getLong(6);
         }
         pstmt=con.prepareStatement("update rad_po_ven set status=5 where poid=?");
         pstmt.setString(1, poid);
         pstmt.execute();
         obj.sendMessage("111", "666", "Material Received for "+poid, "Sir, The material for purchase Order "+poid+" had arrived at the warehouse. This is for your Confirmation only.");
         pstmt=con.prepareStatement("select count(*) from rad_res_inv where make=? and modelno=?");
         pstmt.setString(1, make);
         pstmt.setString(2, modelno);
         rs=pstmt.executeQuery();
         int ct=-1;
         double mrp = 0;
         while(rs.next())
         {
             ct=rs.getInt(1);
         }
         pstmt=con.prepareStatement("select mrp from v_"+vid+"_products where make=? and modelno=?");
             pstmt.setString(1, make);
             pstmt.setString(2, modelno);
             rs=pstmt.executeQuery();
              mrp = 0;
              while(rs.next())
             {
                 mrp=rs.getDouble(1);
             }
         if(ct==0)
         {
             
             
             pstmt=con.prepareStatement("insert into rad_res_inv values(?,?,?,?,current_date,?)");
             pstmt.setString(1, modelno);
             pstmt.setString(2,make);
             pstmt.setLong(3,qty);
             pstmt.setDouble(4,price);
             pstmt.setDouble(5, mrp);
             pstmt.execute();
             
             
         }
         else
         {
             pstmt=con.prepareStatement("select qty,pprice from rad_res_inv where make=? and modelno=?");
             pstmt.setString(1, make);
             pstmt.setString(2, modelno);
             rs=pstmt.executeQuery();
             double oprice = 0;
             long oqty = 0;
             while(rs.next())
             {
                 oqty=rs.getLong(1);
                 oprice=rs.getDouble(2);
                 
             }
             double tv1=oprice*oqty;
             double tv2=price*qty;
             double ftv=(tv1+tv2)/(oqty+qty);
             pstmt=con.prepareStatement("update rad_res_inv set qty=qty+?,pprice=?,mrp=? where make=? and modelno=?");
             pstmt.setLong(1, qty);
             pstmt.setDouble(2, ftv);
             pstmt.setDouble(3, mrp);
             pstmt.setString(4, make);
             pstmt.setString(5, modelno);
             pstmt.execute();
            
             
         }
          Statement stmt=con.createStatement();
          stmt.execute("commit");
         
          pw.println("1");
         
     } catch (SQLException ex) {
         Logger.getLogger(lm_confirm_material_arrival.class.getName()).log(Level.SEVERE, null, ex);
        try {
              Statement stmt=con.createStatement();
          stmt.execute("rollback");
            pw.println("0");
        } catch (SQLException ex1) {
            Logger.getLogger(lm_confirm_material_arrival.class.getName()).log(Level.SEVERE, null, ex1);
        }
     
     
     
     }
    
}
}

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
public class GetPricesVendorsPO extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        try {
            String make=rq.getParameter("make");
            String model=rq.getParameter("model");
            long qty=Long.parseLong(rq.getParameter("qty"));
            Sashank obj=new Sashank();
            Connection con=obj.getCon();
            PreparedStatement pstmt=con.prepareStatement("select userid from rad_login where userclass=3 and accountstat=1");
            ResultSet rs=pstmt.executeQuery();
            String query="";
            while(rs.next())
            {
                String cname = null;
                long useride=rs.getLong(1);
                PreparedStatement pstmt2=con.prepareStatement("select cname from rad_vendor where userid=?");
                pstmt2.setLong(1, useride);
                ResultSet rs1=pstmt2.executeQuery();
                while(rs1.next())
                    cname=rs1.getString(1);
                pstmt2.close();
                rs1.close();
                PreparedStatement pstmt1=con.prepareStatement("select cprice,mrp from v_"+useride+"_products where make=? and modelno=? and qty>=?");
                pstmt1.setString(1, make);
                pstmt1.setString(2, model);
                pstmt1.setLong(3, qty);
                ResultSet rs2=pstmt1.executeQuery();
                while(rs2.next())
                {
                    long pricew=rs2.getLong(1);
                    long mrpw=rs2.getLong(2);
                    query+="<tr id=\""+useride+"\"><td>"+cname+"</td>"+"<td id=\"price\">"+pricew+"</td>"+"<td>"+mrpw+"</td><td><input type=\"button\" value=\"select\" onclick=\"fungh("+useride+","+pricew+")\"/></td></tr>";
                }
                
                
            }
            pw.println(query);
        } catch (SQLException ex) {
            Logger.getLogger(GetPricesVendorsPO.class.getName()).log(Level.SEVERE, null, ex);
        pw.println("0");
        }
        
        
    }
}

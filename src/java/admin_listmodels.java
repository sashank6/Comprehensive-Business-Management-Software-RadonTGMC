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
/**
 *
 * @author Aneesh
 */
public class admin_listmodels extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException 
    {
         PrintWriter pw=res.getWriter();
        try
        {
       String make=rq.getParameter("make");
       Sashank obj=new Sashank();
       Connection con=obj.getCon();
       PreparedStatement pstmt=con.prepareStatement("select userid from rad_login where userclass=3 and accountstat=1");
       ResultSet rs=pstmt.executeQuery();
       while(rs.next())
       {
           long userid=rs.getLong(1);
           PreparedStatement pstmt1=con.prepareStatement("select modelno from v_"+userid+"_products where make=?");
           pstmt1.setString(1, make);
           ResultSet rs1=pstmt1.executeQuery();
           while(rs1.next())
           {
               String modelno=rs1.getString(1);
               if(!obj.verifymake(modelno))
                   obj.pushmaker(modelno);
           }
       }
       int x=obj.makerctc();
       String query="";
       for(int i=0;i<x;i++)
       {
           query+="<option>"+obj.popmaker()+"</option>";
       }
      
       pw.println(query);
        }
        catch(Exception e)
        {
            e.printStackTrace();
            pw.println("0");
            
        }
       
       
    }
}

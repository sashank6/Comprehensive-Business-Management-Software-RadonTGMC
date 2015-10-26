/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


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
public class return_cost_admin extends HttpServlet {
 protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{
    PrintWriter pw=res.getWriter();
    Sashank obj=new Sashank();
     try {
         Connection con=obj.getCon();
         String parentcat=rq.getParameter("make");
         String model=rq.getParameter("model");
         PreparedStatement pstmt=con.prepareStatement("select pprice from rad_res_inv where make=? and modelno=?");
         pstmt.setString(1, parentcat);
         pstmt.setString(2, model);
         ResultSet rs=pstmt.executeQuery();
         //String query="";
         while(rs.next())
         {
             pw.println(rs.getDouble(1));
         }
         
     } catch (SQLException ex) {
         Logger.getLogger(return_modelno_admin.class.getName()).log(Level.SEVERE, null, ex);
     }
}
}

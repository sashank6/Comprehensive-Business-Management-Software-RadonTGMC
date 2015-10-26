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
public class return_child_cat extends HttpServlet {
 protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
{
    PrintWriter pw=res.getWriter();
    Sashank obj=new Sashank();
     try {
         Connection con=obj.getCon();
         String parentcat=rq.getParameter("parentcat");
         PreparedStatement pstmt=con.prepareStatement("select childcat from rad_pro_catid where parentcat=?");
         pstmt.setString(1, parentcat);
         ResultSet rs=pstmt.executeQuery();
         String query="";
         while(rs.next())
         {
             query+="<option>"+rs.getString(1)+"</option>";
         }
         pw.println(query);
     } catch (SQLException ex) {
         Logger.getLogger(return_child_cat.class.getName()).log(Level.SEVERE, null, ex);
     }
    
}
}

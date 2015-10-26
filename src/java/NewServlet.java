/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
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
public class NewServlet extends HttpServlet {
 protected void doGet(HttpServletRequest rq, HttpServletResponse res)
{
     try {
         Sashank obj=new Sashank();
         Connection con=obj.getCon();
         String query="insert into test values(\'Sashank\')";
         String query2="insert into test values(\'Aneesh\')";
         String query3="insert into test values(\'TGMC\')";
         Statement stmt=con.createStatement();
         stmt.addBatch(query);
         stmt.addBatch(query2);
         stmt.addBatch(query3);
         stmt.executeBatch();
         
     } catch (SQLException ex) {
         Logger.getLogger(NewServlet.class.getName()).log(Level.SEVERE, null, ex);
     }
    
}
}

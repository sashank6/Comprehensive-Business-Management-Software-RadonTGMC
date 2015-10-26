

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sashank.Sashank;

/**
 * Servlet implementation class update_retailer_status
 */
@WebServlet("/update_retailer_status")
public class update_retailer_status extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public update_retailer_status() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    PrintWriter pw;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		pw=response.getWriter();
		long retailer=Long.parseLong(request.getParameter("retailer"));
		int new_status=Integer.parseInt(request.getParameter("status"));
		try
		{
			update_status(retailer,new_status);
		}
		catch(Exception e)
		{
			pw.println("Something went wrong");
			e.printStackTrace(pw);
		}
		
		
		
		
	}
	public void update_status(long ret_id,int status) throws SQLException
	{
		Sashank obj=new Sashank();
		Connection con=obj.getCon();
		PreparedStatement pstmt=con.prepareStatement("update rad_login set accountstat=? where userid=?");
		pstmt.setInt(1, status);
		pstmt.setLong(2, ret_id);
		pstmt.execute();
		pw.println("Updated Successfully");
		
		
		
	}
	
	

}

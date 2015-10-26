

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sashank.Sashank;

/**
 * Servlet implementation class addVendorByAdmin
 */
@WebServlet("/addVendorByAdmin")
public class addVendorByAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addVendorByAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    PrintWriter pw;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		pw=response.getWriter();
		String loust=(String)request.getParameter("status");
		long userid=Long.parseLong((String)request.getParameter("userid"));
		
		try
		{
			updateData(loust,userid);
			pw.println("Updated Successfully");
		}
		catch(Exception e)
		{
			e.printStackTrace(pw);
		}
		
	}
	
	
	public void updateData(String saw,long userid) throws SQLException
	{
		Sashank obj=new Sashank();
		Connection con=obj.getCon();
		long hulk=Long.parseLong(saw);
		if(hulk<=3)
		{
			PreparedStatement pstmt=con.prepareStatement("update rad_login set accountstat=? where userid=?");
			pstmt.setLong(1, hulk);
			pstmt.setLong(2,userid);
			pstmt.execute();
		}
		else
			if(hulk==4)
			{
				CallableStatement cs=con.prepareCall("{call add_ven_new(?)}");
				cs.setLong(1, userid);
				cs.execute();
			}
		
		
		
	}

}

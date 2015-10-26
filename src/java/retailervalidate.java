

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sashank.Sashank;

/**
 * Servlet implementation class retailervalidate
 */
@WebServlet("/retailervalidate")
public class retailervalidate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public retailervalidate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    PrintWriter pw;
	protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws ServletException, IOException
	{
		pw=res.getWriter();
		String tinno=rq.getParameter("tin");
		
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt;
		try
		{
			
            Sashank obj=new Sashank();
            con=obj.getCon();
			pstmt=con.prepareStatement("select count(*) from rad_retailer where pan_tin=?");
			pstmt.setLong(1, Long.parseLong(tinno));
			rs=pstmt.executeQuery();
			int a=-1;
			while(rs.next())
			{
				a=rs.getInt(1);
			}
			if(a==0)
				pw.println("1");
			else
				pw.println("0");
			con.close();
			
		}
		catch(Exception e)
		{
			pw.println("Unable to establish Connection");
		}
	}

}

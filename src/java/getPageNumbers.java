

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sashank.Sashank;
import java.sql.*;
/**
 * Servlet implementation class getPageNumbers
 */
@WebServlet("/getPageNumbers")
public class getPageNumbers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getPageNumbers() {
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
		// TODO Auto-generated method stub
		String cat=request.getParameter("cat");
		String type=request.getParameter("type");
		try
		{
			long h=getPageData(cat,type);
			pw.println(h);
			
		}
		catch(Exception e)
		{
			pw.println("-1");
		}
		
	}
	
	public long getPageData(String cat,String type) throws SQLException
	{
		PreparedStatement pstmt;
		ResultSet rs;
		Sashank obj=new Sashank();
		Connection con=obj.getCon();
		int type1=Integer.parseInt(type);
		int cat1=Integer.parseInt(cat);
		if(cat1==3)
		{
			if(type1==4)
			{
				pstmt=con.prepareStatement("select count(*) from rad_vendor");
				rs=pstmt.executeQuery();
				long count=0;
				while(rs.next())
					count=rs.getLong(1);
				pstmt.close();
				rs.close();
				return ((count)/20)+1;		
				
			}
			else
			{
					pstmt=con.prepareStatement("select count(*) from rad_login where userclass=? and type=?");
					pstmt.setLong(1, cat1);
					pstmt.setLong(2, type1);
					rs=pstmt.executeQuery();
					long count=0;
					while(rs.next())
						count=rs.getLong(1);
					pstmt.close();
					rs.close();
					return ((count)/20)+1;	
					
				}
		}
			else
			if(cat1==2)
				{
				   if(type1==4)
				   {
					pstmt=con.prepareStatement("select count(*) from rad_retailer");
					rs=pstmt.executeQuery();
					long count=0;
					while(rs.next())
						count=rs.getLong(1);
					pstmt.close();
					rs.close();
					return ((count)/20)+1;		
					
				}
				else
				{
						pstmt=con.prepareStatement("select count(*) from rad_login where userclass=? and type=?");
						pstmt.setLong(1, cat1);
						pstmt.setLong(2, type1);
						rs=pstmt.executeQuery();
						long count=0;
						while(rs.next())
							count=rs.getLong(1);
						pstmt.close();
						rs.close();
						return ((count)/20)+1;	
						
				}
			}
				
			return -1;
		
	}
		
	


}

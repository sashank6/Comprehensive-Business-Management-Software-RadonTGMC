

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
 * Servlet implementation class viewAllList
 */
@WebServlet("/viewAllList")
public class viewAllList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public viewAllList() {
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
		String pageno=request.getParameter("pageno");
		String type=request.getParameter("type");
		try
		{
			senddata(cat,pageno,type);
		}
		catch(Exception e)
		{
			pw.println("Error Occured Please Contact Admin or retry");
			e.printStackTrace(pw);
			
		}
		
	}
	public void senddata(String cat,String pageno,String type) throws SQLException
	{
		Sashank obj=new Sashank();
		Connection con=obj.getCon();
		PreparedStatement pstmt;
		ResultSet rs;
		
		int cat1=Integer.parseInt(cat);
		int pageno1=Integer.parseInt(pageno);
		int type1=Integer.parseInt(type);
		int low=(pageno1-1)*20;
		int high=(pageno1)*20;
		if(cat1==3)
		{
			if(type1==4)
			{
				pstmt=con.prepareStatement("with radontest as (select cname,city,tinno,a.userid,accountstat,row_number() over(order by cname) as rn from rad_vendor a,rad_login b where a.userid=b.userid) select cname,city,tinno,userid,accountstat from radontest where rn>? and rn<=?");
				pstmt.setInt(1, low);
				pstmt.setInt(2, high);
				rs=pstmt.executeQuery();
				pw.println("<table border=\"1\">");
				pw.println("<th>Company Name</th><th>City</th><th>TIN/TAN</th><th>User ID</th><th>Account Status</th>");
				while(rs.next())
				{
					pw.println("<tr>");
					pw.println("<td>"+rs.getString(1)+"</td>");
					pw.println("<td>"+rs.getString(2)+"</td>");
					pw.println("<td>"+rs.getLong(3)+"</td>");
					long ahuj=rs.getLong(4);
					pw.println("<td><a href=\"view_vendor_details.jsp?vid="+ahuj+"\">"+ahuj+"</a></td>");
					int a=rs.getInt(5);
					if(a==0)
						pw.println("<td>Permanently Disabled</td>");
					else
						if(a==1)
							pw.println("<td>Active</td>");
						else
							if(a==2)
								pw.println("<td>Freezed</td>");
							else
								if(a==3)
									pw.println("<td>Unapproved</td>");
					pw.println("</tr>");
				}
				pw.println("</table>");
				
			}
			else
			{
				
				pstmt=con.prepareStatement("with radontest as (select cname,city,tinno,accountstat,a.userid,row_number() over(order by "+"cname"+") as rn from rad_vendor a,rad_login b where a.userid=b.userid and b.accountstat=?) select cname,city,tinno,userid,accountstat from radontest where rn>? and rn<=?");
				pstmt.setInt(1, type1);
				pstmt.setInt(2, low);
				pstmt.setInt(3, high);
				rs=pstmt.executeQuery();
				pw.println("<table border=\"1\">");
				pw.println("<th>Company Name</th><th>City</th><th>TIN/TAN</th><th>User ID</th><th>Account Status</th>");
				while(rs.next())
				{
					pw.println("<tr>");
					pw.println("<td>"+rs.getString(1)+"</td>");
					pw.println("<td>"+rs.getString(2)+"</td>");
					pw.println("<td>"+rs.getLong(3)+"</td>");
					long ahuj=rs.getLong(4);
					pw.println("<td><a href=\"view_vendor_details.jsp?vid="+ahuj+"\">"+ahuj+"</a></td>");
					int a=rs.getInt(5);
					if(a==0)
						pw.println("<td>Permanently Disabled</td>");
					else
						if(a==1)
							pw.println("<td>Active</td>");
						else
							if(a==2)
								pw.println("<td>Freezed</td>");
							else
								if(a==3)
									pw.println("<td>Unapproved</td>");
					pw.println("</tr>");
				}
				pw.println("</table>");
			}
		}
		
	}
	
	
	
	

}



import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sashank.Sashank;
import java.sql.*;
/**
 * Servlet implementation class viewRetailers
 */
@WebServlet("/viewRetailers")
public class viewRetailers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public viewRetailers() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    PrintWriter pw;HttpSession ses;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String x=request.getParameter("type");
		pw=response.getWriter();
		ses=request.getSession();
		long userid = 0;
		try
		{
			userid=Long.parseLong((String)ses.getAttribute("userid"));
			
		}
		catch(Exception e)
		{
			pw.println("Do you Think I am a Fool?");
		}
		
		if(userid==666)
		{
	
		
		int a=Integer.parseInt(request.getParameter("type"));
		try
		{
			getData(a);
		}
		catch(Exception e)
		{
			pw.println("Exception Caught");
		}
		}
		else
			pw.println("Do you Think I am a Fool?");
		
		
	}
	
	public void getData(int a) throws SQLException
	{
		Sashank obj=new Sashank();
		Connection con=obj.getCon();
		
		PreparedStatement pstmt;
		if(a==0)
		{
			pstmt=con.prepareStatement("select cname,pan_tin,city,a.userid from rad_login a,rad_retailer b where a.userid=b.userid and accountstat=0");
			pw.println("<table border=\"1\">");
			pw.println("<th>Company Name</th>");
			pw.println("<th>TIN/TAN</th>");
			pw.println("<th>City</th>");
			pw.println("<th>Radon ID</th>");
			pw.println("<th>Status</th>");
			ResultSet rs=pstmt.executeQuery();
			while(rs.next())
			{
				pw.println("<tr>");
				pw.println("<td>"+rs.getString(1)+"</td>");
				pw.println("<td>"+rs.getLong(2)+"</td>");
				pw.println("<td>"+rs.getString(3)+"</td>");
				long x=rs.getLong(4);
				pw.println("<td><a href=\"view_retailer_details.jsp?retailer="+x+"\">"+x+"</a></td>");
				pw.println("<td>Permanently Disabled</td>");
				pw.println("</tr>");
				
			}
			pw.println("</table>");
			pstmt.close();
			
		}
		else
			if(a==1)
			{
				pstmt=con.prepareStatement("select cname,pan_tin,city,a.userid from rad_login a,rad_retailer b where a.userid=b.userid and accountstat=1");
				pw.println("<table border=\"1\">");
				pw.println("<th>Company Name</th>");
				pw.println("<th>TIN/TAN</th>");
				pw.println("<th>City</th>");
				pw.println("<th>Radon ID</th>");
				pw.println("<th>Status</th>");
				ResultSet rs=pstmt.executeQuery();
				while(rs.next())
				{
					pw.println("<tr>");
					pw.println("<td>"+rs.getString(1)+"</td>");
					pw.println("<td>"+rs.getLong(2)+"</td>");
					pw.println("<td>"+rs.getString(3)+"</td>");
					long x=rs.getLong(4);
					pw.println("<td><a href=\"view_retailer_details.jsp?retailer="+x+"\">"+x+"</a></td>");
					pw.println("<td>Active</td>");
					pw.println("</tr>");
					
				}
				pw.println("</table>");
				pstmt.close();
				
			}
			else
				if(a==2)
				{
					pstmt=con.prepareStatement("select cname,pan_tin,city,a.userid from rad_login a,rad_retailer b where a.userid=b.userid and accountstat=2");
					pw.println("<table border=\"1\">");
					pw.println("<th>Company Name</th>");
					pw.println("<th>TIN/TAN</th>");
					pw.println("<th>City</th>");
					pw.println("<th>Radon ID</th>");
					pw.println("<th>Status</th>");
					ResultSet rs=pstmt.executeQuery();
					while(rs.next())
					{
						pw.println("<tr>");
						pw.println("<td>"+rs.getString(1)+"</td>");
						pw.println("<td>"+rs.getLong(2)+"</td>");
						pw.println("<td>"+rs.getString(3)+"</td>");
						long x=rs.getLong(4);
						pw.println("<td><a href=\"view_retailer_details.jsp?retailer="+x+"\">"+x+"</a></td>");
						pw.println("<td>Freezed</td>");
						pw.println("</tr>");
						
					}
					pw.println("</table>");
					pstmt.close();
					
					
				}
				else
					if(a==3)
					{
						pstmt=con.prepareStatement("select cname,pan_tin,city,a.userid from rad_login a,rad_retailer b where a.userid=b.userid and accountstat=3");
						pw.println("<table border=\"1\">");
						pw.println("<th>Company Name</th>");
						pw.println("<th>TIN/TAN</th>");
						pw.println("<th>City</th>");
						pw.println("<th>Radon ID</th>");
						pw.println("<th>Status</th>");
						ResultSet rs=pstmt.executeQuery();
						while(rs.next())
						{
							pw.println("<tr>");
							pw.println("<td>"+rs.getString(1)+"</td>");
							pw.println("<td>"+rs.getLong(2)+"</td>");
							pw.println("<td>"+rs.getString(3)+"</td>");
							long x=rs.getLong(4);
							pw.println("<td><a href=\"view_retailer_details.jsp?retailer="+x+"\">"+x+"</a></td>");
							pw.println("<td>Unapproved</th>");
							pw.println("</tr>");
							
						}
						pw.println("</table>");
						pstmt.close();
						
					}
					else
						if(a==4)
						{
							pstmt=con.prepareStatement("select cname,pan_tin,city,a.userid,accountstat from rad_login a,rad_retailer b where a.userid=b.userid");
							pw.println("<table border=\"1\">");
							pw.println("<th>Company Name</th>");
							pw.println("<th>TIN/TAN</th>");
							pw.println("<th>City</th>");
							pw.println("<th>Radon ID</th>");
							pw.println("<th>Status</th>");
							ResultSet rs=pstmt.executeQuery();
							while(rs.next())
							{
								pw.println("<tr>");
								pw.println("<td>"+rs.getString(1)+"</td>");
								pw.println("<td>"+rs.getLong(2)+"</td>");
								pw.println("<td>"+rs.getString(3)+"</td>");
								long x=rs.getLong(4);
								pw.println("<td><a href=\"view_retailer_details.jsp?retailer="+x+"\">"+x+"</a></td>");
								int fg=rs.getInt(5);
								if(fg==3)
									pw.println("<td>Unapproved</th>");
								else
									if(fg==2)
										pw.println("<td>Freezed</td>");
									else
										if(fg==1)
											pw.println("<td>Active</td>");
										else
											if(fg==0)
												pw.println("<td>Permanently Disabled</td>");
								
								pw.println("</tr>");
								
							}
							pw.println("</table>");
							pstmt.close();
							
						}
						
							
		
		
		
	con.close();
	
	}
	
	
	
	}
	
	



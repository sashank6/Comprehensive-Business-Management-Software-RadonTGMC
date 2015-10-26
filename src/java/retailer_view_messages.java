

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
 * Servlet implementation class retailer_view_messages
 */
@WebServlet("/retailer_view_messages")
public class retailer_view_messages extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public retailer_view_messages() {
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
		String userid=request.getParameter("userid");
		String type=request.getParameter("type");
		String page=request.getParameter("pageno");
		try
		{
			viewMessage(Long.parseLong(userid),Integer.parseInt(type),Integer.parseInt(page));
		}
		catch(Exception e)
		{
			pw.println("Error Reading Data");
		}
		
	}
	public void viewMessage(long userid,int type,int pageno) throws SQLException
	{
		int low=(pageno-1)*20;
		int high=pageno*20;
		pw.println("<table border=\"1\">");
		pw.println("<th>Address</th><th>Subject</th><th>Time</th>");
		String tablename="m_"+String.valueOf(userid)+"_messages";
		Sashank obj=new Sashank();
		Connection con=obj.getCon();
		PreparedStatement pstmt=con.prepareStatement("with devshedtest as (select mid,address,subject,otime,row_number() over(order by otime desc) as rn from "+tablename+" where type=?) select mid,address,subject,otime from devshedtest where rn >? and rn<=?");
		pstmt.setInt(1,type);
		pstmt.setInt(2,low);
		pstmt.setInt(3, high);
		ResultSet rs=pstmt.executeQuery();
		while(rs.next())
		{
			pw.println("<tr>");
			pw.println("<td>"+rs.getString(2)+"</td>");
			pw.println("<td><a href=\"descmessage.jsp?mid="+rs.getLong(1)+"\">"+rs.getString(3)+"</a></td>");
			pw.println("<td>"+rs.getTimestamp(4)+"</td>");
			pw.println("</tr>");
		}
		pw.println("</table>");
		
		
	}

}

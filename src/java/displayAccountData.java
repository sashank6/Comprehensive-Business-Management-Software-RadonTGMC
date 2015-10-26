

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sashank.Sashank;

/**
 * Servlet implementation class displayAccountData
 */
@WebServlet("/displayAccountData")
public class displayAccountData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public displayAccountData() {
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
		long a=Long.parseLong(request.getParameter("pageno"));
		
		try
		{
			sendData(a);
		}
		catch(Exception e)
		{
			pw.println("Oops, Something went wrong. Please try again. If you continue to face problem please contact Software Unit");
		}
		
	}
	
	
	public void sendData(long pageno) throws Exception
	{
		long low=(pageno-1)*20;
		long high=(pageno)*20;
		Sashank obj=new Sashank();
		Connection con=obj.getCon();
		PreparedStatement pstmt=con.prepareStatement("with radontest as (select id,amt,ttime,type,row_number() over (order by ttime desc) as rn from rad_account_table) select id,amt,type,ttime from radontest where rn>? and rn<=?");
		pstmt.setLong(1, low);
		pstmt.setLong(2, high);
		ResultSet rs=pstmt.executeQuery();
		pw.println("<table border=\"1\">");
		pw.println("<th>Transaction ID:</th><th>Amount</th><th>Type</th><th>Time of Transaction</th>");
		while(rs.next())
		{
			pw.println("<tr>");
			pw.println("<td>"+rs.getString(1)+"</td>");
			pw.println("<td>"+rs.getDouble(2)+"</td>");
			pw.println("<td>"+rs.getString(3)+"</td>");
			pw.println("<td>"+rs.getTimestamp(4)+"</td>");
			pw.println("</tr>");
		}
		
		pw.println("</table>");
	}

}

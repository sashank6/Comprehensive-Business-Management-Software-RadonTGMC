

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sashank.Sashank;

/**
 * Servlet implementation class addCashTransaction
 */
@WebServlet("/addCashTransaction")
public class addCashTransaction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addCashTransaction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		PrintWriter pw=response.getWriter();
		String amt=request.getParameter("amt");
		String desc=request.getParameter("desc");
		String cool=request.getParameter("cool");

		try
		{
			addTransa(Double.parseDouble(amt),desc,cool);
			pw.println("Transaction Successful");
		}
		catch(Exception e)
		{
			pw.println("Something Went wrong Please Try again");
		}
	
		
		// TODO Auto-generated method stub
	}
	
	public void addTransa(double amt,String desc,String cool) throws SQLException
	{
		Sashank obj=new Sashank();
		Connection con=obj.getCon();
		PreparedStatement pstmt=con.prepareStatement("select rad_cash_id.nextval from sysibm.sysdummy1");
		long id=-1;
		ResultSet rs1=pstmt.executeQuery();
		while(rs1.next())
			id=rs1.getLong(1);
		
		
		 pstmt=con.prepareStatement("insert into rad_account_table values(?,?,current_timestamp,?,?)");
		pstmt.setString(1, "CSH"+String.valueOf(id));
		pstmt.setDouble(2, amt);
		pstmt.setString(3, desc);
		pstmt.setString(4, cool);
		pstmt.execute();
		pstmt.close();
		con.close();
		
		
	}

}

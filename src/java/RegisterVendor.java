

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sashank.Sashank;

/**
 * Servlet implementation class RegisterVendor
 */
@WebServlet("/RegisterVendor")
public class RegisterVendor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterVendor() {
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
		String tin=request.getParameter("tin");
		String cname=request.getParameter("cname");
		String city=request.getParameter("city");
		String addr=request.getParameter("staddr");
		String ctno=request.getParameter("ctno");
		String pwd=request.getParameter("pwd");
		
		try
		{
			sendData(Long.parseLong(tin),city,cname,addr,ctno,pwd);
		}
		catch(Exception e)
		{
			pw.println("Registration Unsuccessful Please Contact Admin.");
		}
		
	}
	public void sendData(long tin,String city,String cname,String addr,String ctno,String pwd) throws SQLException
	{
		Sashank obj=new Sashank();
		Connection con=obj.getCon();
		CallableStatement cs=con.prepareCall("{call add_user(?,?,?,?,?,null,null,rad_ven_id.nextval,3,2,?,null,null,null)}");
		cs.setString(1, cname);
		cs.setLong(2, Long.parseLong(ctno));
		cs.setString(3, city);
		cs.setString(4, addr);
		cs.setLong(5, tin);
		cs.setString(6, pwd);
		cs.execute();
		pw.println("Registered Successfully Please wait for Admin Approval");
	}

}

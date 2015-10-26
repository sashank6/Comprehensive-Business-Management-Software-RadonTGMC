

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
import javax.servlet.http.HttpSession;

import sashank.Sashank;


/**
 * Servlet implementation class loginvalidate
 */
@WebServlet("/loginvalidate")
public class loginvalidate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loginvalidate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		PrintWriter pw=response.getWriter();
		String userid=request.getParameter("userid");
		String pwd=request.getParameter("pwd");
		Sashank obj=new Sashank();
		HttpSession ses=request.getSession();
		try {
			Connection con=obj.getCon();
			PreparedStatement pstmt=con.prepareStatement("select pwd,accountstat,userclass from rad_login where userid=?");
			pstmt.setLong(1, Long.parseLong(userid));
			ResultSet rs=pstmt.executeQuery();
			String rpwd = null;
			int userclass=-1,stat=-1;
			while(rs.next())
			{
				rpwd=rs.getString(1);
				stat=rs.getInt(2);
				userclass=rs.getInt(3);
			}
			boolean pwdv=false;
			if(rpwd.equals(pwd))
				pwdv=true;
                        if(!pwdv&&stat==2)
                            pw.println("1");
                        else if(pwdv&&stat==3)
				pw.println("0");
			else
				if(pwdv&&stat==0)
					pw.println("1");
				else
					if(pwdv&&stat==2)
						pw.println("2");
					else
						if(pwdv&&stat==1)
							{
								ses.setAttribute("userid", userid);
								ses.setAttribute("pwd", pwd);
								ses.setAttribute("maxptr", "0");
								pw.print(3);
							}
							else
							{
								
								String x;
								try
								{
								x=(String) ses.getAttribute("maxptr");
								int a=Integer.parseInt(x);
								a++;
								ses.setAttribute("maxptr", String.valueOf(a));
								if(a<=3)
								pw.println("4");
								else
                                                                {	
                                                                        PreparedStatement pstmt1= con.prepareStatement("update rad_login set accountstat=2 where userid=?");
                                                                        pstmt1.setInt(1,Integer.parseInt(userid));
                                                                        pstmt1.execute();
                                                                        pw.println("5");
                                                                        
                                                                }
                                                                        
								}
								catch(Exception e)
								{
									ses.setAttribute("maxptr", "1");
									pw.println("4");
								}
							}
			
			
			con.close();
			
		}
		catch(Exception e)
		{
			pw.println("6");
		}
		
		
               
	}

}

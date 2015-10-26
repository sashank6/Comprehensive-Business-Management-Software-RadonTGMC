package sashank;


import java.sql.*;

public class Sashank
{
    int makerct=0;
    String[] maker=new String[10000];
    public int makerctc()
    {
        return makerct;
    }
    public String popmaker()
    {
        makerct--;
        return maker[makerct];
    }
	public Connection getCon() throws SQLException
	{
		DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
		Connection con=DriverManager.getConnection("jdbc:db2://127.0.0.1:50000/radone","Aneesh","blah");
		return con;
	}
	
	public String sendMessage(String from,String to,String Subject,String message)
	{
		
		try
		{
		Connection con=getCon();
		PreparedStatement pstmt=con.prepareStatement("select count(*) from rad_login where userid=?");
		pstmt.setLong(1, Long.parseLong(to));
		ResultSet rs=pstmt.executeQuery();
		int a=-1;
		while(rs.next())
		{
			a=rs.getInt(1);
		}
		pstmt.close();
		rs.close();
		if(a==1)
		{
			String act = null;
			pstmt=con.prepareStatement("select userclass from rad_login where userid=?");
			pstmt.setLong(1, Long.parseLong(from));
			rs=pstmt.executeQuery();
			int userclass=-1;
			while(rs.next())
				userclass=rs.getInt(1);
			rs.close();
			pstmt.close();
			if(userclass==0)
				act="Admin/"+from;
			else
				if(userclass==1)
				{
					act="HR/"+from;
				}
				else
					if(userclass==6)
						act="LM/"+from;
					else
						if(userclass==5||userclass==4)
						{
							pstmt=con.prepareStatement("select fname,lname from rad_employ where userid=?");
							pstmt.setLong(1, Long.parseLong(from));
							String fname = null,lname = null;
							rs=pstmt.executeQuery();
							while(rs.next())
							{
								fname=rs.getString(1);
								lname=rs.getString(2);
							}
							pstmt.close();
							rs.close();
							act=fname+" "+lname+"/"+from;
							
						}
						else
							if(userclass==2)
							{
								pstmt=con.prepareStatement("select cname from rad_retailer where userid=?");
								pstmt.setLong(1, Long.parseLong(from));
								String cname = null,lname = null;
								rs=pstmt.executeQuery();
								while(rs.next())
								{
									cname=rs.getString(1);
									
								}
								pstmt.close();
								rs.close();
								act=cname+"/"+from;
							}
							else
								if(userclass==3)
								{
									pstmt=con.prepareStatement("select cname from rad_vendor where userid=?");
									pstmt.setLong(1, Long.parseLong(from));
									String cname = null,lname = null;
									rs=pstmt.executeQuery();
									while(rs.next())
									{
										cname=rs.getString(1);
										
									}
									pstmt.close();
									rs.close();
									act=cname+"/"+from;
								}
			String tac = null;
			pstmt=con.prepareStatement("select userclass from rad_login where userid=?");
			pstmt.setLong(1, Long.parseLong(to));
			rs=pstmt.executeQuery();
			userclass=-1;
			while(rs.next())
				userclass=rs.getInt(1);
			rs.close();
			pstmt.close();
			
			if(userclass==0)
				tac="Admin/"+to;
			else
				if(userclass==1)
				{
					tac="HR/"+to;
				}
				else
					if(userclass==6)
						tac="LM/"+to;
					else
						if(userclass==5||userclass==4)
						{
							pstmt=con.prepareStatement("select fname,lname from rad_employ where userid=?");
							pstmt.setLong(1, Long.parseLong(from));
							String fname = null,lname = null;
							rs=pstmt.executeQuery();
							while(rs.next())
							{
								fname=rs.getString(1);
								lname=rs.getString(2);
							}
							pstmt.close();
							rs.close();
							tac=fname+" "+lname+"/"+to;
							
						}
						else
							if(userclass==2)
							{
								
								pstmt=con.prepareStatement("select cname from rad_retailer where userid=?");
								pstmt.setLong(1, Long.parseLong(to));
								String cname = null,lname = null;
								rs=pstmt.executeQuery();
								while(rs.next())
								{
									cname=rs.getString(1);
									
									
								}
								pstmt.close();
								rs.close();
								
								tac=cname+"/"+to;
							}
							else
								if(userclass==3)
								{
									pstmt=con.prepareStatement("select cname from rad_vendor where userid=?");
									pstmt.setLong(1, Long.parseLong(from));
									String cname = null,lname = null;
									rs=pstmt.executeQuery();
									while(rs.next())
									{
										cname=rs.getString(1);
										
									}
									pstmt.close();
									rs.close();
									tac=cname+"/"+to;
								}
			
			pstmt=con.prepareStatement("select rad_message_id.nextval from sysibm.sysdummy1");
			rs=pstmt.executeQuery();
			long mid_id=-1;
			while(rs.next())
				mid_id=rs.getLong(1);
			pstmt.close();
			rs.close();
			String tablename="m_"+to+"_messages";
			pstmt=con.prepareStatement("insert into "+tablename+" values(?,?,?,?,current_timestamp,?,?)");
			pstmt.setLong(1, mid_id);
			pstmt.setString(2, act);
			pstmt.setString(3,Subject);
			pstmt.setString(4, message);
			pstmt.setInt(5, 1);
			pstmt.setInt(6, 0);
			pstmt.execute();
			pstmt.close();
			tablename="m_"+from+"_messages";
			pstmt=con.prepareStatement("insert into "+tablename+" values(?,?,?,?,current_timestamp,?,?)");
			pstmt.setLong(1, mid_id);
			pstmt.setString(2,tac);
			pstmt.setString(3,Subject);
			pstmt.setString(4, message);
			pstmt.setInt(5, 2);
			pstmt.setInt(6, 1);
			pstmt.execute();
			pstmt.close();
		    con.close();
			return "Message Sent Successfully";
			
		}
		else
			return "User Doesn't Exist";
		
		}
		catch(Exception e)
		{
			
			e.printStackTrace();
			return "Something went wrong please Try again";
		}
		
		
		
	}
     public boolean verifymake(String data)
    {
        for(int i=0;i<makerct;i++)
        {
            if(data.equalsIgnoreCase(maker[i]))
                return true;
        }
        return false;
                
    }
     public void pushmaker(String data)
     {
         maker[makerct]=data;
         makerct++;
     }
	public static void main(String[] args)
	{
		Sashank obj=new Sashank();
		System.out.println(obj.sendMessage("666", "300010", "Subject", "message"));
		
	}
	
	
	
	

}

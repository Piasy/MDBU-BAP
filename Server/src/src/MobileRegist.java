package src;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;


public class MobileRegist extends ActionSupport 
{
	private static final long serialVersionUID = 1L;
	String url = "jdbc:mysql://localhost/MyPro";
    String user = "root";
    String pwd = "x2011011238@";   
    private String username, password, password2, email;
    
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}  
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}  
    
	public void write() throws IOException
	{
		HttpServletRequest request = ServletActionContext.getRequest(); 
		request.setCharacterEncoding("UTF-8");   
		HttpServletResponse response=ServletActionContext.getResponse();
		/*
		 * 在调用getWriter之前未设置编码(既调用setContentType或者setCharacterEncoding方法设置编码),
		 * HttpServletResponse则会返回一个用默认的编码(既ISO-8859-1)编码的PrintWriter实例。这样就会
		 * 造成中文乱码。而且设置编码时必须在调用getWriter之前设置,不然是无效的。
		 * */
		response.setContentType("text/html;charset=utf-8");
		//response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if (username == null || password == null || password2 == null || email == null || username.equals("") || password.equals("") || password2.equals("") || email.equals(""))
		{
			String jsonString="{\"response\":\"fail\"}";
			out.println(jsonString);
			out.flush();
			out.close();
			return;
		}
		String mpassword = password;
		String mpassword2 = password2;
		if (!mpassword.equals(mpassword2))
		{
			String jsonString="{\"response\":\"TwoPasswordDifferentError\"}";
			out.println(jsonString);
			out.flush();
			out.close();
		}
		try 
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			try
			{
				Connection conn = DriverManager.getConnection(url, user, pwd);
				
				if (!conn.isClosed())
				{
					Statement stmt = conn.createStatement();
					String  sql = "CREATE TABLE IF NOT EXISTS Users (" +
					  			  "UserID int NOT NULL AUTO_INCREMENT, " + 
					  			  "PRIMARY KEY(UserID), " + 
					  			  "username varchar(14), " +
					  			  "password varchar(34), " + 
					  			  "email varchar(32), " + 
					  			  "name varchar(64), " +
					  			  "sex varchar(16), " +
					  			  "birthday varchar(14), " +
					  			  "phone varchar(14), " +
					  			  "QQ varchar(14), " +
					  			  "renrenpage varchar(128), " +
					  			  "photo varchar(256))";
					stmt.execute(sql);  
					java.sql.DatabaseMetaData dmd = conn.getMetaData(); 
					ResultSet rst = dmd.getTables(null, "root", "Users", (new String[]{"TABLE"}));
					while(!rst.next())
					{
						stmt.execute(sql); 
						dmd = conn.getMetaData(); 
						rst = dmd.getTables(null, "root", "Users", (new String[]{"TABLE"}));
					}
					
					ResultSet result = stmt.executeQuery("SELECT * FROM Users");
					boolean exist = false;
					while (result.next())
					{
						String uname = result.getString("username");
						String em = result.getString("email");
						if(uname.equals(username))
						{
							exist = true;
							String jsonString="{\"response\":\"AccountExsistError\"}";
							out.println(jsonString);
							out.flush();
							out.close();
						}
						if (em.equals(email))
						{
							exist = true;
							String jsonString="{\"response\":\"EmailExsistError\"}";
							out.println(jsonString);
							out.flush();
							out.close();
						}
					}
					if (!exist)
					{
						//System.out.println(mpassword);
						sql = "INSERT INTO Users (username, password, email) VALUES ('" + username + "', '" + mpassword + "', '" + email + "')";
						stmt.execute(sql);
						sql = "SELECT * FROM Users WHERE username='" + username + "'";
						ResultSet rse = stmt.executeQuery(sql);
						while (!rse.next())
						{
							sql = "INSERT INTO Users (username, password, email) VALUES ('" + username + "', '" + mpassword + "', '" + email + "')";
							stmt.execute(sql);
							sql = "SELECT * FROM Users WHERE username='" + username + "'";
							rse = stmt.executeQuery(sql);
						}
						
						sql = "CREATE TABLE " + username + " (" +
						  	  "UserID int NOT NULL AUTO_INCREMENT, " + 
						  	  "PRIMARY KEY(UserID), " + 
						  	  "isshow char(2), " +
							  "time varchar(20), " +
							  "longitude varchar(20), " +
							  "latitude varchar(20), " +
							  "wifiname varchar(32), " +
							  "wifisig varchar(10), " +
							  "macAddr varchar(32), " +
							  "photo varchar(256), " +
							  "voice varchar(256), " +
							  "text varchar(1220), " +
							  "temp varchar(16), " +
							  "PM25 varchar(6), " +
							  "humidity varchar(8))";
						stmt.execute(sql);
						rst = dmd.getTables(null, "root", username, (new String[]{"TABLE"}));
						while(!rst.next())
						{
							stmt.execute(sql); 
							dmd = conn.getMetaData(); 
							rst = dmd.getTables(null, "root", username, (new String[]{"TABLE"}));
						}
						String jsonString="{\"response\":\"success\"}";
						out.println(jsonString);
						out.flush();
						out.close();
					}
				}
				else
				{
					String jsonString="{\"response\":\"error\"}";
					out.println(jsonString);
					out.flush();
					out.close();
				}
			} 
			catch (SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} 
		catch (InstantiationException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		catch (IllegalAccessException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

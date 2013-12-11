package src;

import javax.servlet.http.*;

import org.apache.struts2.ServletActionContext;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import net.sf.json.JSONObject;

import com.opensymphony.xwork2.ActionSupport;

public class MobileLogin extends ActionSupport
{
	private static final long serialVersionUID = 1L;
	String url = "jdbc:mysql://localhost/MyPro";
    String user = "root";
    String pwd = "x2011011238@";   
    private String username, password;
 
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
    
	public void write() throws IOException
	{
		System.out.println("get in log");
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
		if (username == null || password == null || username.equals("") || password.equals(""))
		{
			String jsonString="{\"response\":\"fail\"}";
			out.println(jsonString);
			out.flush();
			out.close();
			return;
		}
    	String mpassword = password;
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
					ResultSet result = stmt.executeQuery("SELECT * FROM Users WHERE username='" + username + "'");
					if (result.next())
					{
						if (result.getString("password").equals(mpassword))
						{
							Map<String, Object> jsonMap = new HashMap<String, Object>();  
							jsonMap.put("response", "success"); 
							Map<String, Map<String, String>> contentMap = new HashMap<String, Map<String, String>>();  
							ResultSet RS_result = stmt.executeQuery("SELECT * FROM " + username + " WHERE isshow = '1' ORDER BY `time` ASC");
							while (RS_result.next())
							{
								Map<String, String> entry = new HashMap<String, String>();  
								entry.put("longitude", RS_result.getString("longitude"));
								entry.put("latitude", RS_result.getString("latitude"));
								entry.put("wifiname", RS_result.getString("wifiname"));
								entry.put("wifisig", RS_result.getString("wifisig"));
								entry.put("macAddr", RS_result.getString("macAddr"));
								entry.put("photo", "http://166.111.134.196/uploadres/" + RS_result.getString("photo"));
								entry.put("voice", "http://166.111.134.196/uploadres/" + RS_result.getString("voice"));
								entry.put("text", RS_result.getString("text"));
								entry.put("temp", RS_result.getString("temp"));
								entry.put("PM25", RS_result.getString("PM25"));
								entry.put("humidity", RS_result.getString("humidity"));
								contentMap.put(RS_result.getString("time"), entry);
							}
							jsonMap.put("content", contentMap); 
							JSONObject jsonObject = JSONObject.fromObject(jsonMap); 
							out.println(jsonObject);
							out.flush();
							out.close();
						}
						else
						{
							String jsonString="{\"response\":\"PasswordError\"}";
							out.println(jsonString);
							out.flush();
							out.close();
						}
					}
					else
					{
						String jsonString="{\"response\":\"AccountNotExsist\"}";
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

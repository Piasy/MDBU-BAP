package src;

import javax.servlet.http.*;

import org.apache.struts2.ServletActionContext;

import java.sql.*;

import com.opensymphony.xwork2.ActionSupport;

public class Login extends ActionSupport
{
	private static final long serialVersionUID = 1L;
	String url = "jdbc:mysql://localhost/MyPro";
    String user = "root";
    String pwd = "passwd";   
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
    
    public String execute() 
    {
    	HttpSession session = ServletActionContext.getRequest().getSession();
    	if (username == null || password == null || username.equals("") || password.equals(""))
		{
			session.setAttribute("username", "empty"); 
			return "signin";
		}
		String mpassword = MD5Encode.MD5(password);
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
							session.setAttribute("username", username); 
							return "index";
						}
						else
						{
							session.setAttribute("username", "passworderror"); 
							return "signin";
						}
					}
					else
					{
						session.setAttribute("username", "noaccount"); 
						return "signin";
					}
				}
				else
				{
					session.setAttribute("username", "error"); 
					return "signin";
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
		return "signin";
    }
}

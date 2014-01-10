package src;

import java.sql.*;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class RestoreRecord extends ActionSupport 
{
	private static final long serialVersionUID = 1L;
	String url = "jdbc:mysql://localhost/MyPro";
    String user = "root";
    String pwd = "passwd";  
    private String[] check;
    private String page;
    
	public String[] getCheck() {
		return check;
	}

	public void setCheck(String[] check) {
		this.check = check;
	}
	
	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page; 
	}

    public String execute() 
    {
    	HttpSession session = ServletActionContext.getRequest().getSession();
		try 
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			try
			{
				Connection conn = DriverManager.getConnection(url, user, pwd);
				if (!conn.isClosed())
				{
					for (int i = 0; i < check.length; i ++)
					{
						Statement stmt = conn.createStatement();
						String  sql = "UPDATE " + session.getAttribute("username") + " SET isshow = '1' WHERE UserID = '" + check[i] + "'";
						System.out.println(sql);
						stmt.execute(sql);
					}
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
		return "manage";
    }
}

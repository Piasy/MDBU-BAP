package src;

import java.sql.*;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class EditText extends ActionSupport 
{
	private static final long serialVersionUID = 1L;
	String url = "jdbc:mysql://localhost/MyPro";
    String user = "root";
    String pwd = "passwd";  
    private String text;
    private String type, pageIndex;
    private String redirectURL;
    
    public String getRedirectURL() 
    { 
    	return this.redirectURL; 
    }
    public void setRedirectURL(String redirectURL) 
    { 
    	this.redirectURL= redirectURL; 
    }
    
	public String getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(String pageIndex) {
		this.pageIndex = pageIndex; 
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type; 
	}
	
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text; 
	}

    public String execute() 
    {
    	HttpSession session = ServletActionContext.getRequest().getSession();
    	//System.out.println("In " + session.getAttribute("id") + "***" + text);
		try 
		{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			try
			{
				Connection conn = DriverManager.getConnection(url, user, pwd);
				if (!conn.isClosed())
				{
					text = text.replaceAll("\"", "&quot;");
					Statement stmt = conn.createStatement();
					String  sql = "UPDATE " + session.getAttribute("username") + " SET text = '" + text + "' WHERE UserID = '" + session.getAttribute("id") + "'";
					stmt.execute(sql);
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
		String ret = (String) session.getAttribute("target");
		if (ret.equals("index"))
		{
			type = (String) session.getAttribute("type");
			pageIndex = (String) session.getAttribute("pageIndex");
			redirectURL = "index.jsp?type=" + type + "&pageIndex=" + pageIndex;
		}
		if (ret.equals("manage"))
		{
			pageIndex = (String) session.getAttribute("pageIndex");
			redirectURL = "manage.jsp?pageIndex=" + pageIndex;
		}
		return ret;
    }
}

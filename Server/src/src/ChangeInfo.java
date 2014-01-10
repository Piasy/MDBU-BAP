package src;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class ChangeInfo extends ActionSupport 
{
	private static final long serialVersionUID = 1L;
	String url = "jdbc:mysql://localhost/MyPro";
    String user = "root";
    String pwd = "passwd";  
    private String name = "", sex = "", birthday = "", phone = "", QQ = "", email = "", renrenpage = "";
    
	public String getName() {
		return name;
	}

	public void setName(String name) {
		try
        {
	        this.name = new String(name.getBytes("ISO-8859-1"),"utf-8");
        } 
		catch (UnsupportedEncodingException e)
        {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
        } 
	}
	
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		try
        {
	        this.sex = new String(sex.getBytes("ISO-8859-1"),"utf-8");
        } 
		catch (UnsupportedEncodingException e)
        {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
        }
	}
	
	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getQQ() {
		return QQ;
	}

	public void setQQ(String QQ) {
		this.QQ = QQ;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getRenrenpage() {
		return renrenpage;
	}

	public void setRenrenpage(String renrenpage) {
		this.renrenpage = renrenpage;
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
					Statement stmt = conn.createStatement();
					String  sql = "UPDATE Users SET name = '" + name + "', sex = '" + sex + "', birthday = '" + birthday + 
								  "', phone = '" + phone + "', QQ = '" + QQ + "', email = '" + email + 
								  "', renrenpage = '" + renrenpage + "' WHERE username = '" + session.getAttribute("username") + "'";
					//System.out.println(sql);
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
		return "setinfo";
    }
}

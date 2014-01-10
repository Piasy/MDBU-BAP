package src;

import java.io.*;
import java.sql.*;

//import javax.activation.DataSource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class UploadImg extends ActionSupport 
{
	private static final long serialVersionUID = 1L;
	String url = "jdbc:mysql://localhost/MyPro";
    String user = "root";
    String pwd = "passwd";  
    private File photo;
    private String photoContentType, photoFileName;
    
	public File getPhoto() {
		return photo;
	}

	public void setPhoto(File photo) {
		this.photo = photo;
	}

	public String getPhotoContentType() {
		return photoContentType;
	}

	public void setPhotoContentType(String photoContentType) {
		this.photoContentType = photoContentType;
	}

	public String getPhotoFileName() {
		return photoFileName;
	}

	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
	}
    
    public String execute() 
    {
    	HttpSession session = ServletActionContext.getRequest().getSession();
    	if (photo == null)
    		return "setinfo";
    	String uploadPath = "/var/www/uploadres";
		String photoName = session.getAttribute("username") + this.getPhotoFileName();
		File toPhotoFile = new File(new File(uploadPath), photoName);
		
		if (!toPhotoFile.getParentFile().exists())
    		toPhotoFile.getParentFile().mkdirs();
    	try
        {
	        FileUtils.copyFile(photo, toPhotoFile);
		    try
	        {
	            Class.forName("com.mysql.jdbc.Driver").newInstance();
	    	    try
	            {
		        	Connection conn = DriverManager.getConnection(url, user, pwd);
					Statement stmt = conn.createStatement();
					String  sql = "UPDATE Users SET photo = '" + photoName + "' WHERE username='" + session.getAttribute("username") + "'";
					stmt.execute(sql); 
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
    	catch (IOException e)
        {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
        } 
    	return "setinfo";
    }
	
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		HttpSession session= request.getSession(); 
		request.setCharacterEncoding("UTF-8");   
		
		BufferedInputStream fileIn = new BufferedInputStream(request.getInputStream());
	    String fn = request.getParameter("fileName");
	    byte[] buf = new byte[1024];
	    File file = new File("/var/www/uploadres/" + session.getAttribute("username") + fn);
		BufferedOutputStream fileOut = new BufferedOutputStream(new FileOutputStream(file));
		while (true) 
	    {
	    	int bytesIn = fileIn.read(buf, 0, 1024);
	    	if (bytesIn == -1) 
	    		break;
	    	else 
	    		fileOut.write(buf, 0, bytesIn);
	    }
	   
	    fileOut.flush();
	    fileOut.close();
	    System.out.println(file.getAbsolutePath());
	    
	    try
        {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
    	    try
            {
	        	Connection conn = DriverManager.getConnection(url, user, pwd);
				Statement stmt = conn.createStatement();
				String  sql = "UPDATE Users SET photo = '" + file.getName() + "' WHERE username='" + session.getAttribute("username") + "'";
				stmt.execute(sql); 
//				PreparedStatement pstmt = conn.prepareStatement("UPDATE Users SET photo = ? WHERE username='" + session.getAttribute("username") + "'");
//				InputStream inp = new BufferedInputStream(new FileInputStream(file));
//				pstmt.setBinaryStream(1, inp, (int)file.length());
//				pstmt.executeUpdate();
				System.out.println("OK");
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
package FileUpload;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class FileUpload extends ActionSupport
{

	private static final long serialVersionUID = 1L;
	private String username, password, time, longitude, latitude, wifiname, wifisig, macAddr, text, temp, PM25, humidity;
	private File photo, voice;
	private String photoContentType, voiceContentType;
	private String photoFileName, voiceFileName;
	String url = "jdbc:mysql://localhost/MyPro";
    String user = "root";
    String pwd = "passwd";    
    
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
	
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	
	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	
	public String getWifiname() {
		return wifiname;
	}

	public void setWifiname(String wifiname) {
		this.wifiname = wifiname;
	}
	
	public String getWifisig() {
		return wifisig;
	}

	public void setWifisig(String wifisig) {
		this.wifisig = wifisig;
	}
	
	public String getMacAddr() {
		return macAddr;
	}

	public void setMacAddr(String macAddr) {
		this.macAddr = macAddr;
	}
	
	
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}
	
	public String getPM25() {
		return PM25;
	}

	public void setPM25(String PM25) {
		this.PM25 = PM25;
	}
	
	public String getHumidity() {
		return humidity;
	}

	public void setHumidity(String humidity) {
		this.humidity = humidity;
	}
    
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
	
	public File getVoice() {
		return voice;
	}

	public void setVoice(File voice) {
		this.voice = voice;
	}

	public String getVoiceContentType() {
		return voiceContentType;
	}

	public void setVoiceContentType(String voiceContentType) {
		this.voiceContentType = voiceContentType;
	}

	public String getVoiceFileName() {
		return voiceFileName;
	}

	public void setVoiceFileName(String voiceFileName) {
		this.voiceFileName = voiceFileName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public void write() throws IOException{
		System.out.println("get in upload");
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
		//JSON在传递过程中是普通字符串形式传递的，这里简单拼接一个做测试
		
		if (username == null || password == null || photo == null || voice == null)
		{
			System.out.println("username == null");
			String jsonString="{\"response\":\"fail\"}";
			out.println(jsonString);
			out.flush();
			out.close();
			return;
		}
		
		System.out.println("ok0");
		String uploadPath = "/var/www/uploadres";
		
//		String photoName = "photo";
//		String voiceName = "voice";
		String photoName = this.getUsername() + this.getTime() + this.getPhotoFileName();
		String voiceName = this.getUsername() + this.getTime() + this.getVoiceFileName();
		photoName = photoName.replace(' ', '_');
		voiceName = voiceName.replace(' ', '_');
		File toPhotoFile = new File(new File(uploadPath), photoName);
		File toVoiceFile = new File(new File(uploadPath), voiceName);
    	
		System.out.println("ok1");
		if (!toPhotoFile.getParentFile().exists())
    		toPhotoFile.getParentFile().mkdirs();
    	FileUtils.copyFile(photo, toPhotoFile); 
    	
    	System.out.println("ok2");
    	
    	if (!toVoiceFile.getParentFile().exists())
    		toVoiceFile.getParentFile().mkdirs();
    	FileUtils.copyFile(voice, toVoiceFile); 
    	
    	System.out.println("ok3");
	    try
        {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
    	    try
            {
	        	Connection conn = DriverManager.getConnection(url, user, pwd);
				Statement stmt = conn.createStatement();
				//System.out.println(text);
				//System.out.println(new String(text.getBytes("ISO-8859-1"),"utf-8"));
				ResultSet result = stmt.executeQuery("SELECT * FROM Users WHERE username='" + username + "'");
				
				System.out.println("ok4");
				
				if (result.next())
				{
					System.out.println("ok5");
					System.out.println(password);
					if (result.getString("password").equals(password))
					{
						text = text.replaceAll("\"", "&quot;");
						String  sql = "INSERT INTO " + username + 
						    		  " (isshow, time, longitude, latitude, wifiname, wifisig, macAddr, " + 
						    		  "photo, voice, text, temp, PM25, humidity) VALUES ('1', '" + time + "', '" + 
						    		  longitude + "', '" + latitude + "', '" + wifiname + "', '" + wifisig + "', '" +
						    		  macAddr + "', '" + photoName + "', '" + voiceName + "', '" + text + "', '" + 
						    		  temp + "', '" + PM25 + "', '"+ humidity + "')";
						stmt.execute(sql); 
						String jsonString="{\"response\":\"success\"}";
						out.println(jsonString);
						out.flush();
						out.close();
						System.out.println("success");
					}
					else
					{
						String jsonString="{\"response\":\"fail\"}";
						out.println(jsonString);
						out.flush();
						out.close();
						System.out.println("fail");
					}
				}
				else
				{
					System.out.println("error");
					String jsonString="{\"response\":\"fail\"}";
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

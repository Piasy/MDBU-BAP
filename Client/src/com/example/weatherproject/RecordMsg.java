package com.example.weatherproject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Calendar;
import java.util.Locale;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONException;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.provider.MediaStore;
import android.text.format.DateFormat;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class RecordMsg extends Activity {
	
	TextView gpsText;
	TextView tempText;
	TextView wifiText;
	TextView timeText;
	Button photoButton;
	ImageView imageView;
	Button sendButton;
	Thread thread;
	final static int MSG_SUCCESS = 1;
	final static int MSG_FAILURE = 0;
	final static String EXTRA_MESSAGE5 = "Message Success5";
	StringBuilder sb2 = new StringBuilder();
	final String imageStore = "/sdcard/myImage/";
	String imageName;
	File imageFile;
	String longtitude;
	String latitude;
	String username = "";
	String password = "";
	String serverAddr = "";
	String wifiname;
	String wifisig;
	String macAddr;
	String humidity;
	String temperature;
	String condition;
	String jsonReturn;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.record_msg);
		
		gpsText = (TextView)findViewById(R.id.gpsText);
		tempText = (TextView)findViewById(R.id.tempText);
		wifiText = (TextView)findViewById(R.id.wifiText);
		timeText = (TextView)findViewById(R.id.timeText);
		photoButton = (Button)findViewById(R.id.photoButton);
		imageView = (ImageView)findViewById(R.id.imageView1);
		sendButton = (Button)findViewById(R.id.sendButton);
		thread = null;
		
		Intent intent = getIntent();
        String[] message = intent.getStringArrayExtra(MainActivity.EXTRA_MESSAGE);
        
        gpsText.setText("北纬" + message[0] + ", " + "东经" + message[1]);
        tempText.setText(message[2]);
        wifiText.setText(message[3]);
        timeText.setText(message[4]);
        
        latitude = message[0];
        longtitude = message[1];
        temperature = message[2];
        wifiname = message[3];
        wifisig = message[4];
        macAddr = message[5];
        humidity = message[6];
        condition = message[7];
        
        
        LoginActivity2 login = new LoginActivity2();
        username = login.mEmail;
        password = login.mPassword;
        serverAddr = login.mServer;
        
        System.out.println(username);
        System.out.println(password);
        System.out.println(serverAddr);
        
        
        photoButton.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
				startActivityForResult(intent, 1);
			}
		});
        
        sendButton.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (thread == null){
					Runnable r = new MySendThread();
					thread = new Thread(r);
					thread.start();
					
					while (thread.isAlive())
					{
						
					}
					finish();
					Intent intent = new Intent(RecordMsg.this, ReviewActivity.class);
					intent.putExtra(EXTRA_MESSAGE5, jsonReturn);
					startActivity(intent);
				}
			}
		});
	}
	
	class MySendThread implements Runnable
	{
		@Override
		public void run()
		{	
			System.out.println("time");
			HttpClient httpclient = new DefaultHttpClient();
			HttpPost httppost = new HttpPost("http://166.111.134.196:9090/MyPro/fileUpload");
			System.out.println("time");
			MultipartEntity entity = new MultipartEntity();
			 
			try
			{
				System.out.println("time");
				entity.addPart("username", new StringBody("lql11"));
				entity.addPart("password", new StringBody("1C63129AE9DB9C60C3E8AA94D3E00495"));
				entity.addPart("time", new StringBody(timeText.getText().toString()));
				entity.addPart("longtitude", new StringBody(longtitude));
				entity.addPart("latitude", new StringBody(latitude));
				entity.addPart("wifiname", new StringBody(wifiname));
//				entity.addPart("wifisig", new StringBody(wifisig));
//				entity.addPart("macAddr", new StringBody(macAddr));
				entity.addPart("photo", new FileBody(new File(imageName)));
				entity.addPart("voice", new FileBody(new File(imageName)));
				entity.addPart("text", new StringBody(condition));
				entity.addPart("temp", new StringBody(temperature));
//				entity.addPart("PM25", new StringBody(""));
//				entity.addPart("humidity", new StringBody(humidity));
				System.out.println("time");
				httppost.setEntity(entity);
				HttpResponse response = httpclient.execute(httppost);
				
				int statusCode = response.getStatusLine().getStatusCode();
				if (1 == 1)//statusCode == HttpStatus.SC_OK)
				{
					HttpEntity resEntity = response.getEntity();
					System.out.println("time");
					BufferedReader reader = new BufferedReader(new InputStreamReader(
				            response.getEntity().getContent(), "UTF-8"));
					System.out.println("time");
					String sResponse;
					System.out.println("time");
				    StringBuilder s = new StringBuilder();
				    System.out.println("time");
				    while ((sResponse = reader.readLine()) != null) 
				    {
				    	s = s.append(sResponse);
				    }
				    System.out.println("time");
				    jsonReturn = s.toString();
				    System.out.println(jsonReturn);
				}
			} catch (Exception e){
			}
			
		}
	}
	
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {  
        // TODO Auto-generated method stub  
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) {  
            String sdStatus = Environment.getExternalStorageState();  
            if (!sdStatus.equals(Environment.MEDIA_MOUNTED)) { // 检测sd是否可用  
                Log.i("TestFile",  
                        "SD card is not avaiable/writeable right now.");  
                return;  
            }  
            String name = new DateFormat().format("yyyyMMdd_hhmmss",Calendar.getInstance(Locale.CHINA)) + ".jpg";     
            Toast.makeText(this, name, Toast.LENGTH_LONG).show();  
            Bundle bundle = data.getExtras();  
            Bitmap bitmap = (Bitmap) bundle.get("data");// 获取相机返回的数据，并转换为Bitmap图片格式  
          
            FileOutputStream b = null;
           
            File file = new File(imageStore);
            file.mkdirs();// 创建文件夹  
            imageName = imageStore+name;
            
            try {  
                b = new FileOutputStream(imageName);
                bitmap.compress(Bitmap.CompressFormat.JPEG, 100, b);// 把数据写入文件  
            } catch (FileNotFoundException e) {
                e.printStackTrace();  
            } finally {  
                try {  
                    b.flush();  
                    b.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }
            imageView.setImageBitmap(bitmap);// 将图片显示在ImageView里 
            
        }  
    }
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}
}

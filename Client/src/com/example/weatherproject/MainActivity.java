package com.example.weatherproject;
import com.tencent.mm.sdk.openapi.IWXAPI;
import com.tencent.mm.sdk.openapi.SendMessageToWX;
import com.tencent.mm.sdk.openapi.WXAPIFactory;
import com.tencent.mm.sdk.openapi.WXMediaMessage;
import com.tencent.mm.sdk.openapi.WXTextObject;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.text.format.Time;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.TextView;

public class MainActivity extends Activity {
	
	TextView tempText;
	TextView windText;
	Button recordButton;
	final static String EXTRA_MESSAGE = "Message Success";
	final static String EXTRA_MESSAGE2 = "Message Success2";
	final int MSG_SUCCESS = 1;
	String wifiname;
	String temperature;
	String longtitude = "162";
	String latitude = "40";
	String currentTime;
	String wifisig;
	String macAddr;
	String condition;
	String humidity;
	Button loginButton;
	StringBuffer page = new StringBuffer();
	Thread wThread = null;
	Pattern pWind = Pattern.compile("<yweather:wind\\s+?chill=\"(.+?)\"\\s+?direction=\".+?\"\\s+?speed=\"(.+?)\"");
	Pattern pAtmos = Pattern.compile("<yweather:atmosphere\\s+?humidity=\"(.+?)\"\\s+?visibility=\".+\"" +
			"\\s+?pressure=\"(.+?)\"");
	Pattern pCondition = Pattern.compile("<yweather:condition\\s+?text=\"(.+?)\"\\s+?code=\".+?\"\\s+?temp=\"(.+?)\"" +
			"\\s+?date=\"(.+?)\"");
	
	Button shareButton;
	CheckBox checkbox;
	Button reviewButton;
	
	private static final String APP_ID = "wx6b8424a3552e2044";
	IWXAPI api;
	private void regToWx(){
		api = WXAPIFactory.createWXAPI(this, APP_ID, true);
		api.registerApp(APP_ID);
	}
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		tempText = (TextView)findViewById(R.id.tempText);
		windText = (TextView)findViewById(R.id.windText);
		
		recordButton = (Button)findViewById(R.id.recordButton);
		loginButton = (Button)findViewById(R.id.loginButton);
		shareButton = (Button)findViewById(R.id.button1);
		reviewButton = (Button)findViewById(R.id.reviewButton);
		checkbox = (CheckBox)findViewById(R.id.checkBox1);
		checkbox.setChecked(false);
		
		regToWx();
		
	    Time time = new Time();
	    time.setToNow();
	    int year = time.year;
        int month = time.month+1;
        int day = time.monthDay;
        int hour = time.hour;
        int minute = time.minute;
        int sec = time.second;
        currentTime = "" + year + "-" + month + "-" + day + " " + hour + ":" + minute;
        
        recordButton.setEnabled(false);
        
        if (wThread == null){
        	wThread = new Thread(wRunnable);
        	wThread.start();
        }
        wifiInfo();
        
        LoginActivity2 login = new LoginActivity2();
        AlarmManager am = (AlarmManager)getSystemService(ALARM_SERVICE);
             
        PendingIntent pi = PendingIntent.getBroadcast(this, 0, new Intent(this, ActionBroadCast.class), Intent.FLAG_ACTIVITY_NEW_TASK);  
        long now = System.currentTimeMillis();
        int timepart = 1800*1000;
        if (login.flashTime.equals("30 min")){
            timepart = 1800*1000;
        }
        else if (login.flashTime.equals("60 min")){
        	 timepart = 3600*1000;
        }
        else if (login.flashTime.equals("2  hour")){
        	 timepart = 7200*1000;
        }
        am.setInexactRepeating(AlarmManager.RTC_WAKEUP, now, timepart, pi);  
        
		recordButton.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				Intent intent = new Intent();
				intent.setClass(MainActivity.this, RecordMsg.class);
				String[] message = {latitude, longtitude, temperature, wifiname, currentTime, wifisig, macAddr, humidity
						, condition};
				intent.putExtra(EXTRA_MESSAGE, message);
				startActivity(intent);
				
			}
		});
		
		loginButton.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(MainActivity.this, LoginActivity2.class);
				startActivity(intent);
				recordButton.setEnabled(true);
			}
		});
		
		shareButton.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
		
				String text = tempText.getText().toString()+" "+windText.getText().toString();
				if (text == null || text.length() == 0) {
					return;
				}
				
				// 初始化一个WXTextObject对象
				WXTextObject textObj = new WXTextObject();
				textObj.text = text;

				// 用WXTextObject对象初始化一个WXMediaMessage对象
				WXMediaMessage msg = new WXMediaMessage();
				msg.mediaObject = textObj;
				// 发送文本类型的消息时，title字段不起作用
				// msg.title = "Will be ignored";
				msg.description = text;

				// 构造一个Req
				SendMessageToWX.Req req = new SendMessageToWX.Req();
				req.transaction = buildTransaction("text"); // transaction字段用于唯一标识一个请求
				req.message = msg;
				req.scene = checkbox.isChecked()? SendMessageToWX.Req.WXSceneTimeline: SendMessageToWX.Req.WXSceneSession;
				
				// 调用api接口发送数据到微信
				api.sendReq(req);
				finish();
			}
		});
		
		reviewButton.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(MainActivity.this, ReviewActivity.class);
				startActivity(intent);
			}
		});
	}
	
	class ActionBroadCast extends BroadcastReceiver{
		
		@Override
		public void onReceive(Context arg0, Intent arg1) {
			// TODO Auto-generated method stub
			System.out.println("ActionBroadCast");
		}
		
	}
		
	private String buildTransaction(final String type) {
		return (type == null) ? String.valueOf(System.currentTimeMillis()) : type + System.currentTimeMillis();
	}
	
	private void wifiInfo(){
		WifiManager wifi = (WifiManager) getSystemService(Context.WIFI_SERVICE);  
		WifiInfo info = wifi.getConnectionInfo();  
		String maxText = info.getMacAddress();  
		String ipText = intToIp(info.getIpAddress());  
		String status = "";  
		if (wifi.getWifiState() == WifiManager.WIFI_STATE_ENABLED)  
		{  
			status = "WIFI_STATE_ENABLED";  
		}  
		String ssid = info.getSSID();  
		int networkID = info.getNetworkId();  
		int speed = info.getLinkSpeed();  
//		return "mac：" + maxText + "\n\r"  
//		+ "ip：" + ipText + "\n\r"  
//		+ "wifi status :" + status + "\n\r"  
//		+ "net work id :" + networkID + "\n\r"  
		//+ " speed:" + speed + "\n\r"  
		wifiname = ssid;
		wifisig = ""+speed;
		macAddr = maxText;
	}
	private String intToIp(int ip)  
	{  
		return (ip & 0xFF) + "." + ((ip >> 8) & 0xFF) + "." + ((ip >> 16) & 0xFF) + "."  
		+ ((ip >> 24) & 0xFF); 
	}
	
	Handler whandler = new Handler(){
		public void handleMessage(Message msg){
			switch(msg.what){
			case MSG_SUCCESS:
				System.out.println("fucj");
				windText.setText(((String[])msg.obj)[0]);
				tempText.setText(((String[])msg.obj)[1]);
				break;
			}
			
		}
	};
	
	Runnable wRunnable = new Runnable(){
		@Override
		public void run() {
			// TODO Auto-generated method stub
			InputStream inputStream = null;
			try {
				URL url = new URL("http://xml.weather.yahoo.com/forecastrss?w=2151330&u=c");
				inputStream = url.openStream();
				BufferedReader br = new BufferedReader(new InputStreamReader(inputStream, "GBK"));
				String line;
				while ((line = br.readLine()) != null){
					page.append(line+"\n");
				}
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				try {
			        inputStream.close();
				} catch (IOException ioe) {
			        // nothing to see here
				}
			}
			String s = page.toString();
			Matcher mWind = pWind.matcher(s);
			String wind = "冷风级别：";
			if (mWind.find()){
				wind += mWind.group(1);
				wind += "  风速：";
				wind += mWind.group(2);
				wind += " km/h";
			}
			
			Matcher mHumidity = pAtmos.matcher(s);
			if (mHumidity.find()){
				humidity = mHumidity.group(1);
			}
			
			String temp = "温度：";
			Matcher mTemp = pCondition.matcher(s);
			if (mTemp.find()){
				temp += mTemp.group(2);
				temperature = mTemp.group(2);// + "°C";
				condition = mTemp.group(1);
			}
			temp += "°C";
			System.out.println(wind);
			System.out.println(temp);
			String msg[] = {wind, temp};
			whandler.obtainMessage(MSG_SUCCESS, msg).sendToTarget();
//			try{
//				Thread.sleep(5000);
//			}
//			catch(InterruptedException e){}
		}
	};

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}

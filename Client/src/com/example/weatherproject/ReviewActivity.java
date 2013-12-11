package com.example.weatherproject;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.app.Activity;
import android.app.ListActivity;
import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

public class ReviewActivity extends Activity {
	
	List<Map<String, Object>> list;
	EditText displayView;
	String context;
	Thread thread;
	String time;
	String temp;
	String latitude;
	String longitude;
	String photo;
	String wifiname;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_review);
		
		Intent intent = getIntent();
		//context = intent.getStringExtra(RecordMsg.EXTRA_MESSAGE5);

		if (thread == null){
			thread = new Thread(r);
			thread.start();
		}

	}
	
	Handler h = new Handler(){
		public void handleMessage(Message msg){
			list = new ArrayList<Map<String, Object>>();
			List<String> l = new ArrayList<String>();
			Map<String, Object> map;
			try {
	            JSONObject jsonObj = new JSONObject(context);
	            JSONObject contentObj = jsonObj.getJSONObject("content");
	            JSONArray timeArray = contentObj.names();
	            for (int i = 0; i < timeArray.length(); i ++){
	            	String timeline = (String)timeArray.get(i);
	            	JSONObject jo = contentObj.getJSONObject(timeline);
	            	map = new HashMap<String, Object>();
	            	map.put("title", time);
	            	String s = "temp:" + jo.getString("temp") + ", Î³¶È" + jo.getString("latitude") + ", ¾­¶È" +
	            			jo.getString("longitude") + ", WIFI:" + jo.getString("wifiname");
	            	map.put("info", s);
	            	list.add(map);
	            	l.add(time);
	            }
	        } catch (JSONException e) {
	            e.printStackTrace();
	        }
		    ListView listView = (ListView)findViewById(R.id.listView1);
		    listView.setAdapter(new ArrayAdapter<String>(ReviewActivity.this, android.R.layout.simple_expandable_list_item_1,l));
		}
	};
	
	Runnable r = new Runnable(){

		@Override
		public void run() {
			// TODO Auto-generated method stub
			HttpClient httpclient = new DefaultHttpClient();
			HttpPost httppost = new HttpPost("http://166.111.134.196:9090/MyPro/MobileLogin");
			MultipartEntity entity = new MultipartEntity();
			try
			{
				entity.addPart("username", new StringBody("lql11"));
				entity.addPart("password", new StringBody("1C63129AE9DB9C60C3E8AA94D3E00495"));
				httppost.setEntity(entity);
				HttpResponse response = httpclient.execute(httppost);
				
				int statusCode = response.getStatusLine().getStatusCode();
				if (1 == 1)//statusCode == HttpStatus.SC_OK)
				{
					HttpEntity resEntity = response.getEntity();
					BufferedReader reader = new BufferedReader(new InputStreamReader(
				            response.getEntity().getContent(), "UTF-8"));
					String sResponse;
				    StringBuilder s = new StringBuilder();
				    while ((sResponse = reader.readLine()) != null) 
				    {
				    	s = s.append(sResponse);
				    }
				    context = s.toString();
				    //System.out.println(context);
				}
			} catch (Exception e){
			}
			h.obtainMessage().sendToTarget();
		}
	};

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.review, menu);
		return true;
	}

}

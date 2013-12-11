<%@ page language="java" 
	import="java.sql.*, java.net.URLEncoder, java.net.*, java.io.*, java.util.*, net.sf.json.*" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
int pageIndex = 1;
if (request.getParameter("pageIndex") != null)
{
	try
	{
		pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
	}
	catch(Exception e)
	{
		pageIndex = 1; 
	}
}
Connection conn; 
String strConn; 
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
conn= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/MyPro","root","x2011011238@"); 
if(conn==null)
{
	System.out.println("get Conn Error");
}
Statement stmt=conn.createStatement();

ResultSet RS_result=null;
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="bootstrap-3.0.0/assets/ico/faviconx.png">
	
    <title>Welcome to MDBU BAP</title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.0.0/dist/css/bootstrap.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="bootstrap-3.0.0/assets/js/html5shiv.js"></script>
      <script src="bootstrap-3.0.0/assets/js/respond.min.js"></script>
    <![endif]-->
	<script src=" http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=3168919025" type="text/javascript" charset="utf-8"></script>
	<style type="text/css">
	    .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
	    .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>    
    <!-- Custom styles for this template -->
    <link href="carousel.css" rel="stylesheet">
  </head>
<!-- NAVBAR
================================================== -->
  <body>
    <div class="navbar-wrapper">
      <div class="container">

        <div class="navbar navbar-inverse navbar-static-top">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="index.jsp">MDBU BAP</a>
            </div>
            <%
				String username = (String) session.getAttribute("username");
				String hint = "登录";
				String signinherf = "signin.jsp";
				String signupherf = "regist.jsp";
				String infoherf = "signin.jsp";
				String staticsherf = "signin.jsp";
				String manageherf = "signin.jsp";
				if (username != null)
				{
					hint = username;
					signinherf = "index.jsp";
					signupherf = "";
					infoherf = "setinfo.jsp";
					staticsherf = "show.jsp";
					manageherf = "manage.jsp";
				}
			%>
            <div class="navbar-collapse collapse">
              <ul class="nav navbar-nav">
              	<li class="dropdown">
                  <a href="index.jsp" class="dropdown-toggle" data-toggle="dropdown">首页 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                  	<li><a href="index.jsp">全部</a></li>
                    <li><a href="index.jsp?type=photo">照片</a></li>
                    <li><a href="index.jsp?type=text">状态</a></li>
                    <li><a href="index.jsp?type=voice">语音</a></li>
                    <li><a href="index.jsp?type=map">地图</a></li>
                   </ul>
                </li>
                <li><a href=<%=manageherf%>>数据管理</a></li>
                <li><a href=<%=staticsherf%>>信息统计</a></li>
                <li><a href=<%=infoherf%>>个人信息管理</a></li>
                <li><a href="about.jsp">关于我们</a></li>
                <li><a href=<%=signinherf%>><%=hint%></a></li>
                <li><a href="Signout">退出</a></li>
                <li><a href=<%=signupherf%>>注册</a></li>
              </ul>
            </div>
          </div>
        </div>

      </div>
    </div>


    <!-- Marketing messaging and featurettes
    ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->

<br/><br/><br/>

    <div class="container marketing">
		<%
		if (username != null)
		{
			RS_result = stmt.executeQuery("SELECT * FROM " + username + " WHERE isshow = '1' ORDER BY `time` ASC");
			if(RS_result.next())
			{
				int pagesNum, recordsPerPage = 4, recordsNum;
				RS_result.last();
				recordsNum = RS_result.getRow();
				
				if (recordsNum % recordsPerPage == 0)
					pagesNum = recordsNum / recordsPerPage;
				else
					pagesNum = recordsNum / recordsPerPage + 1;
				
				if ((pageIndex - 1) * recordsPerPage == 0)
		       		RS_result.beforeFirst();
		       	else
		       		RS_result.absolute((pageIndex - 1) * recordsPerPage);
				for (int i = 0; i < recordsPerPage / 2; i ++)
				{
					if (RS_result.next())
					{		
						String time = "Your time";
						String longitude = "Your longitude";
						String latitude = "Your latitude";
						time = RS_result.getString("time");
						longitude = RS_result.getString("longitude");
						latitude = RS_result.getString("latitude");
						String queryUrl = "http://api.map.baidu.com/place/v2/search?&query=%E7%BE%8E%E9%A3%9F&location=" + latitude + "," + longitude + "&radius=2000&output=json&ak=2b76b68a7e0b9b917886e29287a0672c";
						
						URL url = new URL(queryUrl);
				        InputStream in = url.openStream();
				        BufferedReader bufferin = new BufferedReader(new InputStreamReader(in, "utf-8"));
				        String jsonStr = "";
				        String s = null;
				        while((s = bufferin.readLine()) != null)
				        {
				        	jsonStr += s;
				        }
				        bufferin.close();
				        
				        JSONObject jsonObject = JSONObject.fromObject(jsonStr); 
				        Map resmap = new HashMap(); 
				        for(Iterator iter = jsonObject.keys(); iter.hasNext();)
				        { 
				            String key = (String)iter.next(); 
				            resmap.put(key, jsonObject.get(key)); 
				        } 
				        JSONArray content = JSONArray.fromObject(resmap.get("results")); 
			%>
	      <!-- START THE FEATURETTES -->
	      
	      <div class="row featurette">

	        <div class="col-md-7">
	          <h2 class="featurette-heading"><%=time %> </h2>
	          <h4><span class="text-muted"><%= "@(" + longitude + ", " + latitude + ")"%></span></h4>
	           <h3>附近美食推荐</h3>	   
			</div>

	        <div class="col-md-5">
	        <p>
	        <%
	        for(int j = 0; j < content.size(); j++)
	        {
	        	JSONObject contentObject = content.getJSONObject(j); 
	        %>
	        	名称： <%=contentObject.get("name") %><br/>
	        <%
	        	if (contentObject.get("telephone") != null)
	        	{
	        %>
	        	电话： <%=contentObject.get("telephone") %><br/>
	        <%
	        	}
	        %>
	        	地址： <%=contentObject.get("address") %><br/><br/>
	        <%
	        	if (5 <= j)
	        		break;
	        }	        
	        %>
			</p>
	        </div>
	      </div>
	      <hr class="featurette-divider">
			<%
						}
						if(RS_result.next())
						{
							String time = "Your time";
							String longitude = "Your longitude";
							String latitude = "Your latitude";
							time = RS_result.getString("time");
							longitude = RS_result.getString("longitude");
							latitude = RS_result.getString("latitude");
							String queryUrl = "http://api.map.baidu.com/place/v2/search?&query=%E7%BE%8E%E9%A3%9F&location=" + latitude + "," + longitude + "&radius=2000&output=json&ak=2b76b68a7e0b9b917886e29287a0672c";
							
							URL url = new URL(queryUrl);
					        InputStream in = url.openStream();
					        BufferedReader bufferin = new BufferedReader(new InputStreamReader(in, "utf-8"));
					        String jsonStr = "";
					        String s = null;
					        while((s = bufferin.readLine()) != null)
					        {
					        	jsonStr += s;
					        }
					        bufferin.close();
					        
					        JSONObject jsonObject = JSONObject.fromObject(jsonStr); 
					        Map resmap = new HashMap(); 
					        for(Iterator iter = jsonObject.keys(); iter.hasNext();)
					        { 
					            String key = (String)iter.next(); 
					            resmap.put(key, jsonObject.get(key)); 
					        } 
					        JSONArray content = JSONArray.fromObject(resmap.get("results")); 
			%>
	      <div class="row featurette">
	        <div class="col-md-5">
	        <p>
	        <%
	        for(int j = 0; j < content.size(); j++)
	        {
	        	JSONObject contentObject = content.getJSONObject(j); 
	        %>
	        	名称： <%=contentObject.get("name") %><br/>
	        <%
	        	if (contentObject.get("telephone") != null)
	        	{
	        %>
	        	电话： <%=contentObject.get("telephone") %><br/>
	        <%
	        	}
	        %>
	        	地址： <%=contentObject.get("address") %><br/><br/>
	        <%
	        	if (5 <= j)
	        		break;
	        }	        
	        %>
			</p>            
	        </div>
	        <div class="col-md-7">
	          <h2 class="featurette-heading"><%=time %></h2>
		      <h4><span class="text-muted"><%= "@(" + longitude + ", " + latitude + ")"%></span></h4>
		      	 <h3>附近美食推荐</h3>	               
	        </div>
	      </div>
	  	<hr class="featurette-divider">
			<%
						}
					}
			%>
					<div>
			<%
					if (pageIndex != 1)
					{
			%>
					    <a href = "<%="show.jsp?pageIndex=1"%>" class="btn btn-primary" >首页</a>
						<a href = "<%="show.jsp?pageIndex=" + (pageIndex - 1)%>" class="btn btn-primary" >上一页</a>
			<%
					}
					if (pageIndex != pagesNum)
					{
			%>
			
						<a class="btn btn-primary" href = "<%="show.jsp?pageIndex=" + (pageIndex + 1)%>">下一页</a>
						<a class="btn btn-primary" href = "<%="show.jsp?pageIndex=" + pagesNum%>">末页</a>
			<%
					}
			%>
					</div>
			<%
			}				
		}
	%>
    

      <!-- /END THE FEATURETTES -->

	
	<br/>
	<br/>
	<br/>
	<br/>
      <!-- FOOTER -->
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2013 Piasy@ NeverStop &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a></p>
      </footer>

    </div><!-- /.container -->

<!-- 	<script> -->
<!-- 	function signout() -->
<!-- 	{ -->
<!-- 		session.setAttribute("username", null);  -->
<!-- 	} -->
<!-- 	</script> -->
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="bootstrap-3.0.0/assets/js/jquery.js"></script>
    <script src="bootstrap-3.0.0/dist/js/bootstrap.min.js"></script>
    <script src="bootstrap-3.0.0/assets/js/holder.js"></script>
  </body>
</html>

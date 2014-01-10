<%@ page language="java" import="java.sql.*, java.net.URLEncoder" contentType="text/html; charset=UTF-8"
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
conn= java.sql.DriverManager.getConnection("jdbc:mysql://localhost/MyPro","root","passwd"); 
if(conn==null)
{
	System.out.println("get Conn Error");
}
Statement stmt=conn.createStatement();

ResultSet RS_result=null;
String type = request.getParameter("type");
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


    <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
        <div class="item active">
<!--           <img src="data:image/png;base64," data-src="holder.js/100%x500/auto/#777:#7a7a7a/text:Hello" alt="First slide"> -->
          <div class="container">
            <div class="carousel-caption">
              <h1>MDBU BAP</h1>
             <p>Mobile Device Based User Behaviors Analysing Platform(基于移动设备的用户行为记录分析平台)，是清华大学计算机系许斌老师讲授的Java课程大作业，学生们为了完成这个巨大的项目日以继夜地进行艰苦地开发工作，经过无数个昼夜的奋战，终于完成了这个项目！</p>
              <p><a class="btn btn-large btn-primary" href="res/projectDetail.pdf">了解更多</a></p>
            </div>
          </div>
        </div>
        <div class="item">
<!--           <img src="data:image/png;base64," data-src="holder.js/100%x500/auto/#777:#7a7a7a/text:First slide" alt="Second slide"> -->
          <div class="container">
            <div class="carousel-caption">
              <h1>开发进度</h1>
              <p>目前开发进度已接近尾声，基本功能已经完成，只有一些细节方面仍需调整与完善。我们将尽快完成余下的工作。</p>
              <p><a class="btn btn-large btn-primary" href="#">加入我们</a></p>
            </div>
          </div>
        </div>
        <div class="item">
<!--           <img src="data:image/png;base64," data-src="holder.js/100%x500/auto/#777:#7a7a7a/text:First slide" alt="Third slide"> -->
          <div class="container">
            <div class="carousel-caption">
              <h1>Bug report</h1>
              <p>发送状态的内容尚不能有中文引号，否则将导致发送失败。</p>
              <p><a class="btn btn-large btn-primary" href="#">了解更多</a></p>
            </div>
          </div>
        </div>
      </div>
      <a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
      <a class="right carousel-control" href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
    </div><!-- /.carousel -->



    <!-- Marketing messaging and featurettes
    ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->



    <div class="container marketing">
		<%
		if (username != null)
		{
			RS_result = stmt.executeQuery("SELECT * FROM " + username + " WHERE isshow = '1' ORDER BY `time` ASC");
			if (!((type != null) && (type.equals("map"))))
			{
				if(RS_result.next())
				{
					int pagesNum, recordsPerPage = 6, recordsNum;
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
							String text = "Your text";
							String photo_src = "\"data:image/png;base64,\"";
							String photo_data = "\"holder.js/500x500/auto\"";
							String voice = "";
							time = RS_result.getString("time");
							longitude = RS_result.getString("longitude");
							latitude = RS_result.getString("latitude");
							text = RS_result.getString("text");
							String photo = RS_result.getString("photo");
							String v = RS_result.getString("voice");
							if (v != null)
								voice = "\"http://166.111.134.196/uploadres/" + v + "\"";
							
							if (photo == null)
							{
								photo_data = "\"holder.js/500x500/auto\"";	
								photo_src = "\"data:image/png;base64,\"";
							}	
							else
							{
								photo_src = "\"http://166.111.134.196/uploadres/" + photo + "\"";
								photo_data = photo_src;
							}
							String shareHref = "http://widget.renren.com/dialog/share?resourceUrl=" + URLEncoder.encode("http://166.111.134.196:9090/MyPro/index.jsp","UTF-8") + "&title=" + URLEncoder.encode("Welcome to MDBU BAP","UTF-8");
			%>
	      <!-- START THE FEATURETTES -->
	      
	      <div class="row featurette">

	        <div class="col-md-7">
	          <h2 class="featurette-heading"><%=time %> </h2>
	          <h4><span class="text-muted"><%= "@(" + longitude + ", " + latitude + ")"%></span></h4>
					      <%
				        if (!((type != null) && (type.equals("voice"))))
				        {
				         %>
				          <a href = <%=shareHref%> target = "_blank">
				          <img alt="分享到人人" src="res/share.png"></a>  				          
				         <%
				        }					      
					      if (type == null || type.equals("") || type.equals("null") || type.equals("text"))
					      {
					    	  shareHref += "&description=" + URLEncoder.encode(text,"UTF-8");
					      %>
					          <p class="lead"><%=text %></p>
					      <%
					      		if (text.equals(""))
					      		{
					      			session.setAttribute("id", RS_result.getString("UserID"));
					      			session.setAttribute("target", "index");
					      			session.setAttribute("type", type);
					      			session.setAttribute("pageIndex", pageIndex + "");
					      %>
	      <form action="editText" method="post" accept-charset="ISO-8859-1">
	      	   <textarea class="form-control" rows="3" name = "text"></textarea>
	      	   <br/><input type="submit" class="btn btn-primary" value="编辑">
	      </form>
					      <%
					      		}
						  }
					      %>
	        </div>

	        <div class="col-md-5">
					        <%
					        if (type == null || type.equals("") || type.equals("null") || type.equals("photo"))
					        {
					        	shareHref += "&pic=" + URLEncoder.encode("http://166.111.134.196/uploadres/" + photo,"UTF-8");
					        %>
	          <img class="featurette-image img-thumbnail" src=<%=photo_src %> data-src=<%=photo_data %> alt="Generic placeholder image">
					        <%
					        }
					        if (type == null || type.equals("") || type.equals("null") || type.equals("voice"))
					        {
					        %>
	          <p>
	          <audio controls>
			  <source src=<%=voice %> type="audio/mpeg">
			  Your browser does not support the audio element.
			  </audio>
	          </p>
	          
					         <%
					         }
					         %>
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
							String text = "Your text";
							String photo_src = "\"data:image/png;base64,\"";
							String photo_data = "\"holder.js/500x500/auto\"";
							String voice = "";
							time = RS_result.getString("time");
							longitude = RS_result.getString("longitude");
							latitude = RS_result.getString("latitude");
							text = RS_result.getString("text");
							String photo = RS_result.getString("photo");
							String v = RS_result.getString("voice");
							if (v != null)
								voice = "\"http://166.111.134.196/uploadres/" + v + "\"";
							if (photo == null)
							{
								photo_data = "\"holder.js/500x500/auto\"";	
								photo_src = "\"data:image/png;base64,\"";
							}	
							else
							{
								photo_src = "\"http://166.111.134.196/uploadres/" + photo + "\"";
								photo_data = photo_src;
							}
							String shareHref = "http://widget.renren.com/dialog/share?resourceUrl=" + URLEncoder.encode("http://166.111.134.196:9090/MyPro/index.jsp","UTF-8") + "&title=" + URLEncoder.encode("Welcome to MDBU BAP","UTF-8");
			%>
	      <div class="row featurette">
	        <div class="col-md-5">
					        <%if (type == null || type.equals("") || type.equals("null") || type.equals("photo"))
					        {
					        	shareHref += "&pic=" + URLEncoder.encode("http://166.111.134.196/uploadres/" + photo,"UTF-8");
					        %>       
					          <img class="featurette-image img-thumbnail" src=<%=photo_src %> data-src=<%=photo_data %> alt="Generic placeholder image">
					        <%
					        }
					        if (type == null || type.equals("") || type.equals("null") || type.equals("voice"))
					        {
					        %>          
						          <p>
						          <audio controls>
								  <source src=<%=voice %> type="audio/mpeg">
								  Your browser does not support the audio element.
								  </audio>
						          </p>     
					         <%
					         }
					         %>               
	        </div>
	        <div class="col-md-7">
	          <h2 class="featurette-heading"><%=time %></h2>
		      <h4><span class="text-muted"><%= "@(" + longitude + ", " + latitude + ")"%></span></h4>
		      <%
					        if (!((type != null) && (type.equals("voice"))))
					        {
					         %>
					          <a href = <%=shareHref%> target = "_blank">
					          <img alt="分享到人人" src="res/share.png"></a>  
					         <%
					        }
						      if (type == null || type.equals("") || type.equals("null") || type.equals("text"))
						      {
						    	  shareHref += "&description=" + URLEncoder.encode(text,"UTF-8");
						      %>          
					          <p class="lead"><%=text %></p>
						      <%
						      		if (text.equals(""))
						      		{
						      			session.setAttribute("id", RS_result.getString("UserID"));
						      			session.setAttribute("target", "index");
						      			session.setAttribute("type", type);
						      			session.setAttribute("pageIndex", pageIndex + "");
						      %>
		      <form action="editText" method="post" accept-charset="ISO-8859-1">
		      	   <textarea class="form-control" rows="3" name = "text"></textarea>
		      	   <br/><input type="submit" class="btn btn-primary" value="编辑">
		      </form>
						      <%
						      		}
							  }
							  %>				               
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
					    <a href = "<%="index.jsp?type=" + type + "&pageIndex=1"%>" class="btn btn-primary" >首页</a>
						<a href = "<%="index.jsp?type=" + type + "&pageIndex=" + (pageIndex - 1)%>" class="btn btn-primary" >上一页</a>
			<%
					}
					if (pageIndex != pagesNum)
					{
			%>
			
						<a class="btn btn-primary" href = "<%="index.jsp?type=" + type + "&pageIndex=" + (pageIndex + 1)%>">下一页</a>
						<a class="btn btn-primary" href = "<%="index.jsp?type=" + type + "&pageIndex=" + pagesNum%>">末页</a>
			<%
					}
			%>
					</div>
			<%
				}				
			}
			else
			{
			%>
			<div style="width:697px;height:550px;border:#ccc solid 1px;" id="dituContent"></div>
			<script type="text/javascript">
			    //创建和初始化地图函数：
			    function initMap(){
			        createMap();//创建地图
			        setMapEvent();//设置地图事件
			        addMapControl();//向地图添加控件
			        addMarker();//向地图中添加marker
			        addPolyline();//向地图中添加线
			        addRemark();//向地图中添加文字标注
			    }
			    
			    //创建地图函数：
			    function createMap(){
			        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
			        var point = new BMap.Point(109.14481,36.708877);//定义一个中心点坐标
			        map.centerAndZoom(point,5);//设定地图的中心点和坐标并将地图显示在地图容器中
			        window.map = map;//将map变量存储在全局
			    }
			    
			    //地图事件设置函数：
			    function setMapEvent(){
			        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
			        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
			        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
			        map.enableKeyboard();//启用键盘上下左右键移动地图
			    }
			    
			    //地图控件添加函数：
			    function addMapControl(){
			        //向地图中添加缩放控件
				var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
				map.addControl(ctrl_nav);
			        //向地图中添加缩略图控件
				var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
				map.addControl(ctrl_ove);
			        //向地图中添加比例尺控件
				var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
				map.addControl(ctrl_sca);
			    }
			    <%
				    String markerArrStr = "";
				    String linePointsStr = "";
				    while (RS_result.next())
				    {
						String time = "Title";
						String longitude = "";
						String latitude = "";
						String text = "Content";
						if (RS_result.getString("time") != null)
							time = new String(RS_result.getString("time").getBytes("ISO-8859-1"),"utf-8");
						if (RS_result.getString("longitude") != null)
							longitude = new String(RS_result.getString("longitude").getBytes("ISO-8859-1"),"utf-8");
						if (RS_result.getString("latitude") != null)
							latitude = new String(RS_result.getString("latitude").getBytes("ISO-8859-1"),"utf-8");
						if (RS_result.getString("text") != null)
							text = new String(RS_result.getString("text").getBytes("ISO-8859-1"),"utf-8");
						markerArrStr += "{title:\"" + time + "\",content:\"" + text + "\",point:\"" + longitude + "|" + latitude + "\",isOpen:0,icon:{w:21,h:21,l:0,t:0,x:6,lb:5}},";
						linePointsStr += "\"" + longitude + "|" + latitude + "\",";
					}
					markerArrStr = markerArrStr.substring(0, markerArrStr.length() - 1);	
					linePointsStr = linePointsStr.substring(0, linePointsStr.length() - 1);
			    %>
			    //标注点数组
			    var markerArr = [<%=markerArrStr%>];
			    //创建marker
			    function addMarker(){
			        for(var i=0;i<markerArr.length;i++){
			            var json = markerArr[i];
			            var p0 = json.point.split("|")[0];
			            var p1 = json.point.split("|")[1];
			            var point = new BMap.Point(p0,p1);
						var iconImg = createIcon(json.icon);
			            var marker = new BMap.Marker(point,{icon:iconImg});
						var iw = createInfoWindow(i);
						var label = new BMap.Label(json.title,{"offset":new BMap.Size(json.icon.lb-json.icon.x+10,-20)});
						marker.setLabel(label);
			            map.addOverlay(marker);
			            label.setStyle({
			                        borderColor:"#808080",
			                        color:"#333",
			                        cursor:"pointer"
			            });
						
						(function(){
							var index = i;
							var _iw = createInfoWindow(i);
							var _marker = marker;
							_marker.addEventListener("click",function(){
							    this.openInfoWindow(_iw);
						    });
						    _iw.addEventListener("open",function(){
							    _marker.getLabel().hide();
						    })
						    _iw.addEventListener("close",function(){
							    _marker.getLabel().show();
						    })
							label.addEventListener("click",function(){
							    _marker.openInfoWindow(_iw);
						    })
							if(!!json.isOpen){
								label.hide();
								_marker.openInfoWindow(_iw);
							}
						})()
			        }
			    }
			    //创建InfoWindow
			    function createInfoWindow(i){
			        var json = markerArr[i];
			        var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.title + "'>" + json.title + "</b><div class='iw_poi_content'>"+json.content+"</div>");
			        return iw;
			    }
			    //创建一个Icon
			    function createIcon(json){
			        var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w,json.h),{imageOffset: new BMap.Size(-json.l,-json.t),infoWindowOffset:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)})
			        return icon;
			    }
			//标注线数组
			    var plPoints = [{style:"solid",weight:4,color:"#00f",opacity:0.6,points:[<%=linePointsStr%>]}
					 ];
			    //向地图中添加线函数
			    function addPolyline(){
					for(var i=0;i<plPoints.length;i++){
						var json = plPoints[i];
						var points = [];
						for(var j=0;j<json.points.length;j++){
							var p1 = json.points[j].split("|")[0];
							var p2 = json.points[j].split("|")[1];
							points.push(new BMap.Point(p1,p2));
						}
						var line = new BMap.Polyline(points,{strokeStyle:json.style,strokeWeight:json.weight,strokeColor:json.color,strokeOpacity:json.opacity});
						map.addOverlay(line);
					}
				}
			    
			    initMap();//创建和初始化地图
			</script>  			
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

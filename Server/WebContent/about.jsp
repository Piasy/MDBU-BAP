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
              <p>目前开发进度已接近尾声，基本功能已经完成，只有一些细节方面仍需调整与完善。</p>
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

      <!-- Three columns of text below the carousel -->
      <div class="row">
        <div class="col-lg-4">          
          <h2>Directed By</h2>
          <p>Lelo, my greatest director.</p>
          <img class="featurette-image img-thumbnail" src="res/directedby.jpg" data-src="res/directedby.jpg" alt="Generic placeholder image">
          <p><a class="btn btn-default" target = "_blank" href="http://www.renren.com/390852135/profile">View details &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">          
          <h2>Powered By</h2>
          <p>Piasy, the developer of this site.</p>
          <img class="featurette-image img-thumbnail" src="res/poweredby.jpg" data-src="res/poweredby.jpg" alt="Generic placeholder image">
          <p><a class="btn btn-default" target = "_blank" href="http://www.renren.com/405433679/profile">View details &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
          
          <h2>Co-worker</h2>
          <p>David, the developer of our mobile program.</p>
     	  <img class="featurette-image img-thumbnail" src="res/coworker.jpg" data-src="res/coworker.jpg" alt="Generic placeholder image">
          <p><a class="btn btn-default" target = "_blank" href="http://www.renren.com/269356676/profile">View details &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
      </div><!-- /.row -->
      </div>

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

<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
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
                <li><a href="index.jsp">首页</a></li> 
                <li><a href=<%=manageherf%>>数据管理</a></li>
                <li><a href=<%=staticsherf%>>信息统计</a></li>
                <li><a href=<%=infoherf%>>个人信息管理</a></li>
                <li><a href="about.jsp">关于我们</a></li>
                <li><a href=<%=signinherf%>><%=hint%></a></li>
                <li><a href="/MyPro/Signout">退出</a></li>
                <li><a href=<%=signupherf%>>注册</a></li>
<!--       class="active"           <li class="dropdown"> -->
<!--                   <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a> -->
<!--                   <ul class="dropdown-menu"> -->
<!--                     <li><a href="#">退出</a></li> -->
<!--                     <li><a href="#">注册</a></li> -->
<!--                     <li><a href="#">Something else here</a></li> -->
<!--                     <li class="divider"></li> -->
<!--                     <li class="dropdown-header">Nav header</li> -->
<!--                     <li><a href="#">Separated link</a></li> -->
<!--                     <li><a href="#">One more separated link</a></li> -->
<!--                   </ul> -->
<!--                 </li> -->
              </ul>
            </div>
          </div>
        </div>
	</div>
	<%
	RS_result = stmt.executeQuery("SELECT * FROM Users WHERE username='" + session.getAttribute("username") + "'");
	if(RS_result.next())
	{
		String name = RS_result.getString("name");
		if (name == null)
			name = "";
		String sex = RS_result.getString("sex");
		if (sex == null)
			sex = "";
		String birthday = RS_result.getString("birthday");
		if (birthday == null)
			birthday = "";
		String phone = RS_result.getString("phone");
		if (phone == null)
			phone = "";
		String QQ = RS_result.getString("QQ");
		if (QQ == null)
			QQ = "";
		String email = RS_result.getString("email");
		if (email == null)
			email = "";
		String renrenpage = RS_result.getString("renrenpage");
		if (renrenpage == null)
			renrenpage = "";
		
		String photo = RS_result.getString("photo");
		String photo_src;
		String photo_data;
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
	%>

	
    </div>
	<div class="container marketing">
      <div class="row featurette">
        <div class="col-md-7">
          <h6 class="featurette-heading">Hello <%=session.getAttribute("username") %> :)</h6>
				  <table class="table table-bordered">
				    <tr>
					<td>姓名</td>
					<td> <%=name%> </td>
					</tr>
					<tr>
					<td>性别</td>
					<td> <%=sex%> </td>
					</tr>
					<tr>
					<td>生日</td>
					<td> <%=birthday%> </td>
					</tr>
					<tr>
					<td>电话</td>
					<td> <%=phone%> </td>
					</tr>
					<tr>
					<td>QQ</td>
					<td> <%=QQ%> </td>
					</tr>
					<tr>
					<td>邮箱</td>
					<td> <%=email%> </td>
					</tr>
					<tr>
					<td>人人主页</td>
					<td> <%=renrenpage%> </td>
					</tr>																				
				 </table>
				 
				 <form action="changeinfo.jsp">
				 	<button type="submit" class="btn btn-primary" >修改信息</button>
				 </form>
				 <br/>
				 <form method="post" enctype="multipart/form-data" action="UploadImg">
					<p>选择图片: <input type="file" class="btn btn-primary" name="photo" /></p>
					<p><input type="submit" class="btn btn-primary" value="修改头像" /></p>
				 </form>
		</div>
        <div class="col-md-5">
          <img class="featurette-image img-thumbnail" src=<%=photo_src%> data-src=<%=photo_data%> alt="Generic placeholder image">
        </div>
      </div>
    </div>
	<%
	}
	RS_result.close();
	stmt.close();
	conn.close();
	%>

    <!-- Bootstrap core JavaScript "data:image/png;base64,"
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="bootstrap-3.0.0/assets/js/jquery.js"></script>
    <script src="bootstrap-3.0.0/dist/js/bootstrap.min.js"></script>
    <script src="bootstrap-3.0.0/assets/js/holder.js"></script>
  </body>
</html>

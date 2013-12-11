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
	%>

    <div class="container marketing">
    <div class="row featurette">
    <div class="col-md-7">
    <br/><br/>
	<form action = "ChangeInfo" method="post" accept-charset="ISO-8859-1">
	    <div class="form-group">
  			<label for="name">姓名</label>
  			<input type="text" class="form-control" id="name" name ="name" value=<%=name%>>
		</div>
		<div class="form-group">
  			<label for="sex">性别</label>
  			<input type="text" class="form-control" id="sex" name="sex" value=<%=sex%>>
		</div>
		<div class="form-group">
  			<label for="birthday">生日(格式: 20080808)</label>
  			<input type="text" class="form-control" id="birthday" name="birthday" value=<%=birthday%>>
		</div>
		<div class="form-group">
  			<label for="phone">电话</label>
  			<input type="text" class="form-control" id="phone" name ="phone" value=<%=phone%>>
		</div>
		<div class="form-group">
  			<label for="QQ">QQ</label>
  			<input type="text" class="form-control" id="QQ" name ="QQ" value=<%=QQ%>>
		</div>
		<div class="form-group">
  			<label for="email">邮箱</label>
  			<input type="text" class="form-control" id="email" name ="email" value=<%=email%>>
		</div>
		<div class="form-group">
  			<label for="renrenpage">人人主页</label>
  			<input type="text" class="form-control" id="renrenpage" name ="renrenpage" value=<%=renrenpage%>>
		</div>						
		<button class="btn btn-lg btn-primary btn-block" type="submit">确认修改</button>
	</form>
	</div> 
	</div>
	</div>
	<%
	}
	RS_result.close();
	stmt.close();
	conn.close();
	%>

    
    


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="bootstrap-3.0.0/assets/js/jquery.js"></script>
    <script src="bootstrap-3.0.0/dist/js/bootstrap.min.js"></script>
    <script src="bootstrap-3.0.0/assets/js/holder.js"></script>
  </body>
</html>

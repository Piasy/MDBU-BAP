<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
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
RS_result = stmt.executeQuery("SELECT * FROM Users WHERE username='" + session.getAttribute("username") + "'");
String photo_src = "\"data:image/png;base64,\"";
String photo_data = "\"holder.js/500x500/auto\"";	
if(RS_result.next())
{
	String photo = RS_result.getString("photo");
	if (photo != null)
	{
		photo_src = "\"http://166.111.134.196/uploadres/" + photo + "\"";
		photo_data = photo_src;
	}
}
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
              </ul>
            </div>
          </div>
        </div>
	</div>
	<%
	if (session.getAttribute("username") != null)
	{
	%>

	
    </div>
	<div class="container marketing">
      <div class="row featurette">
        <div class="col-md-12">
          <h6 class="featurette-heading">Hello <%=session.getAttribute("username") %> :)</h6>
          <%
          String bd = "", ed = "";
          if (request.getParameter("beginDate") != null)
        	  bd = request.getParameter("beginDate");
          if (request.getParameter("endDate") != null)
        	  ed = request.getParameter("endDate");
          %>
          	  <form method="post">
          	    <label for = "label1">格式：2013-09-08  </label>
          	    <label for = "beginDate" id = "label1">开始日期：</label>
          	  	<input type = "text" id = "beginDate" name="beginDate" size="10" maxlength="10" value = "<%=bd%>"/>
          	    <label for = "endDate">开始日期：</label>
          	  	<input type = "text" id = "endDate" name="endDate" size="10" maxlength="10" value = "<%=ed%>"/>    
          	  	<input type = "submit" class="btn btn-primary" value = "查询"/>      	  	
          	  </form>
          	  <br/>
          	  <form action="deleteRecord" method = "post">
				  <table class="table table-condensed">
				    <tr>
				    <td>第<%=pageIndex %>页：</td>
					<td>时间</td>
					<td>位置</td>
					<td>wifi</td>
					<td>状态</td>
					</tr>
				<%
				RS_result = stmt.executeQuery("SELECT * FROM " + session.getAttribute("username") + " WHERE isshow = '1' ORDER BY `time` ASC");
				if(RS_result.next())
				{
					RS_result.beforeFirst();
					int pagesNum, recordsPerPage = 13, recordsNum = 0;
					while (RS_result.next())
					{
						String mtime = RS_result.getString("time");
						if (mtime == null)
							continue;
						if ((request.getParameter("beginDate") != null) && (request.getParameter("endDate") != null))
						{
							if ((mtime.compareTo(request.getParameter("beginDate")) >= 0) && (mtime.compareTo(request.getParameter("endDate")) <= 0))
								recordsNum ++;
						}
						else
						{
							if (request.getParameter("beginDate") != null)
							{
								if (mtime.compareTo(request.getParameter("beginDate")) >= 0)
									recordsNum ++;
							}
							else
							{
								if (request.getParameter("endDate") != null)
								{
									if (mtime.compareTo(request.getParameter("endDate")) <= 0)
										recordsNum ++;
								}
								else
									recordsNum ++;
							}
						}
					}
					
					if (recordsNum % recordsPerPage == 0)
						pagesNum = recordsNum / recordsPerPage;
					else
						pagesNum = recordsNum / recordsPerPage + 1;
					
					if ((pageIndex - 1) * recordsPerPage == 0)
			       		RS_result.beforeFirst();
			       	else
			       		RS_result.absolute((pageIndex - 1) * recordsPerPage);
					int i = 0;
					while ((RS_result.next()) && (i < recordsPerPage))
					{
							String time = "";
							if (RS_result.getString("time") != null)
								time = RS_result.getString("time");
				            if ((request.getParameter("beginDate") != null) && (time.compareTo(request.getParameter("beginDate")) < 0))
				            	continue;
				            if ((request.getParameter("endDate") != null) && (time.compareTo(request.getParameter("endDate")) > 0))
				            	continue;
				            String pos = "";
							if (RS_result.getString("longitude") != null)
								pos += RS_result.getString("longitude") + ", ";
							if (RS_result.getString("latitude") != null)
								pos += RS_result.getString("latitude");
							String wifi = "";
							if (RS_result.getString("wifiname") != null)
								wifi += RS_result.getString("wifiname") + ", ";
							if (RS_result.getString("macAddr") != null)
								wifi += RS_result.getString("macAddr") + ", ";
							if (RS_result.getString("wifisig") != null)
								wifi += RS_result.getString("wifisig");
							String text = "";
							if (RS_result.getString("text") != null)
								text = RS_result.getString("text");
							session.setAttribute("target", "manage");
					%>
							<tr>
							<td><input class="checkbox" name = "check" type="checkbox" value = "<%=RS_result.getString("UserID")%>"></td>
							<td><%=time %></td>
							<td><%=pos %></td>
							<td><%=wifi %></td>
							  <form action="editText" method="post" accept-charset="ISO-8859-1">
						      	   <td><textarea class="form-control" rows="3" name = "text"><%=text %></textarea></td>
						      	   <td><input type="submit" class="btn btn-primary" value="修改"></td>	
						      </form>	
						    </tr>	
					<%
							i ++;
					}
					%>
					<tr>
					<td>
					<%
					if (pageIndex != 1)
					{
					%>
					
						<a href = "<%="manage.jsp?pageIndex=1"%>">首页</a>
						<a href = "<%="manage.jsp?pageIndex=" + (pageIndex - 1)%>">上一页</a>
					
					<%
					}
					if (pageIndex != pagesNum)
					{
					%>
						<a href = "<%="manage.jsp?pageIndex=" + (pageIndex + 1)%>">下一页</a>
						<a href = "<%="manage.jsp?pageIndex=" + pagesNum%>">末页</a>
					<%
					}
					
					%>
					</td>
					<td></td>
					<td></td>
					<td><a href = "<%="restore.jsp"%>">回收站</a></td>
					</tr>
					</table>
				    <button type="submit" class="btn btn-primary" >删除记录</button>
			<%
				}
				else
				{
					%>
					<tr>
					<td></td>
					<td></td>
					<td></td>
					<td><a href = "<%="restore.jsp"%>">回收站</a></td>
					</tr>					
					<%
				}
				RS_result.close();
				stmt.close();
				conn.close();
			}
			%>
			  </form>					
		</div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript "data:image/png;base64,"
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="bootstrap-3.0.0/assets/js/jquery.js"></script>
    <script src="bootstrap-3.0.0/dist/js/bootstrap.min.js"></script>
    <script src="bootstrap-3.0.0/assets/js/holder.js"></script>
  </body>
</html>

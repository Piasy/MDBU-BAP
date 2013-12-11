<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="bootstrap-3.0.0/assets/ico/faviconx.png">

    <title>Regist for MDBU BAP</title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.0.0/dist/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="signin.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="bootstrap-3.0.0/assets/js/html5shiv.js"></script>
      <script src="bootstrap-3.0.0/assets/js/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="container">
	<form action = "Regist" method="post">
	    <%
		String username = (String) session.getAttribute("username");
		String hint = "Welcome to join us";
		if (username != null)
		{
			if (username.equals("accounterror"))
				hint = new String("Exsisteing account!");
			else
			{
				if (username.equals("passworderror"))
					hint = new String("Two different passwords!");
				else
				{
					if (username.equals("emailerror"))
						hint = new String("Exsisteing email address!");
					else
					{
						if (username.equals("empty"))
							hint = new String("Please type all the info!");
						else
							hint = username;
					}
				}
			}
		}
		%>
		<h2 class="form-signin-heading"><%=hint%></h2>
		<div class="form-group">
  			<label for="Inputusername">User Name</label>
  			<input type="text" class="form-control" id="Inputusername" name ="username" placeholder="Username">
		</div>
		<div class="form-group">
  			<label for="InputPassword1">Password</label>
  			<input type="password" class="form-control" id="InputPassword1" name="password" placeholder="Password">
		</div>
		<div class="form-group">
  			<label for="InputPassword2">Password confirm</label>
  			<input type="password" class="form-control" id="InputPassword2" name="password2" placeholder="Password confirm">
		</div>
		<div class="form-group">
  			<label for="InputEmail">Email address</label>
  			<input type="text" class="form-control" id="InputEmail" name ="email" placeholder="Email address">
		</div>
		<button class="btn btn-primary" type="submit">Join now</button>
		<a class="btn btn-primary" href= "signin.jsp" id = "signin">Sign in</a>
	</form>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>

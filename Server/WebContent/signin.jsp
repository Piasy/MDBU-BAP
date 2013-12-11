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

    <title>Signin for MDBU BAP</title>

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

      <form class="form-signin" action = "Login" method="post">
      	<%
			String username = (String) session.getAttribute("username");
			String hint = "Please sign in";
			if (username != null)
			{
				if (username.equals("noaccount"))
					hint = new String("Invalid account!");
				else
				{
					if (username.equals("passworderror"))
						hint = new String("Wrong password!");
					else
					{
						if (username.equals("empty"))
							hint = new String("Please type all the info!");
						else
							hint = username;
					}
				}
			}
		%>
        <h2 class="form-signin-heading"><%=hint%></h2>
        <input type="text" class="form-control" name ="username" placeholder="Username">
        <input type="password" class="form-control" name="password" placeholder="Password">
        <label class="checkbox">
          <input type="checkbox" value="remember-me"> Remember me
        </label>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        <a class="btn btn-lg btn-primary btn-block" href= "regist.jsp" >Sign up</a>
      </form>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>

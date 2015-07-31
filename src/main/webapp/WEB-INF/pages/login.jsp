<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gravitee IO Authorization Server Signin</title>
    <link rel="icon" type="image/png" href="<c:url value="/resources/images/logo_gravitee.png" />" />
    <link href="<c:url value="/resources/bootstrap/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/app.css" />" rel="stylesheet">
  </head>
  <body>
    <div class="container">
    	<div class="card card-container">
			<img id="profile-img" class="profile-img-card" src="<c:url value="/resources/images/logo_gravitee.png" />" />	  
			<form class="form-signin" action="<c:url value='j_spring_security_check' />" method="post">
	        	<label for="inputLogin" class="sr-only">Login</label>
	        	<input type="text" id="inputLogin" name="j_username" class="form-control" placeholder="Login" required autofocus>
	        	<label for="inputPassword" class="sr-only">Password</label>
	        	<input type="password" id="inputPassword" name="j_password" class="form-control" placeholder="Password" required>
	        	<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      		</form>
      
     	 	<c:if test="${not empty error}">
    			<div class="row">
    	  			<div style="text-align : center; color: red;">
    	     			Authentication failed ! 
    	  			</div>
    			</div>
      		</c:if>
      		
     		<c:if test="${not empty logout}">
    			<div class="row">
    	  			<div style="text-align : center; color: blue;">
    	     			You have been logged out.
    	  			</div>
    			</div>
      		</c:if>
      	</div>
    </div>
  </body>
</html>
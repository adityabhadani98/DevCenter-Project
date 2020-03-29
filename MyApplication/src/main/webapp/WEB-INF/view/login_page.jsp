<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="java.util.ResourceBundle"%>
<%
	Connection con = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/random_schema?user=root&password=root");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="sat, 01 Dec 2001 00:00:00 GMT">
<title>HCOM-Hospital Home</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="sat, 01 Dec 2001 00:00:00 GMT">
<title>HCOM-Hospital Home</title>
<meta charset="utf-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/style.css" rel="stylesheet">
<script
	src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.9/validator.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-show-password/1.0.3/bootstrap-show-password.min.js"></script>
<script>
	function preventBack() {
		window.history.forward();
	}

	setTimeout("preventBack()", 0);
	window.onunload = function() {
		null
	};
</script>
<style>
html, body {
	margin: 0;
	padding: 0;
}

.navbar_right {
	padding: 4px 0;
	background: #0E94D3; /* Old browsers */
	background: -moz-linear-gradient(45deg, #95cd6a 0%, #95cd6a 21%, #0E94D3 21%,
		#0E94D3 100%); /* FF3.6-15 */
	background: -webkit-linear-gradient(45deg, #95cd6a 0%, #95cd6a 21%, #0E94D3 21%,
		#0E94D3 100%); /* Chrome10-25,Safari5.1-6 */
	background: linear-gradient(45deg, #95cd6a 0%, #95cd6a 21%, #0E94D3 21%, #0E94D3
		100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
}

.slider {
	width: 1024px;
	margin: 2em auto;
}

.slider-wrapper {
	width: 100%;
	height: 400px;
	position: relative;
}

li a {
	display: block;
	color: white;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
}

.slide {
	float: left;
	position: absolute;
	width: 100%;
	height: 100%;
	opacity: 0;
	transition: opacity 3s linear;
}

.slider-wrapper>.slide:first-child {
	opacity: 1;
}
</style>
</head>

<body>
	<%
		ResourceBundle resourceBundle = ResourceBundle.getBundle("com.cerner.i18n.content", request.getLocale());
	%>
	<div role="navigation">
		<div class="navbar_right">
			<a class="navbar-brand"><%=resourceBundle.getString("hospitalLoginPage")%></a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
				</ul>
			</div>
		</div>
	</div>

	<c:choose>
		<c:when test="${mode=='MODE_HOME' }">
			<div class="container text-center">
				<h3><%=resourceBundle.getString("userLogin")%></h3>
				<hr>
				<form name="loginform" class="form-horizontal" method="POST"
					action="/login-user" onsubmit="return validLogin();">
					<c:if test="${not empty error }">
						<div class="alert alert-danger">
							<c:out value="${error }"></c:out>
						</div>
					</c:if>
					<div class="form-group">
						<input type="hidden" name="id" value="${ users.userid }" />
						<%
							String userid = request.getParameter("id");
									session.setAttribute("userid", userid);
						%>
						<label class="control-label col-md-3"><%=resourceBundle.getString("userID")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="userid" required
								value="${users.userid }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("password")%></label>
						<div class="col-md-7">
							<input type="password" class="form-control" required
								name="password" value="${users.password }" />
						</div>
					</div>
					<div class="form-group ">
						<input type="submit" class="btn btn-success"
							value="<%=resourceBundle.getString("login")%>" />
					</div>
				</form>
			</div>
		</c:when>
	</c:choose>

	<script src="static/js/jquery-1.11.1.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
	
</body>
</html>
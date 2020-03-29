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
</head>

<body>
	<%
		ResourceBundle resourceBundle = ResourceBundle.getBundle("com.cerner.i18n.content", request.getLocale());
	%>
	<div role="navigation">
		<div class="navbar_inverse">
			<a class="navbar-brand"><%=resourceBundle.getString("patientHome")%></a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="/patient-profile"><%=resourceBundle.getString("myProfile")%></a></li>
					<li><a href="/logout"><%=resourceBundle.getString("logout")%></a></li>
				</ul>
			</div>
		</div>
	</div>

	<c:choose>
		<c:when test="${mode=='MODE_HOME' }">
			<div class="container" id="homediv">
				<div class="jumbotron text-center">
					<h1><%=resourceBundle.getString("patientHomePage")%></h1>
					<%
						String UserId = (String) session.getAttribute("userid");
								int pId = Integer.parseInt(UserId);
								Class.forName("com.mysql.cj.jdbc.Driver");
								PreparedStatement patientPs = con.prepareStatement("select name from users where userid=?");
								patientPs.setInt(1, pId);
								ResultSet patientRs = patientPs.executeQuery();
								while (patientRs.next()) {
					%>
					<h2>
						Hello
						<%=patientRs.getString("name")%></h2>
					<%
						}
					%>
				</div>
			</div>
		</c:when>
		<c:when test="${mode=='SHOW_PATIENT_DETAILS' }">
			<div class="container" id="homediv">
				<h2>Edit profile details</h2>
				<div class="table-responsive">
					<hr>
					<table class="table table-striped mt32">
						<thead>
							<tr>
								<th><%=resourceBundle.getString("id")%></th>
								<th><%=resourceBundle.getString("name")%></th>
								<th><%=resourceBundle.getString("password")%></th>
								<th><%=resourceBundle.getString("dob")%></th>
								<th><%=resourceBundle.getString("roleid")%></th>
								<th><%=resourceBundle.getString("email")%></th>
								<th><%=resourceBundle.getString("enabled")%></th>
								<th><%=resourceBundle.getString("gender")%></th>
								<th><%=resourceBundle.getString("address")%></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${ users.userid}</td>
								<td>${ users.name}</td>
								<td>${ users.password }</td>
								<td>${ users.dob}</td>
								<td>${ users.roleid}</td>
								<td>${ users.email}</td>
								<td>${ users.enabled}</td>
								<td>${ users.gender}</td>
								<td>${ users.address}</td>
								<td><a href="/update-patient?id=${ users.userid }"><span
										class="glyphicon glyphicon-pencil"
										style="font-size: 20px; color: green"></span></a></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</c:when>

		<c:when test="${mode=='PATIENT_PROFILE_UPDATE' }">
			<div class="container text-center">
				<h3>Update profile details</h3>
				<hr>
				<form id="updateDetails" class="form-horizontal"
					data-toggle="validator" method="POST" action="/update-patient"
					novalidate>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("patientID")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="userid"
								value="${cookie.userid.value }" readonly="readonly" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("name")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="name" id="name"
								value="${user.name }" required disabled="disabled"
								data-error="Please enter your name." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("password")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="password"
								id="password" value="${user.password }" required
								disabled="disabled" data-error="Please enter the password." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("email")%></label>
						<div class="col-md-7">
							<input type="email" class="form-control" name="email" id="email"
								value="${user.email }" required disabled="disabled"
								data-error="Please enter your email." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("dob")%></label>
						<div class="col-md-3">
							<input type="date" class="form-control" name="dob" id="dob"
								value="${user.dob }" required disabled="disabled"
								data-error="Please enter your date of birth." />
							<div class="help-block with-errors"></div>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("gender")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="gender" id="gender"
								value="${user.gender }" required pattern="M/N"
								disabled="disabled" data-error="Please enter your gender." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("address")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="address"
								id="address" value="${user.address }" required
								disabled="disabled" data-error="Please enter your address." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group ">
						<input type="submit" class="btn btn-success"
							value="<%=resourceBundle.getString("save")%>" /> <input
							type="button" class="btn btn-warning"
							value="<%=resourceBundle.getString("startEditing")%>"
							onclick="enableEditing();" />
					</div>
				</form>
			</div>
			<script>
				function enableEditing() {
					$('#name').removeAttr("disabled");
					$('#password').removeAttr("disabled");
					$('#phone').removeAttr("disabled");
					$('#email').removeAttr("disabled");
					$('#dob').removeAttr("disabled");
					$('#gender').removeAttr("disabled");
					$('#address').removeAttr("disabled");
				}
			</script>
		</c:when>
	</c:choose>

	<script src="static/js/jquery-1.11.1.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
</body>
</html>
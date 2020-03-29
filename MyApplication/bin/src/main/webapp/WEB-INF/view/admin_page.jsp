<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.ResourceBundle"%>
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

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/style.css" rel="stylesheet">

<script>
	var userid = $('#userid').val();
	var name = $('#name').val();
	var password = $('#password').val();
	var dob = $('#dob').val();
	var roleid = $('#roleid').val();
	var email = $('#email').val();
	var gender = $('#gender').val();
	var address = $('#address').val();

	$(function() {
		$("#submit")
				.click(
						function() {
							$
									.ajax({
										type : "post",
										url : "http://localhost:8080/update-user",
										cache : false,
										data : 'userid=' + userid + '&name='
												+ name + '&password='
												+ password + '&dob=' + dob
												+ '&roleid=' + roleid
												+ '&email=' + email
												+ '&gender=' + gender
												+ '&address=' + address,
										success : function(response) {
											alert('Record updated Successfully for User ID:'
													+ userid);
											window.location = 'http://localhost:8080/update-user?id='
													+ userid;
										},
										error : function() {
											alert('Please Select the Options..');
										}
									});
						});
	});
</script>


</head>
<body>
	<div role="navigation">
		<div class="navbar navbar-inverse">
			<a class="navbar-brand">ADMIN HOME</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="/show-users">Home</a></li>
					<li><a href="/register_user">Add User</a></li>
					<li><a href="/doctor_details">Doctor Details</a></li>
					<li><a href="/appointment">Schedule appointment</a></li>
					<li><a href="/welcome">Logout</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="container" id="homediv">
		<div class="jumbotron text-center">
			<h1>ADMIN-PAGE</h1>
			<h2>Hello Aditya</h2>
		</div>
	</div>

	<c:choose>
		<c:when test="${mode=='MODE_REGISTER' }">
			<div class="container text-center">
				<h3>New Registration for patient/doctor</h3>
				<h4>Enter the patient/doctor details</h4>
				<hr>
				<form class="form-horizontal" method="POST" action="save-user">
					<input type="hidden" name="id" value="${user.id }" />
					<div class="form-group">
						<label class="control-label col-md-3">User id</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="userid"
								value="${user.userid }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Name</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="name"
								value="${user.name }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Password</label>
						<div class="col-md-7">
							<input type="password" class="form-control" name="password"
								value="${user.password }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">DOB </label>
						<div class="col-md-3">
							<input type="text" class="form-control" name="dob"
								value="${user.dob }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Roleid</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="roleid"
								value="${user.roleid }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Email</label>
						<div class="col-md-7">
							<input type="email" class="form-control" name="email"
								value="${user.email }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">User Status</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="enabled"
								value="${user.enabled }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Gender</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="gender"
								value="${user.gender }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Address</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="address"
								value="${user.address }" />
						</div>
					</div>
					<div class="form-group ">
						<input type="submit" class="btn btn-primary" value="Register" />
					</div>
				</form>
			</div>
		</c:when>


		<c:when test="${mode=='DOC_DETAILS' }">
			<div class="container text-center">
				<h3>Enter the additional doctor details.</h3>
				<h4>Doctor ID should match with the user ID</h4>
				<form class="form-horizontal" method="POST" action="save-doctor">
					<input type="hidden" id="doctorid" value="${doctor.id }" />
					<hr>
					<div class="form-group">
						<label class="control-label col-md-3">Doctor id</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="doctorid"
								value="${doctor.doctorid }" />
						</div>
					</div>

					<div class="form-group">
						<label for="dept">Department: </label> <select id="dept"
							name="item" onchange="getSelected1();">
							<option value="Pediatrician" class="option">Pediatrician
								Child Expert</option>
							<option value="Allergist" class="option">Allergist -
								Allergy Expert</option>
							<option value="Anesthesiologist" class="option">Anesthesiologist
								- Anesthetic Expert</option>
							<option value="Cardiologist" class="option">Cardiologist
								- Heart Expert</option>
							<option value="Dentist" class="option">Dentist - Oral
								Care Expert</option>
							<option value="Dermatologist" class="option">Dermatologist
								- Skin Expert</option>
							<option value="Endocrinologist" class="option">ENT
								Specialist - Ear-Nose-Throat Expert</option>
						</select>
					</div>

					<div class="form-group">
						<label for="pwd">Qualification: </label> <select id="qual" onchange="getSelected2();">
							<option value="mbbs" class="option">MBBS - Bachelor of
								Medicine</option>
							<option value="md" class="option">MD - Doctor of
								medicine by research</option>
							<option value="phd" class="option">PhD - Doctor of
								Philosophy</option>
						</select>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Experience(in
							years): </label>
						<div class="col-md-3">
							<input type="text" class="form-control" name="experience"
								value="${doctor.experience }" />
						</div>
					</div>

					<div class="form-group">
						<label for="pwd">Free batch: </label> <select id="free_batch" onchange="getSelected3();">
							<option value="morning" class="option">Morning Batch</option>
							<option value="afternoon" class="option">Afternoon Batch</option>
							<option value="evening" class="option">Evening Batch</option>
						</select>
					</div>

					<div class="form-group ">
						<input type="submit" class="btn btn-primary" value="Register" />
					</div>
				</form>
			</div>
			<script>
				var doctorid = $('#doctorid').val();
				var qualification = $('#qual').val();
				var dept = '';
				var qual = '';
				var free_batch = '';
				function getSelected1()
			    { dept = $('#dept').val(); }
			    function getSelected2()
			    { qual = $('#qual').val(); }
			    function getSelected3()
			    { free_batch = $('free_batch').val(); }
				$(function() {
					$("#submit")
							.click(
									function() {
										$
												.ajax({
													type : "post",
													url : "http://localhost:8080/save-doctor",
													cache : false,
													data : 'doctorid='
															+ doctorid
															+ '&department='
															+ department
															+ '&qualification='
															+ qualification
															+ '&experience='
															+ experience
															+ '&free_batch='
															+ free_batch,
													success : function(response) {
														alert('Record added Successfully for Doctor ID:'
																+ doctorid);
														window.location = 'http://localhost:8080/save-doctor?id='
																+ doctorid;
													},
													error : function() {
														alert('Please Select the Options..');
													}
												});
									});
				});
			</script>

		</c:when>


		<c:when test="${mode=='ALL_USERS' }">

			<div class="container text-center" id="tasksDiv">
				<h3>All Users</h3>
				<hr>
				<div class="table-responsive">
					<input type="text" id="myInput" class="form-control search-input"
						placeholder="Search for names.." title="Type in a name"
						data-table="users-list">
					<table class="table table-striped table-bordered users-list">
						<thead>
							<tr>
								<th>User Id</th>
								<th>Name</th>
								<th>Password</th>
								<th>Age</th>
								<th>Role Id</th>
								<th>Email</th>
								<th>Gender</th>
								<th>Address</th>
								<th>Status</th>
								<th>Delete</th>
								<th>Edit</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="user" items="${users }">
								<tr>
									<td>${user.userid}</td>
									<td>${user.name}</td>
									<td>${user.password}</td>
									<td>${user.dob}</td>
									<td>${user.roleid}</td>
									<td>${user.email}</td>
									<td>${user.gender}</td>
									<td>${user.address}</td>
									<td>${user.enabled}</td>
									<td><a href="/delete-user?id=${user.userid }"><span
											class="glyphicon glyphicon-trash"></span></a></td>
									<td><a href="/edit-user?id=${user.userid }"><span
											class="glyphicon glyphicon-pencil"></span></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<script>
				(function(document) {
					'use strict';
					var TableFilter = (function(myArray) {
						var search_input;
						function _onInputSearch(e) {
							search_input = e.target;
							var tables = document
									.getElementsByClassName(search_input
											.getAttribute('data-table'));
							myArray.forEach.call(tables, function(table) {
								myArray.forEach.call(table.tBodies, function(
										tbody) {
									myArray.forEach.call(tbody.rows, function(
											row) {
										var text_content = row.textContent
												.toLowerCase();
										var search_val = search_input.value
												.toLowerCase();
										row.style.display = text_content
												.indexOf(search_val) > -1 ? ''
												: 'none';
									});
								});
							});
						}
						return {
							init : function() {
								var inputs = document
										.getElementsByClassName('search-input');
								myArray.forEach.call(inputs, function(input) {
									input.oninput = _onInputSearch;
								});
							}
						};
					})(Array.prototype);
					document.addEventListener('readystatechange', function() {
						if (document.readyState === 'complete') {
							TableFilter.init();
						}
					});
				})(document);
			</script>
		</c:when>


		<c:when test="${mode=='MODE_UPDATE'}">
			<div class="container text-center">
				<h3>Update User</h3>
				<hr>
				<form class="form-horizontal" method="POST" action="update-user">
					<input type="hidden" id="userid" value="${user.id }" />

					<div class="form-group">
						<label class="control-label col-md-3">User Id</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="userid"
								value="<%=request.getParameter("id")%>" readonly="readonly" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Name</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="name"
								value="${user.name }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Password</label>
						<div class="col-md-7">
							<input type="password" class="form-control" name="password"
								value="${user.password }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">DOB</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="dob"
								value="${user.dob }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Role Id</label>
						<div class="col-md-3">
							<input type="text" class="form-control" name="roleid"
								value="${user.roleid }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Email</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="email"
								value="${user.email }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Gender</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="gender"
								value="${user.gender }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Address</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="address"
								value="${user.address }" />
						</div>
					</div>
					<div class="form-group ">
						<input type="submit" class="btn btn-primary" value="Update" />
					</div>
				</form>
			</div>
		</c:when>
	</c:choose>

	<script src="static/js/jquery-1.11.1.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
</body>
</html>
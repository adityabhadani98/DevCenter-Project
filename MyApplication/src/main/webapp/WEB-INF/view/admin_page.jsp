<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
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
</head>

<body>
	<%
		ResourceBundle resourceBundle = ResourceBundle.getBundle("com.cerner.i18n.content", request.getLocale());
	%>
	<div role="navigation">
		<div class="navbar_inverse">
			<a class="navbar-brand"><%=resourceBundle.getString("adminHome")%></a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="/show-users"><%=resourceBundle.getString("home")%></a></li>
					<li><a href="/register_user"><%=resourceBundle.getString("addUser")%></a></li>
					<li><a href="/doctor_details"><%=resourceBundle.getString("doctorDetails")%></a></li>
					<li><a href="/app1"><%=resourceBundle.getString("scheduleAppointment")%></a></li>
					<li><a href="/app2"><%=resourceBundle.getString("appointmentList")%></a></li>
					<li><a href="/logout"><%=resourceBundle.getString("logout")%></a></li>
				</ul>
			</div>
		</div>
	</div>

	<c:choose>
		<c:when test="${mode=='MODE_HOME' }">
			<div class="container" id="homediv">
				<div class="jumbotron text-center">
					<h1><%=resourceBundle.getString("adminHomePage")%></h1>
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
		<c:when test="${mode=='MODE_REGISTER' }">
			<div class="container text-center">
				<h3><%=resourceBundle.getString("newRegistrationForPatient/Doctor")%></h3>
				<hr>
				<form class="form-horizontal" method="POST" action="save-user">
					<input type="hidden" name="id" value="${user.id }" />
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("name")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="name" required
								value="${user.name }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("password")%></label>
						<div class="col-md-7">
							<input type="password" class="form-control" name="password"
								required value="${user.password }"
								data-error="Please enter the password." data-toggle="password" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("dob")%></label>
						<div class="col-md-3">
							<input type="date" class="form-control" name="dob" required
								max="2020-03-30" min="1920-01-01" value="${user.dob }" />
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("roleName")%></label>
						<div class="col-md-7">
							<%
								Class.forName("com.mysql.cj.jdbc.Driver");
										PreparedStatement s_ps = con.prepareStatement("SELECT ur.roleid,ur.role_name FROM user_role ur");
										ResultSet s_rs = s_ps.executeQuery();
							%>
							<select class="form-control" name="roleid">
								<option value="${user.roleid }" disabled selected></option>
								<%
									while (s_rs.next()) {
												String roleid = s_rs.getString("roleid");
												String rolename = s_rs.getString("role_name");
								%>
								<option value="<%=roleid%>"><%=rolename%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("email")%></label>
						<div class="col-md-7">
							<input type="email" class="form-control" name="email" required
								value="${user.email }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("enabled")%></label>
						<div class="col-md-7">
							<select class="form-control" name="enabled" id="enabled-select">
								<option value="${user.enabled }" disabled selected></option>
								<option value="1">Active User</option>
								<option value="0">Inactive User</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("gender")%></label>
						<div class="col-md-3">
							<select class="form-control" name="gender">
								<option value="${user.gender }" disabled selected></option>
								<option value="M">Male</option>
								<option value="F">Female</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("address")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="address" required
								value="${user.address }" />
						</div>
					</div>
					<div class="form-group ">
						<input type="submit" class="btn btn-primary"
							value="<%=resourceBundle.getString("register")%>" />
					</div>
				</form>
			</div>
		</c:when>

		<c:when test="${mode=='DOC_DETAILS' }">
			<div class="container text-center">
				<h3><%=resourceBundle.getString("enterDoctorDemographicDetails")%></h3>
				<hr>
				<form class="form-horizontal" method="POST" action="save-doctor">
					<input type="hidden" name="id" value="${doctor.id }" />
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("id")%></label>
						<div class="col-md-7">
							<%
								Class.forName("com.mysql.cj.jdbc.Driver");
										PreparedStatement s_ps = con.prepareStatement("SELECT userid,name FROM users where roleid='R3' and userid not in (SELECT doctorId from doctor)");
										ResultSet s_rs = s_ps.executeQuery();
							%>
							<select class="form-control" name="doctorId">
								<option value="${doctor.doctorid }"></option>
								<%
									while (s_rs.next()) {
												String doctor_id = s_rs.getString("userid");
												String doctor_name = s_rs.getString("name");
								%>
								<option value="<%=doctor_id%>"><%=doctor_name%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("department")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="department"
								required value="${doctor.department }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("qualification")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="qualification"
								required value="${doctor.qualification }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("experience")%></label>
						<div class="col-md-3">
							<input type="number" class="form-control" name="experience"
								required value="${doctor.experience }" />
						</div>
					</div>
					<div class="form-group ">
						<input type="submit" name="submit1" id="submit1"
							class="btn btn-primary"
							value="<%=resourceBundle.getString("register")%>" />
					</div>
				</form>
			</div>
		</c:when>


		<c:when test="${mode=='ALL_USERS' }">
			<div class="container text-center" id="tasksDiv">
				<h3><%=resourceBundle.getString("allUsers")%></h3>
				<hr>
				<%
					Class.forName("com.mysql.cj.jdbc.Driver");
							PreparedStatement patient_ps = con.prepareStatement(
									"SELECT users.userid,users.name,users.email,users.enabled,users.gender,user_role.role_name from users,user_role where users.roleid=user_role.roleid");
							PreparedStatement patient_ps1 = con
									.prepareStatement("SELECT DATE_FORMAT(users.dob, '%d-%b-%Y') as dob from users");
							ResultSet patient_rs = patient_ps.executeQuery();
							ResultSet patient_rs1 = patient_ps1.executeQuery();
				%>
				<div class="table-responsive">
					<input type="text" id="myInput" class="form-control search-input"
						placeholder="Search for names.." title="Type in a name"
						data-table="users-list">
					<h4 style="text-align: left">Select number of rows</h4>
					<div class="form-group">
						<select name="state" id="maxRows" class="form-control"
							style="width: 180px;">
							<option value="5000">Show All</option>
							<option value="2">2</option>
							<option value="5">5</option>
							<option value="10">10</option>
						</select>
					</div>
					<p align="left"><button onclick="sortTable()"><%=resourceBundle.getString("sortById")%></button></p>
					<table class="table table-striped table-bordered users-list"
						id="myTable">
						<thead>
							<tr>
								<th style="text-align: center"><%=resourceBundle.getString("userid")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("name")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("dateOfBirth")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("role")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("email")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("gender")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("enabled")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("delete")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("edit")%></th>
							</tr>
						</thead>
						<%
							while (patient_rs.next() && patient_rs1.next()) {
						%>
						<tbody>
							<tr>
								<td style="text-align: center"><%=patient_rs.getString("userid")%></td>
								<td style="text-align: center"><%=patient_rs.getString("name")%></td>
								<td style="text-align: center"><%=patient_rs1.getString("dob")%></td>
								<td style="text-align: center"><%=patient_rs.getString("role_name")%></td>
								<td style="text-align: center"><%=patient_rs.getString("email")%></td>
								<td style="text-align: center"><%=patient_rs.getString("gender")%></td>
								<%
									int temp = Integer.parseInt(patient_rs.getString("enabled"));
												if (temp == 1) {
								%>
								<td style="text-align: center">Active</td>
								<%
									} else {
								%>
								<td style="text-align: center">Inactive</td>
								<%
									}
								%>
								<td><a
									href="/delete-user?id=<%=patient_rs.getString("userid")%>"><span
										style="margin: auto; display: data1;"
										class="glyphicon glyphicon-trash"></span></a></td>
								<td><a
									href="/edit-user?id=<%=patient_rs.getString("userid")%>"><span
										style="margin: auto; display: table;"
										class="glyphicon glyphicon-pencil"></span></a></td>
							</tr>
							<%
								}
										con.close();
							%>
						</tbody>
					</table>
					<div class="pagination-container">
						<nav>
							<ul class="pagination"></ul>
						</nav>
					</div>
				</div>
			</div>
			<script>
				var table = '#mytable'
				$('#maxRows')
						.on(
								'change',
								function() {
									$('.pagination').html('')
									var trnum = 0
									var maxRows = parseInt($(this).val())
									var totalRows = $(table + ' tbody tr').length
									$(table + ' tr:gt(0)').each(function() {
										trnum++
										if (trnum > maxRows) {
											$(this).hide()
										}
										if (trnum <= maxRows) {
											$(this).show()
										}
									})
									if (totalRows > maxRows) {
										var pagenum = Math.ceil(totalRows
												/ maxRows)
										for (var i = 1; i < pagenum;) {
											$('.pagination')
													.append(
															'<li data-page = "' + i + '">\<span>'
																	+ i++
																	+ '<span class="sr-only">(current)</span></span>\</li>')
													.show()
										}
									}
									$('.pagination li:first-child').addClass(
											'active')
									$('.pagination li')
											.on(
													'click',
													function() {
														var pageNum = $(this)
																.attr(
																		'data-page')
														var trIndex = 0;
														$('.pageination li')
																.removeClass(
																		'active')
														$(this).addClass(
																'active')
														$(table + ' tr:gt(0)')
																.each(
																		function() {
																			trIndex++
																			if (trIndex > (maxRows + pageNum)
																					|| trIndex <= ((maxRows * pageNum) - maxRows)) {
																				$(
																						this)
																						.hide()
																			} else {
																				$(
																						this)
																						.show()
																			}
																		})
													})
								})
				$(function() {
					//$('table tr:eq(0)').prepend('<th>ID</th>')
					var id = 0;
					$('table tr:gt(0)').each(function() {
						id++
						//$(this).prepend('<td>' + id + '</td>')
					})
				})

						(
								function(document) {
									'use strict';
									var TableFilter = (function(myArray) {
										var search_input;
										function _onInputSearch(e) {
											search_input = e.target;
											var tables = document
													.getElementsByClassName(search_input
															.getAttribute('data-table'));
											myArray.forEach
													.call(
															tables,
															function(table) {
																myArray.forEach
																		.call(
																				table.tBodies,
																				function(
																						tbody) {
																					myArray.forEach
																							.call(
																									tbody.rows,
																									function(
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
												myArray.forEach
														.call(
																inputs,
																function(input) {
																	input.oninput = _onInputSearch;
																});
											}
										};
									})(Array.prototype);
									document
											.addEventListener(
													'readystatechange',
													function() {
														if (document.readyState === 'complete') {
															TableFilter.init();
														}
													});
								})(document);
			</script>
		</c:when>

		<c:when test="${mode=='MODE_UPDATE' }">
			<h3 style="text-align: center"><%=resourceBundle.getString("updateUserDetails")%></h3>
			<div class="container text-center">
				<%
					String userid = (String) session.getAttribute("userid");
							int uid = Integer.parseInt(userid);
							Class.forName("com.mysql.cj.jdbc.Driver");
							PreparedStatement doctor_ps = con.prepareStatement(
									"select u.userid,u.name,u.password,u.roleid,u.email,u.dob,u.address,u.gender,u.enabled from users u where u.userid=?");
							doctor_ps.setInt(1, uid);
							ResultSet doctor_rs = doctor_ps.executeQuery();
							while (doctor_rs.next()) {
				%>
				<hr>

				<form name="userForm" id="updateDetails" class="form-horizontal"
					method="POST" action="update-user" onsubmit="return validDetails();">
					<input type="hidden" name="id" value="${user.userid }" />
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("id")%></label>
						<div class="col-md-7">
							<input type="number" class="form-control" name="userid"
								value="<%=doctor_rs.getString("userid")%>" readonly="readonly" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("name")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="name" id="name"
								value="<%=doctor_rs.getString("name")%>" required
								data-error="Please enter your name." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("password")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="password"
								id="password" value="<%=doctor_rs.getString("password")%>"
								required data-error="Please enter the password."
								data-toggle="password" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("roleid")%></label>
						<div class="col-md-3">
							<input type="text" class="form-control" name="roleid" id="roleid"
								value="<%=doctor_rs.getString("roleid")%>" required
								data-error="Please enter correct role id." readonly="readonly" />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("email")%></label>
						<div class="col-md-7">
							<input type="email" class="form-control" name="email" id="email"
								value="<%=doctor_rs.getString("email")%>" required
								data-error="Please enter your email." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("dob")%></label>
						<div class="col-md-3">
							<input type="date" class="form-control" name="dob" id="dob"
								value="<%=doctor_rs.getString("dob")%>" required
								max="2020-03-30" min="1920-01-01" data-error="Please enter your date of birth." />
							<div class="help-block with-errors"></div>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("address")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="address"
								id="address" value="<%=doctor_rs.getString("address")%>"
								required data-error="Please enter your address." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("gender")%></label>
						<div class="col-md-3">
							<select class="form-control" name="gender">
								<option value="${user.gender }" disabled selected></option>
								<option value="M">Male</option>
								<option value="F">Female</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("enabled")%></label>
						<div class="col-md-7">
							<select class="form-control" name="enabled" id="enabled-select">
								<option value="${user.enabled }" disabled selected><%=doctor_rs.getString("enabled")%></option>
								<option value="1">Active User</option>
								<option value="0">Inactive User</option>
							</select>
						</div>
					</div>
					<div class="form-group ">
						<input type="submit" class="btn btn-primary"
							value="<%=resourceBundle.getString("updateUser")%>" />
					</div>
				</form>
				<%
					}
							con.close();
				%>
			</div>
		</c:when>
	</c:choose>

	<script src="static/js/jquery-1.11.1.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
	<script>
		$("#password").password('toggle');
		var userid = $('#userid').val();
		var name = $('#name').val();
		var password = $('#password').val();
		var dob = $('#dob').val();
		var roleid = $('#roleid').val();
		var email = $('#email').val();
		var gender = $('#gender').val();
		var address = $('#address').val();
		var enabled = $('#enabled').val();

		$(function() {
			$("#submit")
					.click(
							function() {
								$
										.ajax({
											type : "post",
											url : "http://localhost:8080/update-user",
											cache : false,
											data : 'userid=' + userid
													+ '&name=' + name
													+ '&password=' + password
													+ '&dob=' + dob
													+ '&roleid=' + roleid
													+ '&email=' + email
													+ '&gender=' + gender
													+ '&address=' + address
													+ '&enabled=' + enabled,
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
		function validDetails() {
			if (document.forms['userForm'].name.value === "") {
				alert("Enter the complete details");
				return false;
			}
			return true;
		}

		function preventBack() {
			window.history.forward();
		}

		setTimeout("preventBack()", 0);
		window.onunload = function() {
			null
		};
	</script>
	<script>
	function sortTable() {
		  var table, rows, switching, i, x, y, shouldSwitch;
		  table = document.getElementById("myTable");
		  switching = true;
		  /*Make a loop that will continue until
		  no switching has been done:*/
		  while (switching) {
		    //start by saying: no switching is done:
		    switching = false;
		    rows = table.rows;
		    /*Loop through all table rows (except the
		    first, which contains table headers):*/
		    for (i = 1; i < (rows.length - 1); i++) {
		      //start by saying there should be no switching:
		      shouldSwitch = false;
		      /*Get the two elements you want to compare,
		      one from current row and one from the next:*/
		      x = rows[i].getElementsByTagName("TD")[0];
		      y = rows[i + 1].getElementsByTagName("TD")[0];
		      //check if the two rows should switch place:
		      if (Number(x.innerHTML) > Number(y.innerHTML)) {
		 		 shouldSwitch = true;
		    	 break;
				}
		    }
		    if (shouldSwitch) {
		      /*If a switch has been marked, make the switch
		      and mark that a switch has been done:*/
		      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
		      switching = true;
		    }
		  }
		}
	</script>
</body>
</html>
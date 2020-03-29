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
	var symptomsId = '';
	var allergyId = '';
	var medicineId = '';
	var patientId = '';
	var quantity = '';
	patientId =
<%=request.getParameter("id")%>
	function myFunction(e) {
		quantity = $('#quantity').val();
	}
	function Symptoms(e) {
		symptomsId = e.options[e.selectedIndex].value;
	};
	function Allergies(e) {
		allergyId = e.options[e.selectedIndex].value;
	};
	function Medicines(e) {
		medicineId = e.options[e.selectedIndex].value;
	};

	$(function() {
		$("#submit")
				.click(
						function() {
							$
									.ajax({
										type : "post",
										url : "http://localhost:8080/edit-patient/add-details",
										cache : false,
										data : 'patientId=' + patientId
												+ '&symptomsId=' + symptomsId
												+ '&allergyId=' + allergyId
												+ '&medicineId=' + medicineId,
										success : function(response) {
											alert('Record Added Successfully for patient ID:'
													+ patientId);
											window.location = 'http://localhost:8080/edit-patient?id='
													+ patientId;
										},
										error : function() {
											alert('Please Select the Options..');
										}
									});
							$
									.ajax({
										type : "post",
										url : "http://localhost:8080/edit-patient/update-stocks",
										cache : false,
										data : 'medicineId=' + medicineId
												+ '&quantity=' + quantity,
										success : function(response) {
											window.location = 'http://localhost:8080/edit-patient?id='
													+ patientId;
										},
										error : function() {
										}
									});
						});
	});
	function validStocks() {
		if (document.forms['medicineForm'].stocks.value === "") {
			alert("Enter the Stocks");
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
</head>

<body>
	<%
		ResourceBundle resourceBundle = ResourceBundle.getBundle("com.cerner.i18n.content", request.getLocale());
	%>
	<div role="navigation">
		<div class="navbar_inverse">
			<a class="navbar-brand">DOCTOR-HOME</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="/homepage">Patient List</a></li>
					<li><a href="/profile">My Profile</a></li>
					<li><a href="/show-medicines">Medicines</a></li>
					<li><a href="/logout">Logout</a></li>
				</ul>
			</div>
		</div>
	</div>

	<c:choose>
		<c:when test="${mode=='MODE_HOME' }">
			<div class="container" id="homediv">
				<div class="jumbotron text-center">
					<h1><%=resourceBundle.getString("doctorHomePage")%></h1>
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
						Hello Dr
						<%=patientRs.getString("name")%></h2>
					<%
						}
					%>
				</div>
			</div>
		</c:when>
		<c:when test="${mode=='MODE_HOME1' }">
			<div class="container" id="homediv">
				<h2>List of Patients</h2>
				<div class="table-responsive">
					<input type="search" placeholder="Search"
						class="form-control search-input" data-table="patients-list" />
					<hr>
					<table class="table table-striped mt32 patients-list">
						<thead>
							<tr>
								<th>User ID</th>
								<th>Name</th>
								<th>Email</th>
								<th>DOB</th>
								<th>Gender</th>
								<th>Address</th>
								<th>Add Prescription</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="user" items="${users}">
								<tr>
									<td>${ user.userid}</td>
									<td>${ user.name}</td>
									<td>${ user.email}</td>
									<td>${ user.dob}</td>
									<td>${ user.gender}</td>
									<td>${ user.address}</td>
									<td><a href="/edit-patient?id=${ user.userid }"><span
											class="glyphicon glyphicon-plus"
											style="font-size: 20px; color: green"></span></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<script>
				<script>
				$(document).ready(function() {
					$('#data1').DataTable();
					$('.dataTables_length').addClass('bs-select');
				});

				(function(document) {
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
									myArray.forEach.call(inputs,
											function(input) {
												input.oninput = _onInputSearch;
											});
								}
							};
						})(Array.prototype);
						document.addEventListener('readystatechange',
								function() {
									if (document.readyState === 'complete') {
										TableFilter.init();
									}
								});
					})(document);
				</script>
		</c:when>

		<c:when test="${mode=='PATIENT_UPDATE' }">
			<%
				String patientUserId = (String) session.getAttribute("patientId");
						int pId = Integer.parseInt(patientUserId);
						Class.forName("com.mysql.cj.jdbc.Driver");
						PreparedStatement patientPs = con
								.prepareStatement("select name,dob,email from users where userid=?");
						patientPs.setInt(1, pId);
						ResultSet patientRs = patientPs.executeQuery();
						while (patientRs.next()) {
			%>
			<h5 style="width: 220px;">
				Patient Name &nbsp; :<strong><font color="green"><%=patientRs.getString("name")%></font></strong>
			</h5>
			<h5 style="width: 220px;">
				Patient DOB &nbsp; &nbsp;&nbsp;&nbsp;:<strong><font
					color="green"><%=patientRs.getString("dob")%></font></strong>
			</h5>
			<h5 style="width: 220px;">
				Email:<strong><font color="green"><%=patientRs.getString("email")%></font></strong>
			</h5>
			<%
				}
			%>
			<div class="container text-center">
				<h3>Add Prescription Details</h3>
				<div class="table-responsive">
					<table class="table table-striped mt32" id="tb">
						<thead>
							<tr>
								<th>Symptoms</th>
								<th>Allergies</th>
								<th>Medicines</th>
								<th>Medicine Quantity</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<%
										Class.forName("com.mysql.cj.jdbc.Driver");
												PreparedStatement s_ps = con.prepareStatement("SELECT * FROM symptoms");
												ResultSet s_rs = s_ps.executeQuery();
									%> <select onchange="Symptoms(this);" class="form-control">
										<option value="" disabled selected>Choose symptoms</option>
										<%
											while (s_rs.next()) {
														String symptoms_id = s_rs.getString("symptoms_id");
														String symptoms_name = s_rs.getString("symptoms_name");
										%>
										<option value="<%=symptoms_id%>"><%=symptoms_name%></option>
										<%
											}
										%>
								</select>
								</td>
								<td>
									<%
										Class.forName("com.mysql.cj.jdbc.Driver");
												PreparedStatement a_ps = con.prepareStatement("SELECT * FROM allergies");
												ResultSet a_rs = a_ps.executeQuery();
									%> <select onchange="Allergies(this);" class="form-control">
										<option value="" disabled selected>Choose allergies</option>
										<%
											while (a_rs.next()) {
														String allergy_id = a_rs.getString("allergy_id");
														String allergy_name = a_rs.getString("allergy_name");
										%>
										<option value="<%=allergy_id%>"><%=allergy_name%></option>
										<%
											}
										%>
								</select>
								</td>
								<td>
									<%
										Class.forName("com.mysql.cj.jdbc.Driver");
												PreparedStatement m_ps = con.prepareStatement("SELECT medicine_id,medicine_name FROM medicine");
												ResultSet m_rs = m_ps.executeQuery();
									%> <select onchange="Medicines(this);" class="form-control">
										<option value="" disabled selected>Choose medicine</option>
										<%
											while (m_rs.next()) {
														String medicine_id = m_rs.getString("medicine_id");
														String medicine_name = m_rs.getString("medicine_name");
										%>
										<option value="<%=medicine_id%>"><%=medicine_name%></option>
										<%
											}
										%>
								</select>
								</td>
								<td><input class="form-control" id="quantity"
									name="quantity" type="number" min="1" max="100"
									onchange="myFunction(this)"></td>
							</tr>
						</tbody>
					</table>
					<input type="submit" name="submit" id="submit" value="Add"
						class="btn btn-success" style="font-size: 16px" />
				</div>
				<%
					String patientId = request.getParameter("id");
							session.setAttribute("patientId", patientId);
				%>

				<%
					Class.forName("com.mysql.cj.jdbc.Driver");
							PreparedStatement patient_ps = con.prepareStatement(
									"SELECT symptoms.symptoms_name,allergies.allergy_name,medicine.medicine_name FROM patient,symptoms,allergies,medicine where patient.symptoms_id=symptoms.symptoms_id and  patient.allergy_id=allergies.allergy_id and patient.medicine_id=medicine.medicine_id and patient.patient_id=?");
							patient_ps.setString(1, patientId);
							ResultSet patient_rs = patient_ps.executeQuery();
				%>
				<div align="center">
					<table class="table table-striped mt32">
						<tr>
							<th>Symptom Name</th>
							<th>Allergy Name</th>
							<th>Medicine Name</th>
						</tr>
						<%
							while (patient_rs.next()) {
						%>
						<tr>
							<td><%=patient_rs.getString("symptoms_name")%></td>
							<td><%=patient_rs.getString("allergy_name")%></td>
							<td><%=patient_rs.getString("medicine_name")%></td>
						</tr>
						<%
							}
									con.close();
						%>
					</table>
				</div>
			</div>
		</c:when>

		<c:when test="${mode=='SHOW_DETAILS' }">
			<div class="container" id="homediv">
				<h2>Edit Profile Details</h2>
				<div class="table-responsive">
					<hr>
					<table class="table table-striped mt32">
						<thead>
							<tr>
								<th>Doctor Id</th>
								<th>Name</th>
								<th>Password</th>
								<th>Gender</th>
								<th>Email</th>
								<th>DOB</th>
								<th>Address</th>
								<th>Department</th>
								<th>Qualifcation</th>
								<th>Experience(in years)</th>
								<th>Edit Details</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${ doctors.userid}</td>
								<td>${ doctors.name}</td>
								<td>${ doctors.password }</td>
								<td>${ doctors.gender}</td>
								<td>${ doctors.email}</td>
								<td>${ doctors.dob}</td>
								<td>${ doctors.address}</td>
								<td>${ doctorDetails.department }</td>
								<td>${ doctorDetails.qualification }</td>
								<td>${ doctorDetails.experience }</td>
								<td><a href="/update-doctor?id=${ doctors.userid }"><span
										class="glyphicon glyphicon-pencil"
										style="font-size: 20px; color: green"></span></a></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</c:when>

		<c:when test="${mode=='PROFILE_UPDATE' }">
			<div class="container text-center">
				<h3>Update profile details</h3>
				<hr>
				<form id="updateDetails" class="form-horizontal"
					data-toggle="validator" method="POST" action="/update-doctor"
					novalidate>
					<div class="form-group">
						<label class="control-label col-md-3">Doctor id</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="doctorid"
								value="${cookie.userid.value }" readonly="readonly" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Name</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="name" id="name"
								value="${doctors.name }" required disabled="disabled"
								data-error="Please enter your name." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Password</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="password"
								id="password" value="${doctors.password }" required
								disabled="disabled" data-error="Please enter the password." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Gender</label>
						<div class="col-md-3">
							<input type="text" class="form-control" name="gender" id="gender"
								value="${doctors.gender }" pattern="M/F" required
								disabled="disabled" data-error="Please enter phone number." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Email</label>
						<div class="col-md-7">
							<input type="email" class="form-control" name="email" id="email"
								value="${doctors.email }" required disabled="disabled"
								data-error="Please enter your email." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">DOB</label>
						<div class="col-md-3">
							<input type="date" class="form-control" name="dob" id="dob"
								value="${doctors.dob }" required disabled="disabled"
								data-error="Please enter your date of birth." />
							<div class="help-block with-errors"></div>
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Address</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="address"
								id="address" value="${doctors.address }" required
								disabled="disabled" data-error="Please enter your address." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Department</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="department"
								id="department" value="${ doctorDetails.department }" required
								disabled="disabled" data-error="Please enter your department." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Qualification</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="qualification"
								id="qualification" value="${ doctorDetails.qualification }"
								required disabled="disabled"
								data-error="Please enter your qualification." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Experience</label>
						<div class="col-md-7">
							<input type="number" min="1" max="50" class="form-control"
								name="experience" id="experience"
								value="${ doctorDetails.experience }" required
								disabled="disabled" data-error="Please enter your experience." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group ">
						<input type="submit" class="btn btn-success" value="Save" /> <input
							type="button" class="btn btn-warning" value="Start Editing"
							onclick="enableEditing();" />
					</div>
				</form>
			</div>
			<script>
				function enableEditing() {
					$('#name').removeAttr("disabled");
					$('#password').removeAttr("disabled");
					$('#gender').removeAttr("disabled");
					$('#email').removeAttr("disabled");
					$('#dob').removeAttr("disabled");
					$('#address').removeAttr("disabled");
					$('#department').removeAttr("disabled");
					$('#qualification').removeAttr("disabled");
					$('#experience').removeAttr("disabled");
				}
			</script>
		</c:when>

		<c:when test="${mode=='ALL_MEDICINES' }">
			<div class="container text-center" id="tasksDiv">
				<h2>List of Medicines</h2>
				<div class="form-group ">
					<input type="submit" class="btn btn-success" value="+ Add Medicine"
						data-toggle="modal" data-target="#modalForm"
						onclick="addMedicine();" />
					<div class="modal fade" id="modalForm" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<!-- Modal Header -->
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title" id="myModalLabel">Adding New
										Medicines</h4>
								</div>

								<!-- Modal Body -->
								<div class="modal-body">
									<p class="statusMsg"></p>
									<form role="form">
										<div class="form-group">
											<label for="medicineName">Medicine Name</label> <input
												type="text" class="form-control" id="medicineName"
												placeholder="Enter Medicine Name" />
										</div>
										<div class="form-group">
											<label for="stocks">Medicine Stocks</label> <input
												type="number" min="1" max="500" class="form-control"
												id="stocks" placeholder="Enter Medicine Stocks" />
										</div>
									</form>
								</div>

								<!-- Modal Footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
									<button type="button" class="btn btn-warning submitBtn"
										onclick="addMedicineForm()">Add</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="table-responsive" style="text-align: left;">
					<hr>
					<table id="data" class="table table-striped mt32">
						<thead>
							<tr>
								<th>Medicine Id</th>
								<th>Medicine Name</th>
								<th>Stocks</th>
								<th>Delete</th>
								<th>Update Stocks</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="medicine" items="${medicines}">
								<tr>
									<td>${ medicine.medicineId}</td>
									<td>${ medicine.medicineName}</td>
									<td>${ medicine.stocks}</td>
									<td><a href="/delete-medicine?id=${ medicine.medicineId }"><span
											class="glyphicon glyphicon-trash"
											style="font-size: 20px; color: red"></span></a></td>
									<td><a href="/edit-medicine?id=${ medicine.medicineId }"><span
											class="glyphicon glyphicon-pencil"
											style="font-size: 20px; color: darkblue"></span></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<script>
				function addMedicine() {
					$('#medicineName').val('');
					$('#stocks').val('');
					$("#yes").hide();
				}

				function addMedicineForm() {
					var medicineName = $('#medicineName').val();
					var stocks = $('#stocks').val();
					if (medicineName.trim() == '') {
						$('.statusMsg')
								.html(
										'<div id="yes" class= "alert alert-danger">Please Enter Medicine Name.</div>');
						$('#medicineName').focus();
						return false;
					} else if (stocks.trim() == '') {
						$('.statusMsg')
								.html(
										'<div id="yes" class= "alert alert-danger">Please Enter Medicine Stocks.</div>');
						$('#stocks').focus();
						return false;
					} else {
						$
								.ajax({
									type : 'POST',
									url : 'http://localhost:8080/add-medicine',
									data : 'medicineName=' + medicineName
											+ '&stocks=' + stocks,
									beforeSend : function() {
										$('.submitBtn').attr("disabled",
												"disabled");
										$('.modal-body').css('opacity', '.5');
									},
									success : function(msg) {
										$('.statusMsg')
												.html(
														'<div id="yes" class= "alert alert-success">Medicine Added Successfully.</div>');
										$('#medicineName').val('');
										$('#stocks').val('');
										$('.submitBtn').removeAttr("disabled");
										$('.modal-body').css('opacity', '');
									},
									error : function() {
										$('.statusMsg')
												.html(
														'<div class="alert alert-danger">Some problem occurred, please try again.</div>');
									}
								});
					}
				}
				$(document).ready(function() {
					$('#data').DataTable();
					$('.dataTables_length').addClass('bs-select');
				});
			</script>
		</c:when>

		<c:when test="${mode=='MODE_UPDATE' }">

			<%
				int medicineId = (int) session.getAttribute("medicineId");
						Class.forName("com.mysql.cj.jdbc.Driver");
						PreparedStatement medicinePs = con.prepareStatement(
								"select medicine_id,medicine_name,stocks from medicine where medicine_id=?");
						medicinePs.setInt(1, medicineId);
						ResultSet medicineRs = medicinePs.executeQuery();
						while (medicineRs.next()) {
			%>
			<div class="container text-center">
				<h3>Add medicine stocks</h3>
				<hr>
				<form name="medicineForm" class="form-horizontal" method="POST"
					action="save-medicine" onsubmit="return validStocks();">
					<c:if test="${not empty msg}">
						<div id="success" class="alert alert-success">${msg}</div>
					</c:if>
					<input type="hidden" name="id" value="${ medicine.medicineId }" />
					<div class="form-group">
						<label class="control-label col-md-3">Medicine ID</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="medicineId"
								value="<%=medicineRs.getInt("medicine_id")%>"
								readonly="readonly" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Medicine Name</label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="medicine_name"
								value="<%=medicineRs.getString("medicine_name")%>"
								readonly="readonly" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Existing Stocks</label>
						<div class="col-md-3">
							<input type="text" class="form-control" name="existingStocks"
								value="<%=medicineRs.getInt("stocks")%>" readonly="readonly" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Add Stocks</label>
						<div class="col-md-3">
							<input type="number" min="1" max="100" class="form-control"
								name="stocks" id="stocks" value="${medicine.stocks }" />
						</div>
					</div>
					<div class="form-group ">
						<input type="submit" class="btn btn-success" value="Update Stocks" />
						<button type="button" class="btn btn-danger"
							value="Back to Medicine List"
							onclick="window.location.href = '/show-medicines';">Back
							to medicines list</button>
					</div>
				</form>
			</div>
			<%
				}
			%>
		</c:when>

	</c:choose>

	<script src="static/js/jquery-1.11.1.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
</body>
</html>
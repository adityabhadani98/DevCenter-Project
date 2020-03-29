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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
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
			<div class="container text-center">
				<h3><%=resourceBundle.getString("ScheduleAppointmentforpatientwithdoctor")%></h3>

				<form id="temp1" name="temp1" class="form-horizontal" method="POST" action="">
					<%
						Class.forName("com.mysql.cj.jdbc.Driver");
								PreparedStatement s_ps = con.prepareStatement(
										"SELECT u.userid,u.name FROM users u where u.roleid='R2' and u.enabled=1");
								ResultSet s_rs = s_ps.executeQuery();
					%>
					<select class="form-control" name="patient_id" id="patient_id"
						required style="margin-top: 50px;">
						<option value="${appointment.patient_id }" disabled selected><%=resourceBundle.getString("selectPatient")%></option>
						<%
							while (s_rs.next()) {
										String patient_id = s_rs.getString("userid");
										String patient_name = s_rs.getString("name");
						%>
						<option value="<%=patient_id%>"
						<%
								if((request.getParameter("patient_id")!=null))	
								{
									if(s_rs.getInt("userid")==Integer.parseInt(request.getParameter("patient_id")))
									{
										out.print("selected");
									}
								}
							%>
						><%=patient_name%></option>
						<%
							}
						%>
					</select>

					<%
						Class.forName("com.mysql.cj.jdbc.Driver");
								PreparedStatement a_ps = con.prepareStatement("SELECT distinct department FROM doctor");
								ResultSet a_rs = a_ps.executeQuery();
					%>
					<select class="form-control" id="sel" name="sel" required onchange="this.form.submit();">
						<option disabled selected><%=resourceBundle.getString("selectDoctorSpecialization")%></option>
						<%
							while (a_rs.next()) {
										String doc_dept = a_rs.getString("department");
						%>
						<option value="<%=doc_dept%>"
						<%
								if((request.getParameter("sel")!=null))	
								{
									if(a_rs.getString("department").equalsIgnoreCase(request.getParameter("sel")))
									{
										out.print("selected");
									}
								}
							%>
						><%=doc_dept%></option>
						<%
							}
						%>
					</select>
				</form>

				<form id="temp2" name="temp2" class="form-horizontal" method="POST" action="">
					<%
						Class.forName("com.mysql.cj.jdbc.Driver");
								PreparedStatement c_ps = con.prepareStatement(
										"SELECT d.doctorId,u.name FROM users u,doctor d where u.roleid='R3' and u.enabled=1 and u.userid=d.doctorId and d.department=?");
								c_ps.setString(1, request.getParameter("sel"));
								ResultSet c_rs = c_ps.executeQuery();
					%>
					<select class="form-control" name="doctorid" id="doctorid" required
						style="margin-top: 25px;">
						<option value="${appointment.doctorid }" disabled selected><%=resourceBundle.getString("selecttheDoctorName")%></option>
						<%
							while (c_rs.next()) {
										String doctorid = c_rs.getString("doctorId");
										String doctorname = c_rs.getString("name");
						%>
						<option value="<%=doctorid%>"
						<%
								if((request.getParameter("doctorid")!=null))	
								{
									if(c_rs.getString("doctorId").equalsIgnoreCase(request.getParameter("doctorid")))
									{
										out.print("selected");
									}
								}
							%>
						>Dr <%=doctorname%></option>
						<%
							}
						%>

					</select> 
					<input class="form-control" id="date" name="date" required type="date" min="2020-03-30" max="2021-03-30">
						
				</form>

				<%
					Class.forName("com.mysql.cj.jdbc.Driver");
							String date = request.getParameter("date");
							String doctor_id = request.getParameter("doctorid");
							PreparedStatement b_ps = con.prepareStatement(
									"SELECT slot,start_time,end_time from slots where slot not in (SELECT slot from appointments where status='Scheduled' and date=? and doctorid=?)");
							b_ps.setString(1, date);
							b_ps.setString(2, doctor_id);
							ResultSet b_rs = b_ps.executeQuery();
				%>
				<select class="form-control" name="slot" id="slot"
					style="margin-top: 25px; margin-bottom: 50px" required>
					<option value="${appointment.slot }" disabled selected><%=resourceBundle.getString("selectTimeSlot")%></option>
					<%
						while (b_rs.next()) {
									String ts = b_rs.getString("slot");
									String ts1 = b_rs.getString("start_time");
									String ts2 = b_rs.getString("end_time");
					%>
					<option value="<%=ts%>"><%=ts1%>-<%=ts2%></option>
					<%
						}
					%>
				</select>
				<input type="button" class="btn btn-primary" id="btn" name="btn" value="Set Appointment" onclick="finalSubmit()"/>
			</div>
			<script type="text/javascript">
				var global1="";
				var global2="";
				var global3="";
				var global4="";
				$("#date").change(function() {
					global1=$('#patient_id').val();
					sessionStorage.setItem("pId",global1);
					
					global2=$('#sel').val();
					sessionStorage.setItem("dept",global2);
					
					global3=$('#doctorid').val();
					sessionStorage.setItem("dId",global3);
					
					global4=$('#date').val();
					sessionStorage.setItem("date",global4);
					
				    this.form.submit();
				});
				
				function finalSubmit(){
					var g1=sessionStorage.getItem("pId");
					var dept=sessionStorage.getItem("dept");
					var dId=sessionStorage.getItem("dId");
					var date=sessionStorage.getItem("date");
					var slot=$('#slot').val();
			
					alert("The appointment details are:\nPatient ID: "+g1+"\nDoctor Department: "+dept+"\nDoctor ID: "+dId+"\nDate of Appointment: "+date+"\nSlot name: "+slot);
					$.ajax({
						type : "post",
						url : "http://localhost:8080/save-appointment",
						cache : false,
						data : 'doctorid=' + dId
								+ '&patient_id=' + g1
								+ '&date=' + date
								+ '&slot=' + slot,
						success : function(response) {
							alert('Record updated Successfully for Patient ID:'
									+ g1);
							window.location = 'http://localhost:8080/app2';
						},
						error : function() {
							alert('Please Select the Options..');
						}
					});  
				}
			</script>
		</c:when>
		
		<c:when test="${mode=='ALL_APPOINTMENTS' }">

			<div class="container text-center" id="tasksDiv">
				<h3><%=resourceBundle.getString("allAppointments")%></h3>
				<hr>
				<%
					Class.forName("com.mysql.cj.jdbc.Driver");
							PreparedStatement patient_ps = con.prepareStatement(
									"SELECT appointments.appointment_id,users.name,patient.patient_name,slots.start_time, slots.end_time,appointments.status from appointments,users,slots,patient where appointments.slot=slots.slot and appointments.doctorid=users.userid and appointments.patient_id=patient.patient_id");
							PreparedStatement patient_ps1 = con.prepareStatement(
									"SELECT DATE_FORMAT(appointments.date, '%d-%b-%Y') as date from appointments");
							ResultSet patient_rs = patient_ps.executeQuery();
							ResultSet patient_rs1 = patient_ps1.executeQuery();
				%>
				<div class="table-responsive">
					<input type="text" id="myInput" class="form-control search-input"
						placeholder="Search for names.." title="Type in a name"
						data-table="appointments-list">
					<h4 style="text-align: left">Select number of rows</h4>
					<div class="form-group">
						<select name="state1" id="maxRows1" class="form-control"
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
								<th style="text-align: center"><%=resourceBundle.getString("appointmentID")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("doctorName")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("patientName")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("dateOfAppointment")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("startTime")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("endTime")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("appointmentStatus")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("delete")%></th>
								<th style="text-align: center"><%=resourceBundle.getString("edit")%></th>
							</tr>
						</thead>
						<%
							while (patient_rs.next() && patient_rs1.next()) {
						%>
						<tbody>
							<tr>
								<td style="text-align: center"><%=patient_rs.getString("appointment_id")%></td>
								<td style="text-align: center">Dr <%=patient_rs.getString("name")%></td>
								<td style="text-align: center"><%=patient_rs.getString("patient_name")%></td>
								<td style="text-align: center"><%=patient_rs1.getString("date")%></td>
								<td style="text-align: center"><%=patient_rs.getString("start_time")%></td>
								<td style="text-align: center"><%=patient_rs.getString("end_time")%></td>
								<td style="text-align: center"><%=patient_rs.getString("status")%></td>
								<td><a
									href="/delete-appointment?id=<%=patient_rs.getString("appointment_id")%>"><span
										style="margin: auto; display: data1;"
										class="glyphicon glyphicon-trash"></span></a></td>
								<td><a
									href="/edit-appointment?id=<%=patient_rs.getString("appointment_id")%>"><span
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
		
		<c:when test="${mode=='MODE_UPDATE' }">
			<h3 style="text-align: center"><%=resourceBundle.getString("updateAppointmentDetails")%></h3>
			<div class="container text-center">
				<%
					String appointmentid = (String) session.getAttribute("appointment_id");
							int uid = Integer.parseInt(appointmentid);
							Class.forName("com.mysql.cj.jdbc.Driver");
							PreparedStatement appointment_ps = con.prepareStatement(
									"select u.appointment_id,u.doctorid,u.patient_id,u.date,u.slot,u.status from appointments u where u.appointment_id=?");
							appointment_ps.setInt(1, uid);
							ResultSet appointment_rs = appointment_ps.executeQuery();
							while (appointment_rs.next()) {
				%>
				<hr>

				<form name="appointmentForm" id="updateDetails" class="form-horizontal"
					method="POST" action="update-appointment" onsubmit="return validDetails();">
					<input type="hidden" name="id" value="${appointment.appointment_id }" />
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("appointmentID")%></label>
						<div class="col-md-7">
							<input type="number" class="form-control" name="appointment_id" id="appointment_id"
								value="<%=appointment_rs.getString("appointment_id")%>" readonly="readonly" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("doctorId")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="doctorid" id="doctorid"
								value="<%=appointment_rs.getString("doctorid")%>" required
								data-error="Please enter your doctor ID." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("patientId")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="patient_id"
								id="patient_id" value="<%=appointment_rs.getString("patient_id")%>"
								required data-error="Please enter the patient ID." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("dateOfAppointment")%></label>
						<div class="col-md-3">
							<input type="date" class="form-control" name="date" id="date"
								value="<%=appointment_rs.getString("date")%>" required
								data-error="Please enter correct date of appointment." min="2020-03-30" max="2021-03-30"/>
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("slot")%></label>
						<div class="col-md-7">
							<input type="text" class="form-control" name="slot" id="slot"
								value="<%=appointment_rs.getString("slot")%>" required
								data-error="Please enter your slot name." />
							<div class="help-block with-errors"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3"><%=resourceBundle.getString("appointmentStatus")%></label>
						<div class="col-md-3">
							<input type="text" class="form-control" name="status" id="status"
								value="<%=appointment_rs.getString("status")%>" required 
								data-error="Please enter the status of your appointment." />
							<div class="help-block with-errors"></div>
						</div>
					</div>

					<div class="form-group ">
						<input type="submit" class="btn btn-primary"
							value="<%=resourceBundle.getString("updateAppointment")%>" />
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
		var appointment_id = $('#appointment_id').val();
		var doctorid = $('#doctorid').val();
		var patient_id = $('#patient_id').val();
		var date = $('#date').val();
		var slot = $('#slot').val();
		var status = $('#status').val();

		$(function() {
			$("#submit")
					.click(
							function() {
								$
										.ajax({
											type : "post",
											url : "http://localhost:8080/update-appointment",
											cache : false,
											data : 'appointment_id=' + appointment_id
													+ '&doctorid=' + doctorid
													+ '&patient_id=' + patient_id
													+ '&date=' + date
													+ '&slot=' + slot
													+ '&status=' + status,
											success : function(response) {
												alert('Record updated Successfully for Appointment ID:'
														+ userid);
												window.location = 'http://localhost:8080/update-appointment?id='
														+ appointment_id;
											},
											error : function() {
												alert('Please Select the Options..');
											}
										});
							});
		});
		function validDetails() {
			if (document.forms['appointmentForm'].name.value === "") {
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
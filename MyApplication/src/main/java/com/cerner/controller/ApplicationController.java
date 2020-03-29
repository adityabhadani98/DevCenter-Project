package com.cerner.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cerner.model.Appointment;
import com.cerner.model.Doctor;
import com.cerner.model.User;
import com.cerner.services.AppointmentService;
import com.cerner.services.DoctorService;
import com.cerner.services.PatientService;
import com.cerner.services.UserService;

/*
 * @Controller is typically used in combination with a 
   @RequestMapping annotation used on request handling methods.
*/

/**
 * The Class ApplicationController
 * 
 * @author AB078404
 */

@Controller
public class ApplicationController {

	// The user and doctor service.
	// it is used for adding class dependencies.
	@Autowired
	UserService userService;
	
	@Autowired
	AppointmentService appointmentService;
	
	@Autowired
	PatientService patientService;
	
	@Autowired
	DoctorService doctorService;


	@RequestMapping("/welcome")
	public String Welcome(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setAttribute("mode", "MODE_HOME");
		return "welcome_page";
	}

	@RequestMapping("/login")
	public String login(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_HOME");
		return "login_page";
	}

	/**
	 * Logout from admin,patient or doctor page
	 * 
	 * @param request       the request
	 * @param BindingResult holds the result of a validation and binding and
	 *                      contains errors that may have occurred
	 *  @param request       the request
	 *  @return the admin_page
	 *  This method deinitializes the cookie with the particular userid
	 */
	@RequestMapping("/logout")
	public String Logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Cookie[] cookies = request.getCookies();
		for (int i = 0; i < cookies.length; ++i) {
			if (cookies[i].getName().equals("userid")) {
				cookies[i].setMaxAge(0);
				response.addCookie(cookies[i]);
				break;
			}
		}

		request.setAttribute("mode", "MODE_HOME");
		return "welcome_page";
	}


	/**
	 * Register a user into the database
	 * 
	 *  @return the admin_page
	 *  Redirection method
	 */
	@RequestMapping("/register_user")
	public String registration_user(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_REGISTER");
		return "admin_page";
	}

	/**
	 * Save user.
	 * 
	 * @param get           the user instance
	 * @param request       the request
	 * @param BindingResult holds the result of a validation and binding and
	 *                      contains errors that may have occurred
	 * @return the admin_page
	 */
	@PostMapping("/save-user") // post mapping to post into the database
	public String registerUser(@ModelAttribute User user, BindingResult bindingResult, HttpServletRequest request) {
		userService.saveMyUser(user);
		request.setAttribute("mode", "MODE_HOME");
		return "admin_page";
	}    
	
	/**
	 * Show all users
	 *
	 * @param request the request
	 * @return the admin_page.jsp page
	 */
	
	@GetMapping("/show-users")
	public String showAllUsers(HttpServletRequest request) {
		request.setAttribute("users", userService.showAllUsers());
		request.setAttribute("mode", "ALL_USERS");
		return "admin_page";
	}

	/**
	 * Delete a user
	 *
	 * @param id of the user whose enabled field should be 0
	 * @return the admin_page.jsp page
	   This function updates the enabled field in users table in schema
	 */
	@RequestMapping("/delete-user")
	public String deleteUser(@RequestParam int id, HttpServletRequest request) {
		userService.deleteMyUser(id);
		request.setAttribute("users", userService.showAllUsers());
		request.setAttribute("mode", "ALL_USERS");
		return "admin_page";
	}

	/**
	 * Edit the user: redirects to the page where admin can enter new user details
	 * and to update details.
	 *
	 * @param request the request
	 * @return the admin_page.jsp page
	 */
	@RequestMapping("/edit-user")
	public String editUser(@RequestParam String id, HttpSession session, HttpServletRequest request) {
		session.setAttribute("userid", id);
		request.setAttribute("mode", "MODE_UPDATE");
		return "admin_page";
	}
	
	/**
	 * Update the user details: contains a function updateMyUser which will call the
	 * service class to update user details.
	 *
	 * @param the     parameters of the user instance
	 * @param request the request
	 * @return the admin_page.jsp page
	 */
	@RequestMapping(value = "/update-user", method = RequestMethod.POST) //// post mapping to post into the database
	public String updateUser(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		int id = Integer.parseInt(request.getParameter("userid"));
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String dob = request.getParameter("dob");
		String roleid = request.getParameter("roleid");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		String address = request.getParameter("address");
		int enabled = Integer.parseInt(request.getParameter("enabled"));
		userService.updateMyUser(id, name, password, dob, roleid, email, gender, address, enabled);
		request.setAttribute("users", userService.showAllUsers());
		request.setAttribute("mode", "ALL_USERS");
		return "admin_page";
	}

	/**
	 * Login-user
	 *
	 * @param request the request
	 * @param session the user session which transmits information from jsp to controller
	 * @return the admin_page, doctor_page, patient_page according to credentials
	 */
	@RequestMapping(value = "/login-user",method = RequestMethod.POST)
	public String loginUser(@ModelAttribute User user, HttpServletRequest request, HttpServletResponse response,Model model, HttpSession session) {
		String userid = request.getParameter("userid");
		session.setAttribute("userid", userid);
		Cookie cookie = new Cookie("userid", userid);
		response.addCookie(cookie);
		int temp = userService.findByUseridAndPassword(user.getUserid(), user.getPassword());
		if (temp == 1) {
			request.setAttribute("mode", "MODE_HOME");
			return "admin_page";
		}
		else if (temp == 2) {
			request.setAttribute("mode", "MODE_HOME");
			return "patient_page";
		}
		else if (temp == 3) {
			request.setAttribute("mode", "MODE_HOME");
			return "homepage";
		}
		else {
			request.setAttribute("error", "Invalid Userid or Password");
			request.setAttribute("mode", "MODE_HOME");
			return "login_page";
		}
	}

	@RequestMapping("/app1")
	public String new_appointment(HttpServletRequest request) {
		request.setAttribute("mode", "MODE_HOME");
		return "appointment_page";
	}

	
	/**
	 * Save appointment
	 * 
	 * @param Model 		instance where corresponds to appointment model class
	 * @param get           the appointment instance
	 * @param request       the request
	 * @param BindingResult holds the result of a validation and binding and
	 *                      contains errors that may have occurred
	 * @return the admin_page
	 */
	@RequestMapping(value = "/save-appointment", method = RequestMethod.POST) // post mapping to post into the database
	public String registerAppointment(HttpServletRequest request, HttpServletResponse response) 
			throws IOException, ServletException {
		int doctorid = Integer.parseInt(request.getParameter("doctorid"));
		int patient_id = Integer.parseInt(request.getParameter("patient_id"));
		String date = request.getParameter("date");
		String slot = request.getParameter("slot");
		appointmentService.saveAppointment(doctorid, patient_id, date, slot);
		request.setAttribute("mode", "ALL_APPOINTMENTS");
		return "admin_page";
		
		/* List<Appointment> appointments = appointmentService.showAllAppointments();
		for (Appointment ap : appointments ) {
			if (ap.getDoctorid() == doctorid && ap.getSlot().equals(slot) && ap.getDate().equals(date)) {
				request.setAttribute("error", "Please change appointment details");
				request.setAttribute("mode", "MODE_HOME");
				return "appointment_page";
			}
		} */
	}
	
	/**
	 * Show all appointments
	 *
	 * @param request the request
	 * @return the admin_page.jsp page
	 */
	@GetMapping("/app2")
	public String showAllAppointments(HttpServletRequest request) {
		request.setAttribute("appointments", appointmentService.showAllAppointments());
		request.setAttribute("mode", "ALL_APPOINTMENTS");
		return "appointment_page";
	}
	
	/**
	 * Show particular patient profile
	 * 
	 * @param Model 		instance where corresponds to patient model class
	 * @param cookieValue   contains cookie which was generated at start of controller
	 * @param request       the request
	 * @param BindingResult holds the result of a validation and binding and
	 *                      contains errors that may have occurred
	 * @return the admin_page
	 */
	@RequestMapping("/patient-profile")
	public String patientProfile(HttpSession session,@CookieValue("userid") int userid,HttpServletRequest request) {
		session.setAttribute("userid", userid);
		request.setAttribute("users", patientService.showAllDetails(userid));
		request.setAttribute("mode", "SHOW_PATIENT_DETAILS");
		return "patient_page";
	}
	
	@RequestMapping(value="/update-patient",method=RequestMethod.GET)
	public String updatePatientDetails(HttpSession session,@CookieValue("userid") int userid,HttpServletRequest request) {
		session.setAttribute("userid", userid);
		request.setAttribute("users",userService.showAllDetails(userid));
		request.setAttribute("mode", "PATIENT_PROFILE_UPDATE");
		return "patient_page";
	}
	
	/**
	 * Update patient details in the database
	 * 
	 * @param Model 		instance where corresponds to user model class
	 * @param cookieValue   contains cookie which was generated at start of controller
	 * @param Model 		instance where corresponds to doctor model class
	 * @param request       the request
	 * @return the admin_page
	 */
	@PostMapping("/update-patient")
	public String editPatientPersonalDetails(@ModelAttribute User user,@CookieValue("userid") int userid, @ModelAttribute Doctor doctor,BindingResult bindingResult,HttpServletRequest request) {
		userService.updatePUser(userid,user.getName(),user.getPassword(),user.getEmail(),user.getDob(),user.getGender(),user.getAddress());
		request.setAttribute("users", userService.showAllDetails(userid));
		request.setAttribute("mode", "SHOW_PATIENT_DETAILS");
		return "patient_page";
	}
	
	/**
	 * Register doctor in doctor table
	 *
	 * @param med     the medicine instance
	 * @param stocks  the medicine stocks
	 * @param request the request
	 * @return the admin_home.jsp page
	 */
	@RequestMapping("/doctor_details")
	public String doc_details(HttpServletRequest request) {
		request.setAttribute("mode", "DOC_DETAILS");
		return "admin_page";
	}
	
	/**
	 * Save doctor
	 * 
	 * @param get           the doctor instance
	 * @param request       the request
	 * @param BindingResult holds the result of a validation and binding and
	 *                      contains errors that may have occurred
	 * @return the admin_page
	 */
	@PostMapping("/save-doctor") // post mapping to post into the database
	public String registerDoctor(@ModelAttribute Doctor doctor,BindingResult bindingResult, HttpServletRequest request) {
		//System.out.println ("FREE BATCH " + doctor.getFree_Batch());
		doctorService.saveMyDoctor(doctor);
		request.setAttribute("mode", "MODE_HOME");
		return "admin_page";
	}
	
	/**
	 * Delete a appointment
	 *
	 * @param id of the appointment whose status field should be changed
	 * @return the admin_page.jsp page
	   This function updates the status field in appointments table in schema
	 */
	@RequestMapping("/delete-appointment")
	public String deleteAppointment(@RequestParam int id, HttpServletRequest request) {
		appointmentService.deleteMyAppointment(id);
		request.setAttribute("appointments", appointmentService.showAllAppointments());
		request.setAttribute("mode", "ALL_APPOINTMENTS");
		return "appointment_page";
	}
	
	/**
	 * Edit the appointment: redirects to the page where admin can enter new appointment details
	 * and to update details.
	 *
	 * @param request the request
	 * @return the appointment_page.jsp 
	 */
	@RequestMapping("/edit-appointment")
	public String editAppointment(@RequestParam String id, HttpSession session, HttpServletRequest request) {
		session.setAttribute("appointment_id", id);
		request.setAttribute("mode", "MODE_UPDATE");
		return "appointment_page";
	}
	
	/**
	 * Update the appointment details: contains a function updateMyAppointment which will call the
	 * service class to update appointment details.
	 *
	 * @param the     parameters of the appointment instance
	 * @param request the request
	 * @return the appointment_page.jsp page
	 */
	@RequestMapping(value = "/update-appointment", method = RequestMethod.POST) //// post mapping to post into the database
	public String updateAppointment(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		int appointment_id = Integer.parseInt(request.getParameter("appointment_id"));
		int doctorid = Integer.parseInt(request.getParameter("doctorid"));
		int patient_id = Integer.parseInt(request.getParameter("patient_id"));
		String date = request.getParameter("date");
		String slot = request.getParameter("slot");
		String status = request.getParameter("status");
		appointmentService.updateMyAppointment(appointment_id, doctorid, patient_id, date, slot, status);
		request.setAttribute("appointments", appointmentService.showAllAppointments());
		request.setAttribute("mode", "ALL_APPOINTMENTS");
		return "appointment_page";
	}
}
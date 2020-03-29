package com.cerner.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.cerner.model.Doctor;
import com.cerner.model.Medicine;
import com.cerner.model.User;
import com.cerner.services.DoctorService;
import com.cerner.services.MedicineService;
import com.cerner.services.PatientService;
import com.cerner.services.UserService;

/* 
 @Controller is typically used in combination with a 
@RequestMapping annotation used on request handling methods.
*/

/*
* The Class DoctorController.
* @author AB078404
*/

@Controller
public class DoctorController {

	// The medicine service.
	// It is used for adding class dependencies.
	@Autowired
	UserService userService;
	
	@Autowired
	PatientService patientService;
	
	@Autowired
	DoctorService doctorService;
	
	@Autowired
	MedicineService medicineService;

	/**
	 * Show all patients.
	 *
	 * @param request the request
	 * @return the homepage.jsp page
	 */
	@RequestMapping("/homepage")
	public String showAllPatients(HttpSession session, @CookieValue("userid") String userid,
			HttpServletRequest request) {
		session.setAttribute("userid", userid);
		request.setAttribute("users", userService.showAllPatients());
		request.setAttribute("mode", "MODE_HOME1");
		return "homepage";
	}

	/**
	 * Edits the patient.
	 *
	 * @param id      the patient id
	 * @param request the request
	 * @return the homepage.jsp page
	 */
	@RequestMapping(value = "/edit-patient", method = RequestMethod.GET)
	public String editPatient(HttpSession session, @RequestParam String id, HttpServletRequest request) {
		session.setAttribute("patientId", id);
		request.setAttribute("mode", "PATIENT_UPDATE");
		return "homepage";
	}
	
	/**
	 * Show particular doctor profile
	 * 
	 * @param session       used to transmit data between controller and jsp
	 * @param cookieValue   contains cookie which was generated at start of controller
	 * @param request       the request
	 * @param BindingResult holds the result of a validation and binding and
	 *                      contains errors that may have occurred
	 * @return the admin_page
	 */
	@RequestMapping("/profile")
	public String profile(HttpSession session,@CookieValue("userid") int userid,HttpServletRequest request) {
		session.setAttribute("userid", userid);
		request.setAttribute("doctors", patientService.showAllDetails(userid));
		request.setAttribute("doctorDetails",doctorService.showAllDetails(userid));
		request.setAttribute("mode", "SHOW_DETAILS");
		return "homepage";
	}
	
	/**
	 * Update doctor details in the database
	 * Request Mapping format
	 * @return the admin_page
	 */
	@RequestMapping(value="/update-doctor",method=RequestMethod.GET)
	public String updateDoctorDetails(HttpSession session,@CookieValue("userid") int userid,HttpServletRequest request) {
		session.setAttribute("userid", userid);
		request.setAttribute("doctors",patientService.showAllDetails(userid));
		request.setAttribute("doctorDetails",doctorService.showAllDetails(userid));
		request.setAttribute("mode", "PROFILE_UPDATE");
		return "homepage";
	}

	/**
	 * Update doctor details in the database
	 * 
	 * @param Model 		instance where corresponds to user model class
	 * @param cookieValue   contains cookie which was generated at start of controller
	 * @param Model 		instance where corresponds to doctor model class
	 * @param request       the request
	 * @return the admin_page
	 */
	@PostMapping("/update-doctor")
	public String editDoctorPersonalDetails(@ModelAttribute User user,@CookieValue("userid") int userid, @ModelAttribute Doctor doctor,BindingResult bindingResult,HttpServletRequest request) {
		patientService.saveUser(userid,user.getName(),user.getPassword(),user.getEmail(),user.getDob(),user.getGender(),user.getAddress());
		doctorService.saveMyDoctor1(userid,doctor.getDepartment(),doctor.getQualification(),doctor.getExperience());
		request.setAttribute("doctors", patientService.showAllDetails(userid));
		request.setAttribute("doctorDetails",doctorService.showAllDetails(userid));
		request.setAttribute("mode", "SHOW_DETAILS");
		return "homepage";
	}
	
	/**
	 * Show all medicines
	 *
	 * @param request the request
	 * @return the homepage.jsp page
	 */
	@GetMapping("/show-medicines") 
	public String showAllUsers(HttpServletRequest request) {
		request.setAttribute("medicines", medicineService.showAllMedicines());
		request.setAttribute("mode", "ALL_MEDICINES");
		return "homepage";
	}
	
	/**
	 * Delete medicine.
	 *
	 * @param id the medicine id
	 * @param request the request
	 * @return the homepage.jsp page
	 */
	@RequestMapping("/delete-medicine")
	public String deleteMedicine(@RequestParam int id, HttpServletRequest request) {
		medicineService.deleteMedicineDetails(id);
		request.setAttribute("medicines", medicineService.showAllMedicines());
		request.setAttribute("mode", "ALL_MEDICINES");
		return "homepage";
	}
	
	/**
	 * Edits the medicine.
	 *
	 * @param id the medicine id
	 * @param request the request
	 * @return the homepage.jsp page
	 */
	@RequestMapping("/edit-medicine")
	public String editMedicine(HttpSession session,@RequestParam int id,HttpServletRequest request) {
		request.setAttribute("medicines", medicineService.editMedicine(id));
		session.setAttribute("medicineId", id);
		request.setAttribute("mode", "MODE_UPDATE");
		return "homepage";
	}
	
	/**
	 * Register medicine.
	 *
	 * @param med the medicine instance
	 * @param stocks the medicine stocks
	 * @param request the request
	 * @return the homepage.jsp page
	 */
	@RequestMapping(value="/save-medicine",method= RequestMethod.POST)
	public String registerMedicine(Medicine med,@RequestParam int stocks,Model model, HttpServletRequest request) {
		medicineService.saveMedicine(med.getMedicineId(),stocks);
		model.addAttribute("msg","Stocks Updated Successfully");
		request.setAttribute("mode", "MODE_UPDATE");
		return "homepage";
	}
}

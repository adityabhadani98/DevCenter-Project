package com.cerner.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cerner.model.Appointment;
import com.cerner.model.Doctor;
import com.cerner.model.User;
import com.cerner.services.DoctorService;
import com.cerner.services.UserService;

/*@RestController is a specialized version of the controller. It includes the @Controller and 
@ResponseBody annotations and as a result, simplifies the controller implementation:*/


/**
 * The Class RestController.
 * @author AB078404
 */

@org.springframework.web.bind.annotation.RestController
public class RestController {
	@Autowired 
	private UserService userService;
	
	@Autowired
	private DoctorService doctorService;
	
	/**
	 * Home.
	 *
	 * @return the string with message 
	 */
	@GetMapping("/")
	public String hello() {
		return "This is the home page";
	}
	
	/**
	 * Save data into 'users' table
	 *
	 * @param userid,name,password, dob, roleid, email, enabled, gender, roleid, address 
	 * 		  of the user instance
	 * @return console message 'user saved'
	 */
	@GetMapping("/save-user")
	public String saveUser(@RequestParam int userid, @RequestParam String name, @RequestParam String password, @RequestParam String dob, @RequestParam String roleid, @RequestParam String email, @RequestParam int enabled, @RequestParam String gender, @RequestParam String address){
		User user = new User(userid, name, password, dob, roleid, email, enabled, gender, address);
		userService.saveMyUser(user);
		return "User saved";
	}
	
	/**
	 * Save data into 'doctor' table
	 *
	 * @param doctorid,department,qualification,experience,freebatch of the user instance
	 * @return console message 'user saved'
	 */
	@GetMapping("/save-doctor")
	public String saveDoctor(@RequestParam int doctorid, @RequestParam String department, @RequestParam String qualification, @RequestParam int experience, @RequestParam String free_batch){
		Doctor doctor = new Doctor(doctorid, department, qualification, experience, free_batch);
		doctorService.saveMyDoctor(doctor);
		return "Doctor saved";
	}  
}

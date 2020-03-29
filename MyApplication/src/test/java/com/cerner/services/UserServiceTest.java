package com.cerner.services;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;


import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.cerner.MyApplication;
import com.cerner.model.Doctor;
import com.cerner.model.User;


/**
 * @author AB078416
 *
 */
@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = MyApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class UserServiceTest {
	
	@Autowired
	private PatientService patientService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private DoctorService doctorService;
	
	@Test
	public void loginTest() {
		assertEquals(1,userService.findByUseridAndPassword(1, "yes"));
		assertEquals(0,userService.findByUseridAndPassword(2, "nooo"));
		assertEquals(2,userService.findByUseridAndPassword(9, "adu"));
		assertEquals(3,userService.findByUseridAndPassword(3, "hello"));
	}
	
	@Test
	void testUserDetails() {
		
		User user=new User(30,"rehman","d12","1966-02-01","R3","rehmanKhan@gmail.com",1,"M","Hyderabad");
		userService.saveMyUser(user);
		Doctor doctor=new Doctor(30,"Dermatalogist","PHD",17,"morning");
		doctorService.saveMyDoctor(doctor);
		String department=doctorService.showAllDetails(30).getDepartment();
		assertEquals("Dermatalogist",department);
		userService.deleteMyUser(30);
		int temp = user.getEnabled();  // temp variable is used for checking status of deleted user
		assertEquals(0,temp);
		patientService.deleteUserDetails(30);
		assertNull(doctorService.showAllDetails(30));
	}
}

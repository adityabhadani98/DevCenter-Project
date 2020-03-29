package com.cerner.controller;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.cerner.MyApplication;
import com.cerner.model.Doctor;
import com.cerner.model.User;

/**
 * The Class ApplicationControllerTest
 * Author AB078404
 */
@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = MyApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class ApplicationControllerTest {

	/* The rest template. */
	@Autowired
	private TestRestTemplate restTemplate;

	/** The port. */
	@LocalServerPort
	private int port;
	
	/**
	 * Gets the root url.
	 *
	 * @return the root url
	 */
	private String getRootUrl() {
		return "http://localhost:" + port;
	}
	
	/**
	 * Test show all patients
	 * Purpose of the test: To check whether admin homepage is being loaded with ok response code.
	 * When: URL passed to check the page response code.
	 * Then: OK response code value should be returned for ok response.
	 */
	@Test
	public void testShowAllUsers() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/show-users",HttpMethod.GET, entity, String.class);
		assertEquals(200, response.getStatusCodeValue());
	}
	
	/**
	 * Test login
	 * Purpose of the test: To check whether hospital is being loaded with ok response code.
	 * When: URL passed to check the page response code.
	 * Then: OK response code value should be returned for ok response.
	 */
	@Test
	public void testLogin() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/login",HttpMethod.GET, entity, String.class);
		assertEquals(200, response.getStatusCodeValue());
	}
	
	/**
	 * Test Edit user.
	 * Purpose of the test: To check the response code passed form the edit-user page url.
	 * When: URL passed with user id as parameter to check the page response code.
	 * Then: OK response code value should be returned for ok response.
	 */
	@Test
	public void testEditUser() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/edit-user?id=4",HttpMethod.GET, entity, String.class);
		assertEquals(200,response.getStatusCodeValue());
	}   
	
	/**
	 * Test delete user
	 * Purpose of the test: To check whether the particular medicine details is being deleted if stocks is zero.
	 * When: URL passed with the medicine id as parameter.
	 * Then: OK response code value should be returned as positive response code and medicine details should be deleted.
	 */
	@Test
	public void testdeleteUser() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/delete-user?id=4",HttpMethod.GET, entity, String.class);
		assertEquals(200,response.getStatusCodeValue());
	}
	
	
	/**
	 * Test save user
	 * Purpose of the test: To check whether the user details is being and positive response code is being returned.
	 * When: URL passed with user id and medicine stocks as parameters.
	 * Then: OK response code value should be returned as positive response code and database should be updated.
	 */
	@Test
	public void testSaveUser() {
		final User user = new User();
		user.setUserid(15);
		ResponseEntity<String> responseEntity = this.restTemplate.postForEntity(getRootUrl() + "/save-user?userid=15", user , String.class);
		assertEquals(200,responseEntity.getStatusCodeValue());
	}
	
	/**
	 * Test save doctor
	 * Purpose of the test: To check whether the doctor details is being and positive response code is being returned.
	 * When: URL passed with medicine id and medicine stocks as parameters.
	 * Then: OK response code value should be returned as positive response code and database should be updated.
	 */
	@Test
	public void testSaveDoctor() {
		final Doctor doctor = new Doctor();
		doctor.setDoctorid(5);
		ResponseEntity<String> responseEntity = this.restTemplate.postForEntity(getRootUrl() + "/save-doctor?doctorid=5", doctor , String.class);
		assertEquals(200,responseEntity.getStatusCodeValue());
	}
	
	/**
	 * Test schedule appointment
	 * Purpose of the test: To check whether the particular appointment details is being inserted if doctorid, slot, date
	 * of the particular appointment is already present in the database
	 * When: URL passed with the appointment id as parameter.
	 * Then: OK response code value should be returned as positive response code and appointment details should be inserted.
	 */
	@Test
	public void testScheduleAppointment() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/app1",HttpMethod.GET, entity, String.class);
		assertEquals(200, response.getStatusCodeValue());
	} 
	
	/**
	 * Test show all appointments
	 * Purpose of the test: To check whether admin homepage is being loaded with ok response code.
	 * When: URL passed to check the page response code.
	 * Then: OK response code value should be returned for ok response.
	 */
	@Test
	public void testShowAllAppointments() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/app2",HttpMethod.GET, entity, String.class);
		assertEquals(200, response.getStatusCodeValue());
	} 
	

}

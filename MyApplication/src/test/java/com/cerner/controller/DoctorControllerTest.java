package com.cerner.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.cerner.MyApplication;
import com.cerner.model.Doctor;
import com.cerner.model.Medicine;
import com.cerner.model.User;
import com.cerner.repository.MedicineRepository;
import com.cerner.services.MedicineService;

/**
 * The Class DoctorControllerTest.
 * Author PD078416
 */
@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = MyApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class DoctorControllerTest { 

	/* The rest template. */
	@Autowired
	private TestRestTemplate restTemplate;
	
	@Autowired
	private MedicineService medicineService;

	@MockBean
	private MedicineRepository medicineRepository;


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
	 * Test get all patients.
	 * Purpose of the test: To check whether homepage is being loaded with ok response code.
	 * When: URL passed to check the page response code.
	 * Then: OK response code value should be returned for ok response.
	 */
	@Test
	public void testGetAllPatients() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/homepage",HttpMethod.GET, entity, String.class);
		assertEquals(200, response.getStatusCodeValue());
	} 
	
	/**
	 * Test get all medicines.
	 * Purpose of the test: To check the reponse code passed form the show-medicines page url.
	 * When: URL passed to check the page response code.
	 * Then: OK response code value should be returned for ok response.
	 */
	@Test
	public void testGetAllMedicines() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/show-medicines",HttpMethod.GET, entity, String.class);
		assertEquals(200,response.getStatusCodeValue());
	}
	
	/**
	 * Test patient.
	 * Purpose of the test: To check the reponse code passed form the edit-patient page url.
	 * When: URL passed with patient id as parameter to check the page response code.
	 * Then: OK response code value should be returned for ok response.
	 */
	@Test
	public void testPatient() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/edit-patient?id=4",HttpMethod.GET, entity, String.class);
		assertEquals(200,response.getStatusCodeValue());
	}
	/**
	 * Test reduce medicine stocks.
	 * Purpose of the test: To check whether the particular medicine stocks is being reduced if stocks is more than zero.
	 * When: URL passed with the medicine id as parameter.
	 * Then: OK response code value should be returned as positive response code and medicine stocks should be updated.
	 */
	@Test
	public void testReduceMedicineStocks() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/delete-medicine?id=3",HttpMethod.GET, entity, String.class);
		assertEquals(200,response.getStatusCodeValue());
	}
	
	/**
	 * Test delete medicine.
	 * Purpose of the test: To check whether the particular medicine details is being deleted if stocks is zero.
	 * When: URL passed with the medicine id as parameter.
	 * Then: OK response code value should be returned as positive response code and medicine details should be deleted.
	 */
	@Test
	public void testDeleteMedicine() {
		Medicine medicine=new Medicine();
		medicine.setMedicineName("neorin");
		medicine.setstocks(0);
		medicineService.addMedicine(medicine.getMedicineName(),medicine.getStocks());
		String medicineName=medicine.getMedicineName();
		int medicineId=medicine.getMedicineId();
		medicineService.deleteMedicineDetails(medicineId);
		assertEquals(0, medicineService.searchMedicine(medicineName).size());
	}
	
	/**
	 * Test edit medicine.
	 * Purpose of the test: To check whether the particular medicine stocks is being updated.
	 * When: URL passed with the medicine id and medicine name as parameter.
	 * Then: OK response code value should be returned as positive response code and medicine stocks should be updated.
	 */
	@Test
	public void testEditMedicine() {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> response = restTemplate.exchange(getRootUrl() + "/edit-medicine?id=2&medicine_name=calpol",HttpMethod.GET, entity, String.class);
		assertEquals(200,response.getStatusCodeValue());
	} 
}

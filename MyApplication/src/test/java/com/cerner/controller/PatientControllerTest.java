package com.cerner.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.when;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.cerner.model.Patient;
import com.cerner.repository.PatientRepository;
import com.cerner.services.AddPatientService;


@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = MyApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class PatientControllerTest { 

	@LocalServerPort
	private int port;
	
	@Autowired
	private TestRestTemplate restTemplate;
	
	@Autowired
	private AddPatientService patientService;
	
	@MockBean
	private PatientRepository patientRepository;
	
	HttpServletRequest request;
	HttpServletResponse response;

	private String getRootUrl() {
		return "http://localhost:" + port;
	}
	
	@Test
	public void testPatient() {
		Patient patient = new Patient(1,"S6","A4",5,"Daniel");
		when(patientRepository.save(patient)).thenReturn(patient);
		assertEquals(patient, patientService.testUser(patient));

	}
	
	@Test
	public void testPatientDetailsPage() throws IOException, ServletException {
		HttpHeaders headers = new HttpHeaders();
		HttpEntity<String> entity = new HttpEntity<String>(null, headers);
		ResponseEntity<String> Response = restTemplate.exchange(getRootUrl() + "/edit-patient/add-details",HttpMethod.GET, entity, String.class);
		assertEquals(405, Response.getStatusCodeValue());
	}
}

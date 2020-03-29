package com.cerner.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cerner.services.AddPatientService;

/**
 * The Class PatientController.
 * @author PD078416
 */
@Controller
@RequestMapping("/edit-patient/add-details")
public class PatientController { 
	
	/** The add patient service. */
	@Autowired
	AddPatientService addPatientService;
	
	/** 
	 * Adds the patient details.
	 *
	 * @param request the request
	 * @param response the response
	 * @return the homepage.jsp page
	 * @throws IOException Signals that an I/O exception has occurred.
	 * @throws ServletException the servlet exception
	 */
	@RequestMapping(method = RequestMethod.POST)
	public String addPatientDetails(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException
	{
		int patientId=Integer.parseInt(request.getParameter("patientId"));
		String symptomsId=request.getParameter("symptomsId");
		String allergyId=request.getParameter("allergyId");
		int medicineId=Integer.parseInt(request.getParameter("medicineId"));
	    request.setAttribute("patient", addPatientService.addPatient(patientId,symptomsId,allergyId,medicineId));
		request.setAttribute("mode", "PATIENT_UPDATE");
		return "homepage"; 
	} 
	
}

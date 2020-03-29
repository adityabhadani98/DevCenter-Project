package com.cerner.controller;

import java.io.IOException;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cerner.services.MedicineService;

/**
 * The Class MedicineController.
 * @author PD078416
 */
@Controller
public class MedicineController {
	 
	/** The medicine service. */
	@Autowired
	MedicineService medicineService;
	
	/** 
	 * Update stocks.
	 *
	 * @param request the request
	 * @param response the response
	 * @return the homepage.jsp page
	 * @throws IOException Signals that an I/O exception has occurred.
	 * @throws ServletException the servlet exception
	 */
	@RequestMapping(value="/edit-patient/update-stocks",method=RequestMethod.POST)
	public String updateStocks(@RequestParam("medicineId") int medicineId,@RequestParam("quantity") int quantity) throws IOException,ServletException
	{
		medicineService.updateMedicineStocks(medicineId, quantity);
		return "homepage";
	}

	@RequestMapping(value="/add-medicine",method=RequestMethod.POST)
	public String addMedicine(@RequestParam("medicineName") String medicineName,@RequestParam("stocks") int stocks) throws IOException,ServletException
	{
		medicineService.addMedicine(medicineName, stocks);
		return "homepage";
	} 
}

/**
 * 
 */
package com.cerner.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.cerner.MyApplication;
import com.cerner.model.Medicine;

/**
 * @author PD078416
 *
 */
@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = MyApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class MedicineControllerTest {  

	
	@Autowired
	MedicineController medicineController;
	
	/**
	 * Test for updating medicine stocks after prescribing.
	 *
	 * @throws Exception the exception
	 * Purpose of the test: To check whether the particular medicine stocks is being updated after it is being prescribed to the patients.
	 * When: Medicine Id and Stocks.
	 * Then: Medicine stocks value should be updated.
	 */
	@Test
	public void testForUpdatingMedicineStocksAfterPrescribing() throws Exception{
		final Medicine medicine=new Medicine();
		medicine.setMedicineId(9);
		medicine.setstocks(2);
		medicineController.updateStocks(medicine.getMedicineId(),medicine.getStocks());
	}
	
	@Test
	public void testForAddingNewMedicine() throws Exception{
		String res=medicineController.addMedicine("Dolo", 20);
		assertEquals("homepage",res);
	}
}

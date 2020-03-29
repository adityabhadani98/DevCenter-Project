package com.cerner.services;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;


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
class MedicineServiceImplTest {

	@Autowired
	MedicineService medicineService;
	
	@Test
	void testForMedicine() {
		Medicine medicine=new Medicine("Ceratin",20);
		int result=medicineService.addMedicine("Dolo",20);
		assertEquals(0,result);
		medicineService.deleteMedicineDetails(4);
		medicineService.saveMedicine(4, 1);
		int size=medicineService.searchMedicine("Dolo").size();
		assertEquals(1,size);
		boolean showResult=medicineService.showAllMedicines().add(medicine);
		assertTrue(showResult);
	}

}

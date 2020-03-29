/**
 * 
 */
package com.cerner.interfaces;

import java.util.List;
import java.util.Optional;

/**
 * @author PD078416
 *
 */
public interface MedicineServiceInterface {
	
	public void saveMedicine(int id,int stocks);
	
	public List<?> showAllMedicines();
	
	public void deleteMedicineDetails(int id);
	
	public Optional<?> editMedicine(int id);
	
	public void updateMedicineStocks(int id,int quantity);
}

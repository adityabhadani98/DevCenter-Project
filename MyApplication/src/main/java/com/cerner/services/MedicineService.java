package com.cerner.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import com.cerner.interfaces.MedicineServiceInterface;
import com.cerner.model.Medicine;
import com.cerner.repository.MedicineRepository;


/**
 * The Class MedicineService.
 * @author PD078416
 */
/*Service layer provides code modularity,the business logic and rules are 
specified in the service layer which in turn calls Repository layer ,
the Repository layer is then only responsible for interacting with DB.*/
@Service
@Transactional
public class MedicineService implements MedicineServiceInterface{ 
	
	/** The medicine repository. */
	private final MedicineRepository medicineRepository;
	
	/**  
	 * Instantiates a new medicine service.
	 *
	 * @param medicineRepository the medicine repository
	 */
	public MedicineService(MedicineRepository medicineRepository) {
		this.medicineRepository=medicineRepository;
	} 

	
	/**
	 * Update medicine stocks.
	 *
	 * @param id the medicine id
	 * @param quantity the medicine intake quantity
	 */
	public void updateMedicineStocks(int id,int quantity){
		medicineRepository.editMedicineStocks(id,quantity);
	} 

	/**
	 * Show all medicines.
	 *
	 * @return the list of all the medicines
	 */
	public List<Medicine> showAllMedicines(){
		final List<Medicine> medicines = new ArrayList<Medicine>();
		for(Medicine med : medicineRepository.findAllMedicines()) {
			medicines.add(med);
		}
		
		return medicines;
	}

	/**
	 * Delete medicine details.
	 *
	 * @param id the medicine id
	 */
	public void deleteMedicineDetails(int id) {
		int stocks=medicineRepository.findStocks(id);
		if(stocks>0)
			medicineRepository.updateMedicineStocks(id);
		else
			medicineRepository.deleteMedicines(id);
	}

	/**
	 * Edits the medicine.
	 *
	 * @param id the medicine id
	 * @return the optional
	 */
	public Optional<Medicine> editMedicine(int id) {
		return medicineRepository.findById(id);
	}

	public int addMedicine(String medicineName,int stocks) {
		Medicine med=medicineRepository.searchMedicine(medicineName);
		if(med==null)
		{
			medicineRepository.addMedicine(medicineName,stocks);
			return 1;
		}
		else
			return 0;
	}
	
	/**
	 * Save my medicine.
	 *
	 * @param id the medicine id
	 * @param stocks the medicine stocks
	 */
	public void saveMedicine(int id,int stocks) {
		
		medicineRepository.updateStocks(id,stocks);
	}
	
	public List<Medicine> searchMedicine(String medicineName) {

		List<Medicine> medicines = new ArrayList<Medicine>();
		for (Medicine medicine : medicineRepository.findAll()) {
			if ((medicine.getMedicineName()).contains(medicineName)) {
					medicines.add(medicine);
				}
		}
	
		return medicines;
	}
}


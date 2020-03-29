package com.cerner.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * The Class Medicine.
 * @author PD078416
 */
//@Entity annotation specifies that the class is an entity and is mapped to a database table.
@Entity
@Table(name="medicine")
public class Medicine {
	
	
	public Medicine(String medicineName, int stocks) {
		super();
		this.medicineName = medicineName;
		this.stocks = stocks;
	}

	/** The medicine id. */
	@Id //it specifies that the medicine_id is primary key
	private int medicineId;
	
	/** The medicine name. */
	private String medicineName;
	
	// The medicine stocks
	private int stocks;
	
	//Instantiates a new medicine.

	public Medicine() {
		
	}
	
	/**
	 * Gets the medicine id.
	 *
	 * @return the medicine id
	 */
	public int getMedicineId() {
		return medicineId;
	}
	
	/**
	 * Sets the medicine id.
	 *
	 * @param medicineId the new medicine id
	 */
	public void setMedicineId(int medicineId) {
		this.medicineId = medicineId;
	}
	
	/**
	 * Gets the medicine name.
	 *
	 * @return the medicine name
	 */
	public String getMedicineName() {
		return medicineName;
	}
	
	public void setMedicineName(String medicineName) {
		this.medicineName=medicineName;
	}
	/**
	 * Gets the stocks.
	 *
	 * @return the stocks
	 */
	public int getStocks() {
		return stocks;
	}
	
	/**
	 * Sets the stocks.
	 *
	 * @param stocks the new stocks
	 */
	public void setstocks(int stocks) {
		this.stocks = stocks;
	}

	@Override
	public String toString() {
		return "Medicine [medicineId=" + medicineId + ", medicineName=" + medicineName + ", stocks=" + stocks + "]";
	}
}

/**
 * 
 */
package com.cerner.interfaces;

/**
 * @author PD078416
 *
 */
public interface AddPatientServiceInterface {
	
	public int addPatient(int patientId,String symptomsId,String allergyId,int medicineId);
}

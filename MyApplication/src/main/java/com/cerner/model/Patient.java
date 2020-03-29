package com.cerner.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * The Class Patient.
 * @author PD078416
 */
@Entity
@Table(name="patient")
public class Patient {
	
	/** The id. */
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id", updatable = false, nullable = false)
	private int id;
	
	/** The patient id. */
	private int patientId;
	
	/** The symptoms id. */
	private String symptomsId;
	
	/** The allergy id. */
	private String allergyId;
	
	/** The medicine id. */
	private int medicineId;
	
	/** The patient name */
	private String patient_name;
	
	/**
	 * Instantiates a new patient.
	 */
	public Patient() {
		
	}
	
	/**
	 * Gets the patient id.
	 *
	 * @return the patient id
	 */
	public int getPatientId() {
		return patientId;
	}
	
	/**
	 * Sets the patient id.
	 *
	 * @param patientId the new patient id
	 */
	public void setPatientId(int patientId) {
		this.patientId = patientId;
	}
	
	/**
	 * Gets the symptoms id.
	 *
	 * @return the symptoms id
	 */
	public String getSymptomsId() {
		return symptomsId;
	}
	
	/**
	 * Sets the symptoms id.
	 *
	 * @param symptomsId the new symptoms id
	 */
	public void setSymptomsId(String symptomsId) {
		this.symptomsId = symptomsId;
	}
	
	/**
	 * Gets the allergy id.
	 *
	 * @return the allergy id
	 */
	public String getAllergyId() {
		return allergyId;
	}
	
	/**
	 * Sets the allergy id.
	 *
	 * @param allergyId the new allergy id
	 */
	public void setAllergyId(String allergyId) {
		this.allergyId = allergyId;
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
	
	public String getPatient_name() {
		return patient_name;
	}

	public void setPatient_name(String patient_name) {
		this.patient_name = patient_name;
	}

	public Patient(int patientId, String symptomsId, String allergyId, int medicineId, String patient_name) {
		super();
		this.patientId = patientId;
		this.symptomsId = symptomsId;
		this.allergyId = allergyId;
		this.medicineId = medicineId;
		this.patient_name = patient_name;
	}
	
}

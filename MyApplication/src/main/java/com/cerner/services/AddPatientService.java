package com.cerner.services;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.cerner.interfaces.AddPatientServiceInterface;
import com.cerner.model.Patient;
import com.cerner.repository.PatientRepository;

/**
 * The Class AddPatientService.
 * 
 * @author PD078416
 */
@Service
@Transactional
public class AddPatientService implements AddPatientServiceInterface {

	/** The patient repository. */
	private final PatientRepository patientRepository;

	/**
	 * Instantiates a new adds the patient service.
	 *
	 * @param patientRepository the patient repository
	 */
	public AddPatientService(PatientRepository patientRepository) {
		this.patientRepository = patientRepository;
	}

	/**
	 * Adds the patient.
	 *
	 * @param patientId  the patient id
	 * @param symptomsId the symptoms id
	 * @param allergyId  the allergy id
	 * @param medicineId the medicine id
	 * @return the int status which represents whether its inserted or not
	 */
	public int addPatient(int patientId, String symptomsId, String allergyId, int medicineId) {
		int status = patientRepository.addPatientDetails(patientId, symptomsId, allergyId, medicineId);
		return status;
	}

	public Patient testUser(Patient patient) {
		return patientRepository.save(patient);
	}
}

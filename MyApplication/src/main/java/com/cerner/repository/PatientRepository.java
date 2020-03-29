package com.cerner.repository;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cerner.model.Patient;

/**
 * The Interface PatientRepository.
 * @author PD078416
 */
public interface PatientRepository extends JpaRepository<Patient, Integer>{
	
	/**
	 * Adds the patient details.
	 *
	 * @param patientId the patient id
	 * @param symptomsId the symptoms id
	 * @param allergyId the allergy id
	 * @param medicineId the medicine id
	 * @return the int status which represents whether its inserted or not
	 */
	@Modifying
    @Transactional
	@Query(value="insert into patient (patient_id,symptoms_id,allergy_id,medicine_id) values(:patient_id,:symptoms_id,:allergy_id,:medicine_id);",nativeQuery = true)
	public int addPatientDetails(@Param("patient_id") int patientId,@Param("symptoms_id") String symptomsId,@Param("allergy_id") String allergyId,@Param("medicine_id") int medicineId);

}
package com.cerner.services;


import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.cerner.interfaces.AddPatientServiceInterface;
import com.cerner.interfaces.PatientServiceInterface;
import com.cerner.model.Patient;
import com.cerner.model.User;
import com.cerner.repository.PatientRepository;
import com.cerner.repository.UserRepository;

/**
 * The Class AddPatientService.
 * @author PD078416
 */
@Service
@Transactional
public class PatientService implements PatientServiceInterface{
	
	/** The user repository. */ 	
	private final UserRepository userRepository;
 
	/**
	 * Instantiates a new adds the patient service.
	 *
	 * @param patientRepository the patient repository
	 */
	public PatientService(UserRepository userRepository) {
		this.userRepository = userRepository;
	}
	
	/**
	 * @param userId
	 * @return
	 */
	public User showAllDetails(int userid) {
		return userRepository.findDetails(userid);
	}

	public void saveUser(int userid,String name,String password, String email,String date,String gender, String address) {
		userRepository.saveDoctorDetails(userid,name,password,email,date,gender,address);
	}
	
	public void deleteUserDetails(int id) {
		userRepository.deleteById(id);
	}
}

package com.cerner.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.cerner.interfaces.DoctorInterface;
import com.cerner.interfaces.DoctorServiceInterface;
import com.cerner.model.Doctor;
import com.cerner.model.User;
import com.cerner.repository.DoctorRepository;

/**
 * The Class DoctorService
 * @author AB078404
 */

@Service
@Transactional
public class DoctorService implements DoctorServiceInterface{
	private final DoctorRepository doctorRepository;	
	
	/**
	 * Instantiates a new doctor service
	 *
	 * @param doctorRepository the doctor repository
	 */
	public DoctorService(DoctorRepository doctorRepository) {
		this.doctorRepository = doctorRepository;
	}
	
	
	/**
	 * Save my doctor
	 *
	 * @param doctor the instance of class doctor
	 */
	public void saveMyDoctor(Doctor doctor) {
		doctorRepository.save(doctor);
	}  
	
	public void saveMyDoctor1(int userid,String department,String qualification,int experience) {
		doctorRepository.editDoctorDetails(userid,department,qualification,experience);
	}
	
	/**
	 * @param userId
	 * @return
	 */
	public Doctor showAllDetails(int userid) {
		return doctorRepository.findDetails(userid);
	}
}

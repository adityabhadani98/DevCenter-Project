package com.cerner.interfaces;

import com.cerner.model.Doctor;

public interface DoctorServiceInterface {
	
	public Doctor showAllDetails(int userid);
	
	public void saveMyDoctor(Doctor doctor);
}

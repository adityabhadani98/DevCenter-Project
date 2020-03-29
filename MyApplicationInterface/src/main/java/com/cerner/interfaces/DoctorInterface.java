package com.cerner.interfaces;

import java.util.List;
import java.util.Optional;

/**
 * @author AB078404
 *
 */
public interface DoctorInterface {
	
	public void saveDoctor(int doctorid, String password);
	
	public List<?> showAllDoctor();
	
	public void deleteDoctorDetails(int doctorid);
	
	public Optional<?> editDoctor(int doctorid);
}

package com.cerner.interfaces;

import java.util.List;
import java.util.Optional;

import com.cerner.model.User;

public interface UserServiceInterface {
	
	public int findByUseridAndPassword(int userid, String password);
	
	public void updateMyUser(int id, String name, String password, String dob, String roleid, String email, String gender, String address, int enabled);
	
	public Optional<?> editUser(int id);
	
	public void deleteMyUser(int id);
	
	public User showAllDetails(int userid);
	
	public List<?> showAllUsers();
	
	public List<?> showAllPatients();	
	
	public void updatePUser(int userid,String name,String password, String email,String date,String gender, String address);
	
}

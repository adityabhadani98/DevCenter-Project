package com.cerner.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;
import org.springframework.stereotype.Service;

import com.cerner.interfaces.UserServiceInterface;
import com.cerner.model.User;
import com.cerner.model.UserRole;
import com.cerner.repository.UserRepository;
import com.cerner.repository.UserRoleRepository;

/**
 * The Class UserService
 * @author AB078404
 */

@Service
@Transactional
public class UserService implements UserServiceInterface{
	private final UserRepository userRepository;
	private final UserRoleRepository userRoleRepository;
	/**
	 * Instantiates a new user service
	 *
	 * @param userRepository the user repository
	 */
	public UserService(UserRoleRepository userRoleRepository,UserRepository userRepository) {
		this.userRoleRepository = userRoleRepository;
		this.userRepository = userRepository;
	}
	
	/**
	 * Save my user
	 *
	 * @param user the instance of class User
	 */
	public void saveMyUser(User user) {
		userRepository.save(user);
	}

	public void updatePUser(int userid,String name,String password, String email,String date,String gender, String address) {
		userRepository.saveDoctorDetails(userid,name,password,email,date,gender,address);
	}

	
	/**
	 * Show all users
	 *
	 * @return the list of all the users
	 */
	public List<User> showAllPatients() {
		List<User> users = new ArrayList<User>();
		for (User user : userRepository.findAllPatients()) {
			users.add(user);
		}
		return users;
	}
	
	/**
	 * Show all users
	 *
	 * @return the list of all the users
	 */
	public List<User> showAllUsers() {
		final List<User> users = new ArrayList<User>();
		for (User user : userRepository.findAll()) {
			users.add(user);
		}
		return users;
	}
	
	public User showAllDetails(int userid) {
		return userRepository.findDetails(userid);
	}
	
	/**
	 * Delete user details
	 *
	 * @param id the user id
	 */
	public void deleteMyUser(int id) {
		userRepository.deleteUser(id);
	}
	
	/**
	 * Edits the user
	 *
	 * @param id the user id
	 * @return the optional
	 */
	public Optional<User> editUser(int id) {
		return userRepository.findById(id);
	}
	
	/**
	 * Update user details
	 *
	 * @param user parameters 
	 */
	public void updateMyUser(int id, String name, String password, String dob, String roleid, String email, String gender, String address, int enabled) {
		userRepository.updateUser(id,name,password,dob,roleid,email,gender,address, enabled);
	}
	
	/**
	 * findByUseridAndPassword 
	 *
	 * @param id the user id
	 * @return integer 1,2,3 according to roleid returned from 
	 * userrepository interface
	 */
	public int findByUseridAndPassword(int userid, String password) {
		/* temp1 variable validates the user as admin/patient/doctor by using findbyuseridandpassword
		   function implemented in userrepository interface  */
		User temp1 =  userRepository.findByUseridAndPassword(userid, password);
		if (temp1 == null) {
			return 0;
		}
		String temp3 = temp1.getRoleid();
		if(temp3.equals("R1")) return 1;
		else if(temp3.equals("R2")) return 2;
		else if(temp3.equals("R3")) return 3;
		return -1;
	}

}

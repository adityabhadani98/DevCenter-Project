package com.cerner.interfaces;

import java.util.List;
import java.util.Optional;

import org.springframework.boot.autoconfigure.security.SecurityProperties.User;

/**
 * @author AB078404
 *
 */
public interface UserInterface {
	
	public void saveUser(int userid,int stocks);
	
	public List<?> showAllUsers();
	
	public void deleteUser(int userid);
	
	public Optional<?> editUser(int userid);
	
	public User findByUseridAndPassword(int userid, String password);
}

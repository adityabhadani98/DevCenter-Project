package com.cerner.model;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Entity;

/**
 * The Class UserRole
 * @author AB078404
 */
//@Entity annotation specifies that the class is an entity and is mapped to a database table.
@javax.persistence.Entity
@Table(name="user_role")

public class UserRole {
	@Id
	String roleid;
	String role_name;
	
	public UserRole() {}
	
	//Instantiates a new user
	public UserRole(String roleid, String role_name) {
		super();
		this.roleid = roleid;
		this.role_name = role_name;
	}
	
	public String getRoleid() {
		return roleid;
	}
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	
	/**
	 * converts all the parameter of user_roles table in the form of string
	 *
	 * @return a string containing all parameters of user_roles table 
	 */
	//override toString() to get proper output when an object is used in print()
	@Override
	public String toString() {
		return "UserRole [roleid=" + roleid + ", role_name=" + role_name + "]";
	}
	
}
package com.cerner.model;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Entity;

/**
 * The Class User
 * @author AB078404
 */
//@Entity annotation specifies that the class is an entity and is mapped to a database table.
@javax.persistence.Entity
@Table(name="users")

public class User {
		
		/** The user id*/
		@Id  //it specifies that the medicine_id is primary key
		private int userid;
		
		/** The user name */
		private String name;
		
		/** The user password which acts as their validation parameter*/
		private String password;
		
		/** The user date of birth in dd/mm/yy format*/
		private String dob;
		
		/** The user role id which can be R1,R2,R3 */
		private String roleid;
		
		/** The user email id*/
		private String email;
		
		/** enabled field indicates whether user is active member of hospital or not*/
		private int enabled;
		
		/** The user gender*/
		private String gender;
		
		/** The user address*/
		private String address;
		
		public User() {}
		
		//Instantiates a new user
		public User(int userid, String name, String password, String dob, String roleid, String email, int enabled, String gender, String address) {
			super();
			this.userid = userid;
			this.name = name;
			this.password = password;
			this.dob = dob;
			this.roleid = roleid;
			this.email = email;
			this.enabled = enabled;
			this.gender = gender;
			this.address = address;
		}
		public int getUserid() {
			return userid;
		}
		public void setUserid(int userid) {
			this.userid = userid;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public String getDob() {
			return dob;
		}
		public void setDob(String dob) {
			this.dob = dob;
		}
		public String getRoleid() {
			return roleid;
		}
		public void setRoleid(String roleid) {
			this.roleid = roleid;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}

		public int getEnabled() {
			return enabled;
		}

		public void setEnabled(int enabled) {
			this.enabled = enabled;
		}

		public String getGender() {
			return gender;
		}

		public void setGender(String gender) {
			this.gender = gender;
		}

		public String getAddress() {
			return address;
		}

		public void setAddress(String address) {
			this.address = address;
		}
		
		/**
		 * converts all the parameter of users table in the form of string
		 *
		 * @return a string containing all parameters of users table 
		 */
		//override toString() to get proper output when an object is used in print()
		@Override
		public String toString() {
			return "User [userid=" + userid + ", name=" + name + ", password=" + password + ", dob=" + dob + ", roleId="
					+ roleid + ", email=" + email + ", enabled=" + enabled + ", gender=" + gender + ", address=" + address
					+ "]";
		}
}

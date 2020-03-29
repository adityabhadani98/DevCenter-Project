package com.cerner.model;

import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

/**
 * The Class Doctor
 * @author AB078404
 */
//@Entity annotation specifies that the class is an entity and is mapped to a database table.
@javax.persistence.Entity
@Table(name="doctor")

@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
public class Doctor {
	
	/** The doctor id*/
	@Id  //it specifies that the medicine_id is primary key
	private int doctorid;
	
	/* The doctor department */
	private String department;
	
	/* Doctor qualification */
	private String qualification;
	
	/* Doctor experience in years */
	private int experience;
	
	public Doctor() {}
	
	//Instantiates a new doctor.
	public Doctor(int doctorid, String department, String qualification, int experience, String free_batch) {
		super();
		this.doctorid = doctorid;
		this.department = department;
		this.qualification = qualification;
		this.experience = experience;
	}

	/**
	 * Gets the doctor id
	 *
	 * @return the doctor id
	 */
	public int getDoctorid() {
		return doctorid;
	}

	public void setDoctorid(int doctorid) {
		this.doctorid = doctorid;
	}

	/**
	 * Gets the department
	 *
	 * @return the department name
	 */
	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	/**
	 * Gets the qualification of the doctor
	 *
	 * @return the qualification
	 */
	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	/**
	 * Gets the experience of the doctor
	 *
	 * @return the experience of the doctor in ages
	 */
	public int getExperience() {
		return experience;
	}

	public void setExperience(int experience) {
		this.experience = experience;
	}
	
	/**
	 * converts all the parameter of doctor table in the form of string
	 *
	 * @return a string containing all parameters of doctor table 
	 */
	//override toString() to get proper output when an object is used in print()
	@Override
	public String toString() {
		return "Doctor [doctorid=" + doctorid + ", department=" + department + ", qualification=" + qualification
				+ ", experience=" + experience + "]";
	}	
	
}

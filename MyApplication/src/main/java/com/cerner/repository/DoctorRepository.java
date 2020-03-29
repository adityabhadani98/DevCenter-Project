package com.cerner.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.cerner.model.Doctor;

public interface DoctorRepository extends CrudRepository<Doctor, Integer> {
	
	@Modifying
	@Transactional
    @Query(value="UPDATE doctor d SET d.department = :department, d.qualification = :qualification, d.experience = :experience WHERE d.doctorId = :userid",nativeQuery=true)
    public int editDoctorDetails(@Param("userid") int userid, @Param("department") String department, @Param("qualification") String qualification, @Param("experience") int experience);

	/**
	 * @param userId
	 * @return
	 */
	@Query(value="select * from doctor d where d.doctorId=:userid",nativeQuery=true)
	public Doctor findDetails(@Param("userid") int userid);
}
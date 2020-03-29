package com.cerner.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.cerner.model.User;

@Service
public interface UserRepository extends CrudRepository<User, Integer>, JpaRepository<User, Integer> {	
	public User findByUseridAndPassword(int userid, String password);
	
	/**
	 * Find all patients.
	 *
	 * @return the list of all the patients
	 */
	//custom query can be provided using @Query annotation.
	@Query(value="select * from users u where u.roleid='R2' and u.enabled=1",nativeQuery = true)
	public List<User> findAllPatients();
	
	/**
	 * update the users details to change the enabled status for user
	 *
	 * @param userid the userid
	 * @return the int status which represents whether its updated or not
	 */
	@Modifying
	@Transactional
    @Query(value="UPDATE users u SET u.enabled = 0 WHERE u.userid = :userid",nativeQuery=true)
    public int deleteUser(@Param("userid") int userid);
	
	/**
	 * update the user details.
	 *
	 * @param userid the userid
	 * @param department the doctor department
	 * @param qualifcation the doctor qualification in string
	 * @param experience the doctor experience in years
	 * @return the int status which represents whether its updated or not
	 */
	@Modifying
	@Transactional
    @Query(value="UPDATE users u SET u.name = :name, u.password = :password, u.dob = :dob, u.roleid = :roleid, u.email = :email, u.gender = :gender, u.address = :address, u.enabled = :enabled WHERE u.userid = :userid",nativeQuery=true)
    public int updateUser(@Param("userid") int userid, @Param("name") String name, @Param("password") String password, @Param("dob") String dob, @Param("roleid") String roleid, @Param("email") String email, @Param("gender") String gender, @Param("address") String address, @Param("enabled") int enabled);

	/**
	 * @param userId
	 * @return
	 */
	@Query(value="select * from users where userid=:userid",nativeQuery=true)
	public User findDetails(@Param("userid") int userid);
	
	/**
	 * update the user details.
	 *
	 * @param userId
	 * @param name
	 * @param password
	 * @param phone
	 * @param email
	 * @param dob
	 * @param address
	 * @return the int status which represents whether its updated or not
	 */
	
	@Modifying
	@Transactional
	@Query(value="update users set name=:name,password=:password,email=:email,dob=:dob,gender=:gender, address=:address where userid=:userid",nativeQuery=true)
	public void saveDoctorDetails(@Param("userid")int userid,@Param("name") String name,@Param("password") String password,@Param("email") String email,@Param("dob") String dob,@Param("gender")String gender, @Param("address")String address);

}


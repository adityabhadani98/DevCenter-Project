package com.cerner.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.cerner.model.Appointment;
import com.cerner.model.User;

@Service
public interface AppointmentRepository extends CrudRepository<Appointment, Integer>, JpaRepository<Appointment, Integer> {
    
    /**
	 * Adds the appointment details.
	 *
	 * @param doctorId the doctor id
	 * @param patientId the patient id
	 * @param date the appointment date
	 * @param slot the appointment slot
	 * @return the int status which represents whether its updated or not
	 */
	@Modifying
	@Transactional
	@Query(value = "INSERT INTO appointments VALUES (0,:doctorid,:patient_id,:date,:slot,'Scheduled');", nativeQuery = true)
	public int addAppointment(@Param("doctorid") int doctorid, @Param("patient_id") int patient_id,
			@Param("date") String date, @Param("slot") String slot);

	
	/**
	 * Find all appointments
	 *
	 * @return the list of all the appointments
	 */
	//custom query can be provided using @Query annotation.
	@Query(value="select a.appointment_id,a.doctorid,a.patient_id,a.date,a.status,a.slot,s.start_time,s.end_time from appointments a, slots s where a.slot=s.slot",nativeQuery = true)
	public List<Appointment> findAllAppointments();
	
	/**
	 * update the appointment details to change the status for particular appointment
	 *
	 * @param appointment_id the appointment ID
	 * @return the int status which represents whether its updated or not
	 */
	@Modifying
	@Transactional
    @Query(value="UPDATE appointments a SET a.status = 'Cancelled' WHERE a.appointment_id = :appointment_id",nativeQuery=true)
    public int deleteAppointment(@Param("appointment_id") int appointment_id);
	
	/**
	 * update the appointment details.
	 *
	 * @param appointmentid the appointment_id
	 * @return the int status which represents whether its updated or not
	 */
	@Modifying
	@Transactional
    @Query(value="UPDATE appointments u SET u.appointment_id = :appointment_id, u.doctorid = :doctorid, u.patient_id = :patient_id, u.date = :date, u.slot = :slot, u.status = :status",nativeQuery=true)
    public int updateAppointment(@Param("appointment_id") int appointment_id, @Param("doctorid") int doctorid, @Param("patient_id") int patient_id, @Param("date") String date, @Param("slot") String slot, @Param("status") String status);

}


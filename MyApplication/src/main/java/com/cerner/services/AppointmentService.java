package com.cerner.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;
import org.springframework.stereotype.Service;

import com.cerner.interfaces.AppointmentServiceInterface;
import com.cerner.model.Appointment;
import com.cerner.model.User;
import com.cerner.repository.AppointmentRepository;

/**
 * The Class AppointmentService
 * @author AB078404
 */

@Service
@Transactional
public class AppointmentService implements AppointmentServiceInterface{
	private final AppointmentRepository appointmentRepository;

	/**
	 * Instantiates a new user service
	 *
	 * @param userRepository the user repository
	 * @param appointmentRepository 
	 */
	public AppointmentService(AppointmentRepository appointmentRepository) {
		this.appointmentRepository = appointmentRepository;
	}

	public void saveAppointment(int doctorid, int patient_id, String date, String slot) {
		appointmentRepository.addAppointment(doctorid,patient_id,date,slot);
	}
	
	/**
	 * Show all appointments
	 *
	 * @return the list of all the appointments
	 */
	public List<Appointment> showAllAppointments() {
		List<Appointment> appointments = new ArrayList<Appointment>();
		for (Appointment appointment : appointmentRepository.findAllAppointments()) {
			appointments.add(appointment);
		}
		return appointments;
	}
	
	/**
	 * Delete appointment details
	 *
	 * @param id the appointment id
	 */
	public void deleteMyAppointment(int id) {
		appointmentRepository.deleteAppointment(id);
	}
	
	/**
	 * Update appointment details
	 *
	 * @param appointment parameters 
	 */
	public void updateMyAppointment(int appointment_id, int doctorid, int patient_id, String date, String slot,String status) {
		appointmentRepository.updateAppointment(appointment_id,doctorid,patient_id,date,slot,status);
	}
}

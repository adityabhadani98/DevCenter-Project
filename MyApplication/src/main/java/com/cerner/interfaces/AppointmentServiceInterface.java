package com.cerner.interfaces;
import java.util.List;

import com.cerner.model.Appointment;

public interface AppointmentServiceInterface {
	
	public void saveAppointment(int doctorid, int patient_id, String date, String slot);
	
	public List<Appointment> showAllAppointments();
}

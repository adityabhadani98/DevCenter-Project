package com.cerner.services;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.cerner.MyApplication;
import com.cerner.model.Appointment;

import static org.junit.jupiter.api.Assertions.*;


/**
 * @author AB078404
 *
 */
@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = MyApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class AppointmentServiceImplTest {
	
	@Autowired
	private AppointmentService appointmentService;

	/**
	 * Test save appointment
	 * Purpose of the test: To check whether the appointment details is being saved and positive response code is being returned.
	 * When: URL passed with doctorid, patientid, date of appointment and slot name as parameters.
	 * Then: OK response code value should be returned as positive response code and database should be updated.
	 */
	@Test
	void saveMyAppointment()
	{
		Appointment appointment=new Appointment(0,6,2,"2020-02-12","T2","Scheduled");
		appointmentService.saveAppointment(9, 1, "2020-05-10", "T4");
		boolean result=appointmentService.showAllAppointments().add(appointment);
		assertTrue(result);
	}
}

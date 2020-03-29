package com.cerner.model;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * The Class User
 * @author AB078404
 */
//@Entity annotation specifies that the class is an entity and is mapped to a database table.
@javax.persistence.Entity
@Table(name="appointments")

public class Appointment {
		
		/** The user id*/
		@Id  //it specifies that the medicine_id is primary key
		private int appointment_id;
		
		/** The doctor id for appointment */
		private int doctorid;
		
		/** The patient id for the appointment */
		private int patient_id;
		
		/** The appointment date in dd/mm/yy format*/
		private String date;
		
		/** The appointment slot which can be T1,T2,T3,T4 */
		private String slot;
		
		/** The appointment status which can be Completed, Scheduled or Cancelled */
		private String status;
	
		public Appointment() {}
		
		//Instantiates a new appointment
		public Appointment(int appointment_id, int doctorid, int patient_id, String date, String slot, String status) {
			super();
			this.appointment_id = appointment_id;
			this.doctorid = doctorid;
			this.patient_id = patient_id;
			this.date = date;
			this.slot = slot;
			this.status = status;
		}

		public int getAppointment_id() {
			return appointment_id;
		}

		public void setAppointment_id(int appointment_id) {
			this.appointment_id = appointment_id;
		}

		public int getDoctorid() {
			return doctorid;
		}

		public void setDoctorid(int doctorid) {
			this.doctorid = doctorid;
		}

		public int getPatient_id() {
			return patient_id;
		}

		public void setPatient_id(int patient_id) {
			this.patient_id = patient_id;
		}

		public String getDate() {
			return date;
		}

		public void setDate(String date) {
			this.date = date;
		}

		public String getSlot() {
			return slot;
		}

		public void setSlot(String slot) {
			this.slot = slot;
		}

		public String getStatus() {
			return status;
		}

		public void setStatus(String status) {
			this.status = status;
		}

		@Override
		public String toString() {
			return "Appointment [appointment_id=" + appointment_id + ", doctorid=" + doctorid + ", patient_id="
					+ patient_id + ", date=" + date + ", slot=" + slot + ", status=" + status + "]";
		}
}

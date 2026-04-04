import '../models/doctor.dart';
import '../models/patient.dart';
import '../models/appointment.dart';
import '../models/user.dart';

class DataService {
  static List<User> users = [
    User(name: 'Admin', email: 'admin@gmail.com', password: '1234', role: 'Admin'),
    User(name: 'Dr. Raj Mehta', email: 'raj@gmail.com', password: '1234', role: 'Doctor'),
    User(name: 'Dr. Priya Sharma', email: 'priya_doctor@gmail.com', password: '1234', role: 'Doctor'),
    User(name: 'Dr. Rahul Singh', email: 'rahul_doctor@gmail.com', password: '1234', role: 'Doctor'),
    User(name: 'John Doe', email: 'user@gmail.com', password: '1234', role: 'User'),
  ];

  static User? currentUser;

  static List<Doctor> doctors = [
    Doctor(name: 'Dr. Raj Mehta', specialization: 'Cardiologist', email: 'raj@gmail.com'),
    Doctor(name: 'Dr. Priya Sharma', specialization: 'Dermatologist', email: 'priya_doctor@gmail.com'),
    Doctor(name: 'Dr. Amit Patel', specialization: 'Neurologist'),
    Doctor(name: 'Dr. Neha Verma', specialization: 'Pediatrician'),
    Doctor(name: 'Dr. Rahul Singh', specialization: 'Orthopedic', email: 'rahul_doctor@gmail.com'),
    Doctor(name: 'Dr. Sneha Shah', specialization: 'Gynecologist'),
    Doctor(name: 'Dr. Arjun Kapoor', specialization: 'ENT'),
  ];

  static List<Patient> patients = [
    Patient(name: 'Amit Kumar', age: 25),
    Patient(name: 'Neha Singh', age: 30),
    Patient(name: 'Ravi Patel', age: 40),
  ];

  static List<Appointment> appointments = [];
}

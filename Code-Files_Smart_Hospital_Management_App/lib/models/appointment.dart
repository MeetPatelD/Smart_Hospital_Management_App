import 'doctor.dart';

class Appointment {
  Doctor doctor;
  String patientName;
  int age;
  String gender;
  String problem;
  String date;
  String time;
  String status;
  String prescription;
  String userEmail;

  Appointment({
    required this.doctor,
    required this.patientName,
    required this.age,
    required this.gender,
    required this.problem,
    required this.date,
    required this.time,
    required this.userEmail,
    this.status = 'Pending',
    this.prescription = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'doctor': doctor.toJson(),
      'patientName': patientName,
      'age': age,
      'gender': gender,
      'problem': problem,
      'date': date,
      'time': time,
      'status': status,
      'prescription': prescription,
      'userEmail': userEmail,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      doctor: Doctor.fromJson(json['doctor']),
      patientName: json['patientName'],
      age: json['age'],
      gender: json['gender'],
      problem: json['problem'],
      date: json['date'],
      time: json['time'],
      userEmail: json['userEmail'],
      status: json['status'] ?? 'Pending',
      prescription: json['prescription'] ?? '',
    );
  }
}

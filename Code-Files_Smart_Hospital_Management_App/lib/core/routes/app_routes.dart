import 'package:flutter/material.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/dashboard/screens/home_screen.dart';
import '../../features/doctor/screens/doctor_screen.dart';
import '../../features/doctor/screens/all_doctors_screen.dart';
import '../../features/patient/screens/patient_screen.dart';
import '../../features/appointment/screens/appointment_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String doctor = '/doctor';
  static const String allDoctors = '/all-doctors';
  static const String patient = '/patient';
  static const String appointment = '/appointment';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginScreen(),
      signup: (context) => const SignupScreen(),
      home: (context) => const HomeScreen(),
      doctor: (context) => const DoctorScreen(),
      allDoctors: (context) => const AllDoctorsScreen(showAppBar: true),
      patient: (context) => const PatientScreen(),
      appointment: (context) => const AppointmentScreen(),
    };
  }
}

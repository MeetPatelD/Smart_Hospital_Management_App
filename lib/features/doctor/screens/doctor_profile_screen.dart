import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/data_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../models/doctor.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    final List<Doctor> matchedDoctors = DataService.doctors.where((d) => d.name == user?.name || (user?.email != null && d.email == user?.email)).toList();
    final matched = matchedDoctors.isNotEmpty ? matchedDoctors.first : null;
    final appointmentCount = DataService.appointments.where((a) => a.doctor.name == user?.name || (user?.email != null && a.doctor.email == user?.email)).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(radius: 32, child: Icon(Icons.person, size: 32)),
                const SizedBox(height: 16),
                Text(user?.name ?? 'Doctor', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Email: ${user?.email ?? '-'}'),
                Text('Role: ${user?.role ?? 'Doctor'}'),
                Text('Specialization: ${matched?.specialization ?? 'Not linked'}'),
                Text('Total Appointments: $appointmentCount'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

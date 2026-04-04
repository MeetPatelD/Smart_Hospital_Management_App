import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/data_service.dart';
import '../../auth/providers/auth_provider.dart';

class DoctorScheduleScreen extends StatelessWidget {
  const DoctorScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    final items = DataService.appointments.where((appt) {
      return appt.doctor.name == user?.name || (appt.doctor.email.isNotEmpty && appt.doctor.email == user?.email);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Schedule')),
      body: items.isEmpty
          ? const Center(child: Text('No scheduled appointments'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final appt = items[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.schedule, color: Colors.blue),
                    title: Text(appt.patientName),
                    subtitle: Text('${appt.date} • ${appt.time}\n${appt.problem}'),
                    trailing: Text(appt.status),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/data_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../models/appointment.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  State<DoctorAppointmentsScreen> createState() => _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  void _showCompleteDialog(Appointment appt) {
    final controller = TextEditingController(text: appt.prescription);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Complete Appointment'),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Prescription',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  appt.status = 'Completed';
                  appt.prescription = controller.text.trim();
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    final myAppointments = DataService.appointments.where((appt) {
      return appt.doctor.name == user?.name || (appt.doctor.email.isNotEmpty && appt.doctor.email == user?.email);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Appointments')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: myAppointments.isEmpty
            ? const Center(child: Text('No appointments assigned yet'))
            : ListView.builder(
                itemCount: myAppointments.length,
                itemBuilder: (context, index) {
                  final appt = myAppointments[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(appt.patientName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text('Problem: ${appt.problem}'),
                          Text('Date: ${appt.date} | Time: ${appt.time}'),
                          Text('Status: ${appt.status}'),
                          if (appt.prescription.isNotEmpty) Text('Prescription: ${appt.prescription}'),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            children: [
                              if (appt.status == 'Pending')
                                ElevatedButton.icon(
                                  onPressed: () => _showCompleteDialog(appt),
                                  icon: const Icon(Icons.check),
                                  label: const Text('Complete'),
                                ),
                              if (appt.status == 'Pending')
                                OutlinedButton.icon(
                                  onPressed: () => setState(() => appt.status = 'Cancelled'),
                                  icon: const Icon(Icons.cancel),
                                  label: const Text('Cancel'),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

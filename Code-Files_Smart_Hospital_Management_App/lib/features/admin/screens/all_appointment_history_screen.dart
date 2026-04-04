import 'package:flutter/material.dart';
import '../../../services/data_service.dart';

class AllAppointmentHistoryScreen extends StatelessWidget {
  final bool showAppBar;

  const AllAppointmentHistoryScreen({super.key, this.showAppBar = true});

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointments = DataService.appointments;

    return Scaffold(
      appBar: showAppBar ? AppBar(title: const Text('All Appointment History')) : null,
      body: appointments.isEmpty
          ? const Center(child: Text('No appointment history found'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appt = appointments[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${appt.patientName} → ${appt.doctor.name}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Chip(
                              label: Text(appt.status),
                              backgroundColor: _statusColor(appt.status).withOpacity(0.15),
                              labelStyle: TextStyle(color: _statusColor(appt.status)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text('Date: ${appt.date} | Time: ${appt.time}'),
                        Text('Issue: ${appt.problem}'),
                        Text('Prescription: ${appt.prescription.isEmpty ? 'Not added' : appt.prescription}'),
                        Text('Patient Email: ${appt.userEmail}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

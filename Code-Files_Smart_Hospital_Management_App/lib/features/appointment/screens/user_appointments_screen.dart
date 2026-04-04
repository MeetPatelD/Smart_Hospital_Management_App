import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/appointment.dart';
import '../../../services/data_service.dart';
import '../../auth/providers/auth_provider.dart';

class UserAppointmentsScreen extends StatefulWidget {
  final bool showAppBar;

  const UserAppointmentsScreen({super.key, this.showAppBar = true});

  @override
  State<UserAppointmentsScreen> createState() => _UserAppointmentsScreenState();
}

class _UserAppointmentsScreenState extends State<UserAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    final List<Appointment> myAppointments = DataService.appointments.where((appt) => appt.userEmail == user?.email).toList();

    return Scaffold(
      appBar: widget.showAppBar ? AppBar(title: const Text('My Appointments')) : null,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: myAppointments.isEmpty
            ? const Center(child: Text('No appointments yet'))
            : ListView.builder(
                itemCount: myAppointments.length,
                itemBuilder: (context, index) {
                  final appt = myAppointments[index];
                  final isCompleted = appt.status == 'Completed';
                  final isCancelled = appt.status == 'Cancelled';

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.calendar_today, color: Colors.blue),
                            title: Text('Dr. ${appt.doctor.name}'),
                            subtitle: Text('Date: ${appt.date} | Time: ${appt.time}\nStatus: ${appt.status}'),
                            trailing: Icon(
                              isCompleted
                                  ? Icons.check_circle
                                  : isCancelled
                                      ? Icons.cancel
                                      : Icons.pending,
                              color: isCompleted
                                  ? Colors.green
                                  : isCancelled
                                      ? Colors.red
                                      : Colors.orange,
                            ),
                          ),
                          Text('Issue: ${appt.problem}'),
                          if (appt.prescription.isNotEmpty) Text('Prescription: ${appt.prescription}'),
                          const SizedBox(height: 8),
                          if (appt.status == 'Pending')
                            Align(
                              alignment: Alignment.centerRight,
                              child: OutlinedButton.icon(
                                onPressed: () => setState(() => appt.status = 'Cancelled'),
                                icon: const Icon(Icons.cancel),
                                label: const Text('Cancel Appointment'),
                              ),
                            ),
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

import 'package:flutter/material.dart';
import '../../../core/widgets/stats_card.dart';
import '../../../services/data_service.dart';

class AdminAnalyticsScreen extends StatelessWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final total = DataService.appointments.length;
    final pending = DataService.appointments.where((a) => a.status == 'Pending').length;
    final cancelled = DataService.appointments.where((a) => a.status == 'Cancelled').length;
    final completed = DataService.appointments.where((a) => a.status == 'Completed').length;

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hospital Overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                StatsCard(title: 'Doctors', count: DataService.doctors.length, icon: Icons.medical_services, color: Colors.blue),
                StatsCard(title: 'Patients', count: DataService.patients.length, icon: Icons.people, color: Colors.green),
                StatsCard(title: 'Total Appts', count: total, icon: Icons.calendar_month, color: Colors.purple),
              ],
            ),
            Row(
              children: [
                StatsCard(title: 'Pending', count: pending, icon: Icons.pending_actions, color: Colors.amber),
                StatsCard(title: 'Cancelled', count: cancelled, icon: Icons.cancel, color: Colors.red),
                StatsCard(title: 'Completed', count: completed, icon: Icons.check_circle, color: Colors.teal),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.insights, color: Colors.deepPurple),
                title: const Text('Quick Insight'),
                subtitle: Text(
                  total == 0
                      ? 'No appointments booked yet.'
                      : 'Completion rate: ${((completed / total) * 100).toStringAsFixed(1)}% • Pending: $pending • Cancelled: $cancelled',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

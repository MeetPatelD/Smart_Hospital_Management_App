import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/widgets/dashboard_card.dart';
import '../../../core/widgets/stats_card.dart';
import '../../../core/routes/app_routes.dart';
import '../../../services/data_service.dart';
import '../../doctor/screens/doctor_appointments_screen.dart';
import '../../admin/screens/all_appointment_history_screen.dart';

class DashboardScreen extends StatelessWidget {
  final ValueChanged<int>? onNavigateToTab;

  const DashboardScreen({super.key, this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    final role = user?.role ?? 'User';
    final pendingCount = DataService.appointments.where((a) => a.status == 'Pending').length;
    final completedCount = DataService.appointments.where((a) => a.status == 'Completed').length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user?.name ?? ''}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, ${user?.name ?? ''} 👋', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              if (role == 'Admin') ...[
                Row(
                  children: [
                    StatsCard(title: 'Doctors', count: DataService.doctors.length, icon: Icons.medical_services, color: Colors.blue),
                    StatsCard(title: 'Patients', count: DataService.patients.length, icon: Icons.people, color: Colors.green),
                    StatsCard(title: 'Appointments', count: DataService.appointments.length, icon: Icons.calendar_today, color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    StatsCard(title: 'Pending', count: pendingCount, icon: Icons.pending_actions, color: Colors.amber),
                    StatsCard(title: 'Completed', count: completedCount, icon: Icons.check_circle, color: Colors.teal),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                DashboardCard(
                  title: 'Manage Doctors',
                  icon: Icons.medical_services,
                  color: Colors.blue,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.doctor),
                ),
                DashboardCard(
                  title: 'Manage Patients',
                  icon: Icons.people,
                  color: Colors.green,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.patient),
                ),
                DashboardCard(
                  title: 'All Appointment History',
                  icon: Icons.history,
                  color: Colors.deepPurple,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AllAppointmentHistoryScreen(showAppBar: true)));
                  },
                ),
              ],
              if (role == 'Doctor') ...[
                DashboardCard(
                  title: 'View My Appointments',
                  icon: Icons.calendar_today,
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorAppointmentsScreen()));
                  },
                ),
                DashboardCard(
                  title: 'Open Schedule',
                  icon: Icons.schedule,
                  color: Colors.green,
                  onTap: () => onNavigateToTab?.call(1),
                ),
                DashboardCard(
                  title: 'Open Profile',
                  icon: Icons.person,
                  color: Colors.orange,
                  onTap: () => onNavigateToTab?.call(2),
                ),
              ],
              if (role == 'User') ...[
                DashboardCard(
                  title: 'Book Appointment',
                  icon: Icons.calendar_today,
                  color: Colors.blue,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.appointment),
                ),
                DashboardCard(
                  title: 'View Doctors',
                  icon: Icons.people,
                  color: Colors.green,
                  onTap: () => onNavigateToTab?.call(2),
                ),
                DashboardCard(
                  title: 'My Appointments',
                  icon: Icons.list,
                  color: Colors.orange,
                  onTap: () => onNavigateToTab?.call(1),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

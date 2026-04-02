import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/providers/auth_provider.dart';
import 'dashboard_screen.dart';
import '../../appointment/screens/user_appointments_screen.dart';
import '../../doctor/screens/all_doctors_screen.dart';
import '../../doctor/screens/doctor_appointments_screen.dart';
import '../../doctor/screens/doctor_schedule_screen.dart';
import '../../doctor/screens/doctor_profile_screen.dart';
import '../../admin/screens/admin_analytics_screen.dart';
import '../../admin/screens/all_appointment_history_screen.dart';
import '../../../core/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void switchTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _buildPages(String role) {
    if (role == 'Admin') {
      return [
        DashboardScreen(onNavigateToTab: switchTab),
        const AdminAnalyticsScreen(),
        const AllAppointmentHistoryScreen(showAppBar: false),
      ];
    } else if (role == 'Doctor') {
      return [
        DashboardScreen(onNavigateToTab: switchTab),
        const DoctorScheduleScreen(),
        const DoctorProfileScreen(),
      ];
    } else {
      return [
        DashboardScreen(onNavigateToTab: switchTab),
        const UserAppointmentsScreen(showAppBar: false),
        const AllDoctorsScreen(showAppBar: false),
      ];
    }
  }

  List<BottomNavigationBarItem> _buildNavItems(String role) {
    if (role == 'Admin') {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
      ];
    } else if (role == 'Doctor') {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Schedule'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ];
    } else {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Doctors'),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = Provider.of<AuthProvider>(context).currentUser?.role ?? 'User';
    final pages = _buildPages(role);

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: switchTab,
        items: _buildNavItems(role),
      ),
      floatingActionButton: role == 'User' && _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.appointment),
              child: const Icon(Icons.add),
            )
          : role == 'Doctor' && _selectedIndex == 0
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorAppointmentsScreen()));
                  },
                  child: const Icon(Icons.calendar_month),
                )
              : null,
    );
  }
}

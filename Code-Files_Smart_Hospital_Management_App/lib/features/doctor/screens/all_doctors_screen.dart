import 'package:flutter/material.dart';
import '../../../models/doctor.dart';
import '../../../services/data_service.dart';
import '../../../core/routes/app_routes.dart';

class AllDoctorsScreen extends StatelessWidget {
  final bool showAppBar;

  const AllDoctorsScreen({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    final List<Doctor> doctors = DataService.doctors;

    return Scaffold(
      appBar: showAppBar ? AppBar(title: const Text('All Doctors')) : null,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: doctors.isEmpty
            ? const Center(child: Text('No doctors available'))
            : ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(doctor.name),
                      subtitle: Text(doctor.specialization),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.appointment, arguments: doctor);
                        },
                        child: const Text('Book'),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

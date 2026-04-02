import 'package:flutter/material.dart';
import '../../../models/doctor.dart';
import '../../../services/data_service.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final nameController = TextEditingController();
  final specializationController = TextEditingController();
  final emailController = TextEditingController();

  void addDoctor() {
    if (nameController.text.isEmpty || specializationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill all fields')));
      return;
    }

    final doctor = Doctor(
      name: nameController.text.trim(),
      specialization: specializationController.text.trim(),
      email: emailController.text.trim(),
    );

    setState(() {
      DataService.doctors.add(doctor);
    });

    nameController.clear();
    specializationController.clear();
    emailController.clear();
  }

  void deleteDoctor(Doctor doctor) {
    setState(() {
      DataService.doctors.remove(doctor);
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctors = DataService.doctors;

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Doctors')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(controller: nameController, hintText: 'Doctor Name', icon: Icons.person),
            const SizedBox(height: 10),
            CustomTextField(controller: specializationController, hintText: 'Specialization', icon: Icons.medical_services),
            const SizedBox(height: 10),
            CustomTextField(controller: emailController, hintText: 'Doctor Email (optional)', icon: Icons.email),
            const SizedBox(height: 10),
            CustomButton(text: 'Add Doctor', icon: Icons.add, onPressed: addDoctor),
            const SizedBox(height: 20),
            Expanded(
              child: doctors.isEmpty
                  ? const Center(child: Text('No doctors added'))
                  : ListView.builder(
                      itemCount: doctors.length,
                      itemBuilder: (context, index) {
                        final doc = doctors[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.medical_services, color: Colors.blue),
                            title: Text(doc.name),
                            subtitle: Text('${doc.specialization}${doc.email.isNotEmpty ? '\n${doc.email}' : ''}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteDoctor(doc),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

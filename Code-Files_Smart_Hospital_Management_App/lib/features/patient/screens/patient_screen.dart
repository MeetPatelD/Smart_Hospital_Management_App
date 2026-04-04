import 'package:flutter/material.dart';
import '../../../models/patient.dart';
import '../../../services/data_service.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  void addPatient() {
    if (nameController.text.isEmpty || ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill all fields')));
      return;
    }

    final patient = Patient(name: nameController.text.trim(), age: int.tryParse(ageController.text) ?? 0);

    setState(() {
      DataService.patients.add(patient);
    });

    nameController.clear();
    ageController.clear();
  }

  void deletePatient(Patient patient) {
    setState(() {
      DataService.patients.remove(patient);
    });
  }

  @override
  Widget build(BuildContext context) {
    final patients = DataService.patients;

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Patients')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(controller: nameController, hintText: 'Patient Name', icon: Icons.person),
            const SizedBox(height: 10),
            CustomTextField(controller: ageController, hintText: 'Age', icon: Icons.cake, keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            CustomButton(text: 'Add Patient', icon: Icons.add, onPressed: addPatient),
            const SizedBox(height: 20),
            Expanded(
              child: patients.isEmpty
                  ? const Center(child: Text('No patients added'))
                  : ListView.builder(
                      itemCount: patients.length,
                      itemBuilder: (context, index) {
                        final p = patients[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.person, color: Colors.green),
                            title: Text(p.name),
                            subtitle: Text('Age: ${p.age}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deletePatient(p),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/doctor.dart';
import '../../../models/appointment.dart';
import '../../../services/data_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/widgets/custom_button.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final problemController = TextEditingController();
  Doctor? selectedDoctor;

  void bookAppointment(Doctor doctor) {
    if (selectedDate == null || selectedTime == null || problemController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;

    final appointment = Appointment(
      doctor: doctor,
      patientName: user?.name ?? 'Unknown',
      age: 0,
      gender: 'Not Specified',
      problem: problemController.text.trim(),
      date: selectedDate.toString().split(' ')[0],
      time: selectedTime!.format(context),
      userEmail: user?.email ?? 'Unknown',
    );

    setState(() {
      DataService.appointments.add(appointment);
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment Booked')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Doctor? routeDoctor = ModalRoute.of(context)!.settings.arguments as Doctor?;
    selectedDoctor ??= routeDoctor;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (routeDoctor == null) ...[
                const Text('Select Doctor', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<Doctor>(
                  value: selectedDoctor,
                  items: DataService.doctors
                      .map((doctor) => DropdownMenuItem<Doctor>(
                            value: doctor,
                            child: Text('${doctor.name} - ${doctor.specialization}'),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => selectedDoctor = value),
                  decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Choose doctor'),
                ),
                const SizedBox(height: 20),
              ],
              if (selectedDoctor != null) ...[
                Text('Doctor: ${selectedDoctor!.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Specialization: ${selectedDoctor!.specialization}'),
                const SizedBox(height: 20),
              ],
              ListTile(
                title: Text(selectedDate == null ? 'Select Date' : selectedDate.toString().split(' ')[0]),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => selectedDate = picked);
                },
              ),
              ListTile(
                title: Text(selectedTime == null ? 'Select Time' : selectedTime!.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (picked != null) setState(() => selectedTime = picked);
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: problemController,
                decoration: const InputDecoration(labelText: 'What is your problem?', border: OutlineInputBorder()),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Confirm Appointment',
                icon: Icons.check,
                onPressed: () {
                  if (selectedDoctor == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a doctor')));
                    return;
                  }
                  bookAppointment(selectedDoctor!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

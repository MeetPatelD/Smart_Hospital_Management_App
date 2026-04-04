import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/providers/app_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String selectedRole = 'User';

  void handleLogin() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    appProvider.setLoading(true);
    await Future.delayed(const Duration(milliseconds: 500));

    bool success = authProvider.login(
      emailController.text.trim(),
      passwordController.text.trim(),
      selectedRole,
    );

    appProvider.setLoading(false);

    if (success) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AppProvider>(context).isLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_hospital, size: 80, color: Colors.red),
              const SizedBox(height: 10),
              const Text('Smart Hospital', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              CustomTextField(controller: emailController, hintText: 'Enter Email', icon: Icons.email),
              const SizedBox(height: 15),
              CustomTextField(controller: passwordController, hintText: 'Enter Password', icon: Icons.lock, isPassword: true),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: ['Admin', 'Doctor', 'User']
                    .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                    .toList(),
                onChanged: (value) => setState(() => selectedRole = value!),
                decoration: const InputDecoration(labelText: 'Select Role'),
              ),
              const SizedBox(height: 25),
              CustomButton(text: 'Login', icon: Icons.login, isLoading: isLoading, onPressed: handleLogin),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
                child: const Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

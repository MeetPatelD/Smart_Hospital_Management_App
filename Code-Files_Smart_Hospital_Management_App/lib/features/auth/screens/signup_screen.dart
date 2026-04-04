import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/providers/app_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void handleSignup() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    if (nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill all fields')));
      return;
    }

    appProvider.setLoading(true);
    await Future.delayed(const Duration(milliseconds: 500));

    bool success = authProvider.signup(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    appProvider.setLoading(false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signup successful')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User already exists')));
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
              const Text('Create Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              CustomTextField(controller: nameController, hintText: 'Enter Name', icon: Icons.person),
              const SizedBox(height: 15),
              CustomTextField(controller: emailController, hintText: 'Enter Email', icon: Icons.email),
              const SizedBox(height: 15),
              CustomTextField(controller: passwordController, hintText: 'Enter Password', icon: Icons.lock, isPassword: true),
              const SizedBox(height: 25),
              CustomButton(text: 'Sign Up', icon: Icons.app_registration, isLoading: isLoading, onPressed: handleSignup),
              const SizedBox(height: 10),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Already have an account? Login')),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fashion_hub/utils/snackbar.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _email = '';

  void _resetPassword() {
    if (_email.isNotEmpty) {
      // Simulate sending a password reset email
      showSnackBar(context, text: "Password reset link sent to $_email");
      Navigator.pop(context); // Go back to the login screen
    } else {
      showSnackBar(context, text: "Please enter your email");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your email to reset your password',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Email TextField
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Reset Password Button
            ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
              ),
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}

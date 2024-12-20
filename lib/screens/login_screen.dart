import 'package:fashion_hub/utils/image_paths.dart';
import 'package:fashion_hub/utils/snackbar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;

  final List<Map<String, String>> _validUsers = [
    {"email": "test", "password": "test"},
    {"email": "admin", "password": "admin123"},
    {"email": "user", "password": "admin123"},
  ];

  bool _validateForm() {
    return _email.isNotEmpty && _password.isNotEmpty;
  }

  void _login() {
    if (_validateForm()) {
      bool isValidUser = _validUsers.any(
          (user) => user['email'] == _email && user['password'] == _password);

      if (isValidUser) {
        showSnackBar(context, text: "Login successful!");
        Navigator.pushNamed(context, '/home');
      } else {
        showSnackBar(context, text: "Incorrect email or password");
      }
    } else {
      showSnackBar(context, text: "Please fill in all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: AppColor.kPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Center logo
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      LogoPath.kRectangleBackgound,
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

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

              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(height: 10),

              // Forgot Password Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgetPassword');
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColor.kPrimary),
                  ),
                ),
              ),

              // Login Button
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.kPrimary,
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),

              // Register Button
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Don’t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

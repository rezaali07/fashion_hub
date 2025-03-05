import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fashion_hub/app/constants/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:flutter/services.dart';  // For SystemChrome

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Dio dio = Dio();
  bool isLoading = false;
  String? errorMessage;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  File? _image;
  String? _base64Image;
  String avatarPreview =
      "https://th.bing.com/th/id/OIP._3VIIBDaF4qjXmuSn73vaAHaHa?w=512&h=512&rs=1&pid=ImgDetMain";
  bool isScreenDimmed = false;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
    _listenToProximitySensor();  // Start listening to proximity sensor
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchUserProfile() async {
    setState(() => isLoading = true);
    try {
      String? token = await getToken();
      if (token == null) {
        showError("Authentication token is missing. Please log in again.");
        return;
      }

      final response = await dio.get(
        ApiEndpoints.getUserProfile, 
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Cookie': 'token=$token',
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          nameController.text = response.data['user']['name'];
          emailController.text = response.data['user']['email'];
          avatarPreview = response.data['user']['avatar']['url'];
        });
      } else if (response.statusCode == 401) {
        showError("Unauthorized access. Please log in again.");
      }
    } catch (e) {
      showError("Failed to load profile");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateProfile() async {
    setState(() => isLoading = true);
    try {
      String? token = await getToken();
      if (token == null) {
        showError("Session expired. Please log in again.");
        return;
      }

      Map<String, dynamic> data = {
        "name": nameController.text,
        "email": emailController.text,
      };

      if (_base64Image != null) {
        data["avatar"] = "data:image/png;base64,$_base64Image";
      }

      final response = await dio.put(
        ApiEndpoints.updateProfile, 
        data: data,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Cookie': 'token=$token',
        }),
      );

      if (response.statusCode == 200) {
        showSuccess("Profile updated successfully");
      } else if (response.statusCode == 401) {
        showError("Unauthorized access. Please log in again.");
      }
    } catch (e) {
      showError("Error updating profile: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updatePassword() async {
    setState(() => isLoading = true);
    try {
      String? token = await getToken();
      if (token == null) {
        showError("Session expired. Please log in again.");
        return;
      }

      Map<String, dynamic> data = {
        "oldPassword": oldPasswordController.text,
        "newPassword": newPasswordController.text,
        "passwordConfirm": passwordConfirmController.text,
      };

      final response = await dio.put(
        ApiEndpoints.updatePassword, 
        data: data,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Cookie': 'token=$token',
        }),
      );

      if (response.statusCode == 200) {
        showSuccess("Password updated successfully");
      } else if (response.statusCode == 401) {
        showError("Unauthorized access. Please log in again.");
      }
    } catch (e) {
      showError("Error updating password: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.select_all),
              title: const Text('Choose one option'),
              
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = File(pickedFile.path);
        _base64Image = base64Encode(bytes);
        avatarPreview = pickedFile.path;
      });
    }
  }

  Future<void> logout() async {
    setState(() => isLoading = true);
    try {
      String? token = await getToken();
      if (token == null) {
        showError("Session expired. Please log in again.");
        return;
      }

      final response = await dio.get(
        ApiEndpoints.logout, 
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Cookie': 'token=$token',
        }),
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        Navigator.of(context).pushReplacementNamed('/login');
        showSuccess("Logged out successfully");
      } else {
        showError("Failed to log out. Please try again.");
      }
    } catch (e) {
      showError("Error logging out: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showError(String message) {
    setState(() => errorMessage = message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void showPasswordUpdateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordController,
                decoration: const InputDecoration(
                    labelText: "Old Password", prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                    labelText: "New Password", prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordConfirmController,
                decoration: const InputDecoration(
                    labelText: "Confirm Password", prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                updatePassword();
                Navigator.of(context).pop();
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showLogoutDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log out"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                logout();
                Navigator.of(context).pop();
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  // Proximity sensor logic
  void _listenToProximitySensor() {
    ProximitySensor.events.listen((event) {
      // If the event is 1 (meaning something is near)
      if (event == 1) {
        setState(() {
          isScreenDimmed = true;
        });
        // Hide the system UI (status bar, navigation bar)
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        setState(() {
          isScreenDimmed = false;
        });
        // Show the system UI again (status bar, navigation bar)
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isScreenDimmed ? Colors.black : Colors.white,  // Change the background to black when screen is dimmed
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: showLogoutDialog,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : NetworkImage(avatarPreview) as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: updateProfile,
                    child: const Text("Update Profile"),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: showPasswordUpdateDialog,
                    child: const Text("Change Password"),
                  ),
                ],
              ),
            ),
    );
  }
}

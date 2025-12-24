import 'package:flutter/material.dart';
import 'package:week5_task/screens/profile_screen.dart';
import 'package:week5_task/screens/signup_screen.dart';
import 'package:week5_task/services/auth_service.dart';
import 'package:week5_task/services/firestore_service.dart';
import 'package:week5_task/widgets/custom_button.dart';
import 'package:week5_task/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  final authService = AuthService();
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Sign in to continue your journey",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // Form Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Email Field
                      CustomTextfield(
                        controller: emailCtrl,
                        hint: "Email Address",
                        prefixIcon: Icons.email_outlined,
                        fillColor: Colors.grey.shade50,
                        borderColor: Colors.grey.shade300,
                        focusColor: Colors.blueAccent,
                      ),

                      const SizedBox(height: 20),

                      // Password Field
                      CustomTextfield(
                        controller: passCtrl,
                        hint: "Password",
                        obscure: true,
                        isPasswordField: true,
                        prefixIcon: Icons.lock_outline,
                        fillColor: Colors.grey.shade50,
                        borderColor: Colors.grey.shade300,
                        focusColor: Colors.blueAccent,
                      ),

                      const SizedBox(height: 12),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // NEW LOGIN BUTTON
                      CustomButton(
                        title: "Login to Account",
                        onTap: () async {
                          // Your existing logic here
                          final user = await authService.login(
                            emailCtrl.text.trim(),
                            passCtrl.text.trim(),
                          );

                          if (user != null) {
                            final doc = await firestoreService.getUser(user.uid);

                            if (!doc.exists) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Profile data not found. Please signup again."),
                                ),
                              );
                              return;
                            }

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProfileScreen(),
                              ),
                            );
                          }
                        },
                        prefixIcon: Icons.login_rounded,
                        backgroundColor: Colors.blueAccent,
                        textColor: Colors.white,
                        height: 58,
                        borderRadius: 14,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.grey.shade300),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey.shade300),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // NEW SIGNUP BUTTON (Secondary)
                CustomButton(
                  title: "Create New Account",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignupScreen(),
                      ),
                    );
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.blueAccent,
                  height: 56,
                  borderRadius: 12,
                  hasShadow: false,
                  prefixIcon: Icons.person_add_alt_1_rounded,
                ),

                const SizedBox(height: 40),

                // Footer
                Center(
                  child: Text(
                    "By continuing, you agree to our Terms & Privacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:week5_task/screens/profile_screen.dart';
import 'package:week5_task/services/auth_service.dart';
import 'package:week5_task/services/firestore_service.dart';
import 'package:week5_task/widgets/custom_button.dart';
import 'package:week5_task/widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  final AuthService authService = AuthService();
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Screen width check for responsiveness
            final bool isSmallScreen = constraints.maxWidth < 400;
            
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 16 : 24,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Button (Fixed Position)
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.grey.shade700,
                              size: 22,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Header Section (Fixed Width)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: isSmallScreen ? 24 : 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Sign up to get started with amazing features",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14 : 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Form Section (Fixed Width Container)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name Field
                              CustomTextfield(
                                controller: nameCtrl,
                                hint: "Full Name",
                                prefixIcon: Icons.person_outline,
                                fillColor: Colors.grey.shade50,
                                borderColor: Colors.grey.shade300,
                                focusColor: Colors.blueAccent,
                                borderRadius: 12,
                              ),

                              const SizedBox(height: 16),

                              // Email Field
                              CustomTextfield(
                                controller: emailCtrl,
                                hint: "Email Address",
                                prefixIcon: Icons.email_outlined,
                                fillColor: Colors.grey.shade50,
                                borderColor: Colors.grey.shade300,
                                focusColor: Colors.blueAccent,
                                borderRadius: 12,
                              ),

                              const SizedBox(height: 16),

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
                                borderRadius: 12,
                              ),

                              const SizedBox(height: 10),

                              // Password Requirements (Fixed Width)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Password must contain:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Wrap(
                                      spacing: 12,
                                      runSpacing: 6,
                                      children: [
                                        _buildPasswordRequirement("At least 8 characters"),
                                        _buildPasswordRequirement("One uppercase letter"),
                                        _buildPasswordRequirement("One number"),
                                        _buildPasswordRequirement("One special character"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 30),

                              // SIGNUP BUTTON (Fixed Width)
                              SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  title: "Create Account Now",
                                  onTap: () async {
                                    final user = await authService.signup(
                                      emailCtrl.text,
                                      passCtrl.text,
                                    );

                                    if (user != null) {
                                      await firestoreService.saveUser(
                                        user.uid,
                                        nameCtrl.text.trim(),
                                        emailCtrl.text.trim(),
                                      );

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ProfileScreen(),
                                        ),
                                      );
                                    }
                                  },
                                  prefixIcon: Icons.how_to_reg_rounded,
                                  backgroundColor: Colors.blueAccent,
                                  textColor: Colors.white,
                                  height: 54,
                                  borderRadius: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Divider (Responsive)
                        Row(
                          children: [
                            Expanded(
                              child: Divider(color: Colors.grey.shade300),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16),
                              child: Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 13 : 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(color: Colors.grey.shade300),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // LOGIN BUTTON (Fixed Width)
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            title: "Sign In Instead",
                            onTap: () => Navigator.pop(context),
                            backgroundColor: Colors.white,
                            textColor: Colors.grey.shade700,
                            height: 52,
                            borderRadius: 12,
                            hasShadow: false,
                            prefixIcon: Icons.login_rounded,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Terms Agreement (Fixed Width Text)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 4 : 8),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: isSmallScreen ? 11 : 12,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                              children: [
                                const TextSpan(text: "By creating an account, you agree to our "),
                                TextSpan(
                                  text: "Terms of Service",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Add extra space at bottom for scrolling
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 6, color: Colors.grey.shade400),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
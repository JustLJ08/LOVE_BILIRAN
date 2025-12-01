import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/themes/colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';
import '../../widgets/common/loading_indicator.dart';
import 'admin_dashboard.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AdminDashboard()),
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingIndicator();
          }
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.admin_panel_settings,
                        size: 80, color: AppColors.primary),
                    const SizedBox(height: 20),
                    Text("Admin Portal",
                        style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark)),
                    const SizedBox(height: 10),
                    Text("Please sign in to continue",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: AppColors.textLight)),
                    const SizedBox(height: 40),
                    CustomTextField(
                      controller: _emailCtrl,
                      label: "Email Address",
                      icon: Icons.email_outlined,
                      validator: (val) =>
                          val!.isEmpty ? "Email is required" : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _passCtrl,
                      label: "Password",
                      icon: Icons.lock_outlined,
                      isPassword: true,
                      validator: (val) =>
                          val!.isEmpty ? "Password is required" : null,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "Sign In",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignInRequested(
                              email: _emailCtrl.text.trim(),
                              password: _passCtrl.text.trim()));
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Back to Home",
                          style: GoogleFonts.poppins(color: AppColors.primary)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
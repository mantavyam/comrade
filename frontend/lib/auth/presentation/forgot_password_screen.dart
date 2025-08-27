import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/utils/responsive_utils.dart';
import '../application/auth_cubit.dart';
import '../application/auth_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _focusNode = FocusNode();
  bool _emailSent = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.authDataState.isSuccess && !_emailSent) {
            setState(() {
              _emailSent = true;
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset email sent successfully!'),
                backgroundColor: KColors.success,
              ),
            );
          }
          
          if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Failed to send reset email'),
                backgroundColor: KColors.error,
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(KSizes.padding6x),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      iconSize: KSizes.iconL,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin8x),
                  
                  // Title
                  Text(
                    _emailSent ? 'Email Sent!' : 'Forgot Password?',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: KSizes.margin4x),
                  
                  // Subtitle
                  Text(
                    _emailSent 
                        ? 'We\'ve sent a password reset link to your email address.'
                        : 'Enter your email address and we\'ll send you a link to reset your password.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: KColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: KSizes.margin12x),
                  
                  if (!_emailSent) ...[
                    // Email input field
                    TextFormField(
                      controller: _emailController,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          size: KSizes.iconM,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(KSizes.radiusM),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: KSizes.margin8x),
                    
                    // Send Reset Email button
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: !state.isLoading ? _sendResetEmail : null,
                            child: state.isLoading
                                ? const CircularProgressIndicator()
                                : const Text('Send Reset Email'),
                          ),
                        );
                      },
                    ),
                  ] else ...[
                    // Success actions
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Back to Login'),
                      ),
                    ),
                  ],
                  
                  const Spacer(),
                  
                  const SizedBox(height: KSizes.margin6x),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendResetEmail() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
    }
  }
}

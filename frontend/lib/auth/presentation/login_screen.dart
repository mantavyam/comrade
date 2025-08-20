import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/constants/k_strings.dart';
import '../../core/presentation/main_navigation.dart';
import '../application/auth_cubit.dart';
import '../application/auth_state.dart';
import 'signup_name_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.hasError && state.lastError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? KStrings.error),
                backgroundColor: KColors.error,
              ),
            );
          }
          
          if (state.isAuthenticated) {
            // Navigate to main navigation
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainNavigation(),
              ),
              (route) => false,
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
                  // Skip Button
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        context.read<AuthCubit>().enterGuestMode();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const MainNavigation(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(KStrings.skip),
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin4x),
                  
                  // Logo
                  const Icon(
                    Icons.shield,
                    size: KSizes.iconXXL * 2,
                    color: KColors.primary,
                  ),
                  
                  const SizedBox(height: KSizes.margin6x),
                  
                  // Welcome Back Title
                  Text(
                    KStrings.welcomeBack,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin8x),
                  
                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: KStrings.email,
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: KSizes.margin4x),
                  
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: KStrings.password,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: KSizes.margin2x),
                  
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(KStrings.forgetPassword),
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin6x),
                  
                  // Sign In Button
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isLoading ? null : _signIn,
                          child: state.isLoading
                              ? const SizedBox(
                                  height: KSizes.iconS,
                                  width: KSizes.iconS,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: KColors.buttonText,
                                  ),
                                )
                              : const Text(KStrings.signIn),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: KSizes.margin6x),
                  
                  // Or Divider
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: KSizes.padding4x),
                        child: Text(
                          KStrings.or,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: KColors.textSecondary,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  
                  const SizedBox(height: KSizes.margin6x),
                  
                  // Google Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<AuthCubit>().signInWithGoogle();
                      },
                      icon: const Icon(Icons.g_mobiledata, size: KSizes.iconL),
                      label: const Text(KStrings.signInWithGoogle),
                    ),
                  ),
                  
                  const SizedBox(height: KSizes.margin4x),
                  
                  // Phone Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Navigate to phone sign in flow
                        _showPhoneSignInDialog();
                      },
                      icon: const Icon(Icons.phone, size: KSizes.iconM),
                      label: const Text(KStrings.signInWithPhone),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Don't have account
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpNameScreen(),
                        ),
                      );
                    },
                    child: const Text(KStrings.dontHaveAccount),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  void _showPhoneSignInDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Phone Sign In'),
        content: const Text('Phone sign in will be implemented in the next phase.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

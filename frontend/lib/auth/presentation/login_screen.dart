import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/constants/k_strings.dart';
import '../../core/presentation/main_navigation.dart';
import '../application/auth_cubit.dart';
import '../application/auth_state.dart';
import 'widgets/signup_bottom_sheet.dart';
import 'widgets/social_sign_in_button.dart';
import 'widgets/auth_form_field.dart';
import 'phone_auth_screen.dart';
import 'name_capture_screen.dart';
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
            // User is fully authenticated, navigate to main navigation
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainNavigation(),
              ),
              (route) => false,
            );
          } else if (state.isPartiallyAuthenticated) {
            // User signed in with Google but needs to complete onboarding
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const NameCaptureScreen(),
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
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return AuthFormField(
                        controller: _emailController,
                        label: KStrings.email,
                        hintText: 'Enter your email address',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        errorText: state.hasError && state.lastError?.toString().contains('email') == true
                            ? state.errorMessage
                            : null,
                        onChanged: (_) => context.read<AuthCubit>().clearError(),
                      );
                    },
                  ),

                  const SizedBox(height: KSizes.margin4x),

                  // Password Field
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return AuthFormField(
                        controller: _passwordController,
                        label: KStrings.password,
                        hintText: 'Enter your password',
                        obscureText: _obscurePassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onSuffixIconPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        errorText: state.hasError && state.lastError?.toString().contains('password') == true
                            ? state.errorMessage
                            : null,
                        onChanged: (_) => context.read<AuthCubit>().clearError(),
                      );
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
                      return LoadingButton(
                        onPressed: _signIn,
                        text: KStrings.signIn,
                        isLoading: state.isLoading,
                        icon: Icons.login,
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
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return SocialSignInButton(
                        provider: SocialSignInProvider.google,
                        onPressed: () => context.read<AuthCubit>().signInWithGoogle(),
                        isLoading: state.isLoading,
                      );
                    },
                  ),

                  const SizedBox(height: KSizes.margin3x),

                  // Apple Sign In Button (iOS only)
                  if (Platform.isIOS) ...[
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return SocialSignInButton(
                          provider: SocialSignInProvider.apple,
                          onPressed: () => context.read<AuthCubit>().signInWithApple(),
                          isLoading: state.isLoading,
                        );
                      },
                    ),
                    const SizedBox(height: KSizes.margin3x),
                  ],

                  // Phone Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PhoneAuthScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.phone, size: KSizes.iconM),
                      label: const Text(KStrings.signInWithPhone),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Don't have account
                  TextButton(
                    onPressed: () {
                      SignupBottomSheet.show(context);
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


}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/k_sizes.dart';
import '../application/auth_cubit.dart';
import '../application/auth_state.dart';
import '../domain/auth_error.dart';
import 'widgets/phone_number_input.dart';
import 'widgets/otp_input_widget.dart';
import 'widgets/auth_form_field.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _pageController = PageController();
  
  bool _isPhoneStep = true;
  String? _phoneNumber;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _isPhoneStep ? 'Phone Verification' : 'Enter OTP',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.phoneVerificationState.isSuccess) {
            // Phone number sent successfully, move to OTP step
            setState(() {
              _isPhoneStep = false;
              _phoneNumber = _phoneController.text;
            });
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else if (state.authDataState.isSuccess) {
            // OTP verified successfully, user is signed in
            Navigator.of(context).pop();
          }
        },
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildPhoneStep(),
            _buildOtpStep(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneStep() {
    return Padding(
      padding: EdgeInsets.all(KSizes.padding6x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: KSizes.margin8x),
          
          // Header
          Text(
            'Enter your phone number',
            style: TextStyle(
              fontSize: KSizes.fontSizeXXL,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: KSizes.margin2x),
          
          Text(
            'We\'ll send you a verification code to confirm your phone number.',
            style: TextStyle(
              fontSize: KSizes.fontSizeM,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          
          const SizedBox(height: KSizes.margin8x),
          
          // Phone number input
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return PhoneNumberInput(
                controller: _phoneController,
                errorText: state.phoneVerificationState.hasError 
                    ? _getErrorMessage(state.lastError)
                    : null,
                onChanged: () => context.read<AuthCubit>().clearError(),
                enabled: !state.phoneVerificationState.isLoading,
              );
            },
          ),
          
          const Spacer(),
          
          // Continue button
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return LoadingButton(
                onPressed: _sendOtp,
                text: 'Send Verification Code',
                isLoading: state.phoneVerificationState.isLoading,
                icon: Icons.send,
              );
            },
          ),
          
          const SizedBox(height: KSizes.margin4x),
        ],
      ),
    );
  }

  Widget _buildOtpStep() {
    return Padding(
      padding: EdgeInsets.all(KSizes.padding6x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: KSizes.margin8x),
          
          // Header
          Text(
            'Verify your phone',
            style: TextStyle(
              fontSize: KSizes.fontSizeXXL,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: KSizes.margin2x),
          
          Text(
            'Enter the 6-digit code sent to',
            style: TextStyle(
              fontSize: KSizes.fontSizeM,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: KSizes.margin1x),
          
          Text(
            _phoneNumber ?? '',
            style: TextStyle(
              fontSize: KSizes.fontSizeM,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: KSizes.margin8x),
          
          // OTP input
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return OtpInputWidget(
                onCompleted: _verifyOtp,
                onChanged: (_) => context.read<AuthCubit>().clearError(),
                errorText: state.authDataState.hasError 
                    ? _getErrorMessage(state.lastError)
                    : null,
                hasError: state.authDataState.hasError,
              );
            },
          ),
          
          const SizedBox(height: KSizes.margin6x),
          
          // Resend button
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return OtpResendButton(
                onPressed: () {
                  if (_phoneNumber != null) {
                    context.read<AuthCubit>().signInWithPhoneNumber(
                      phoneNumber: _phoneNumber!,
                    );
                  }
                },
              );
            },
          ),
          
          const Spacer(),
          
          // Back to phone number
          TextButton(
            onPressed: () {
              setState(() {
                _isPhoneStep = true;
              });
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Change phone number'),
          ),
          
          const SizedBox(height: KSizes.margin4x),
        ],
      ),
    );
  }

  void _sendOtp() {
    final phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isNotEmpty) {
      context.read<AuthCubit>().signInWithPhoneNumber(
        phoneNumber: phoneNumber,
      );
    }
  }

  void _verifyOtp(String otp) {
    context.read<AuthCubit>().verifyPhoneNumber(
      otpCode: otp,
    );
  }

  String? _getErrorMessage(AuthError? error) {
    if (error == null) return null;
    
    switch (error) {
      case AuthError.invalidPhoneNumber:
        return 'Please enter a valid phone number';
      case AuthError.invalidOtp:
        return 'Invalid verification code';
      case AuthError.otpExpired:
        return 'Verification code has expired';
      case AuthError.tooManyRequests:
        return 'Too many attempts. Please try again later';
      case AuthError.networkError:
        return 'Network error. Please check your connection';
      default:
        return 'An error occurred. Please try again';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/presentation/main_navigation.dart';
import '../application/auth_cubit.dart';
import '../application/auth_state.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String? verificationId;

  const OtpVerificationScreen({
    super.key,
    required this.name,
    required this.phoneNumber,
    this.verificationId,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4, 
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4, 
    (index) => FocusNode(),
  );
  
  bool _isVerifying = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // Auto-focus the first OTP field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.phoneVerificationState.isSuccess) {
            // Phone verification successful, complete onboarding
            print('📱 Phone verification successful, completing onboarding...');
            context.read<AuthCubit>().completeOnboarding();
          }

          if (state.isAuthenticated) {
            // User is fully authenticated, navigate to main app
            print('📱 User fully authenticated, navigating to main app');
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainNavigation(),
              ),
              (route) => false,
            );
          }

          if (state.hasError) {
            print('📱 OTP verification error: ${state.errorMessage}');
            setState(() {
              _hasError = true;
              _isVerifying = false;
            });
            _clearOtpFields();
            _focusNodes[0].requestFocus();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Invalid OTP. Please try again.'),
                backgroundColor: KColors.error,
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(KSizes.padding6x),
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
                
                // Progress indicator (3 of 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProgressDot(isActive: true),
                    const SizedBox(width: KSizes.margin2x),
                    _buildProgressDot(isActive: true),
                    const SizedBox(width: KSizes.margin2x),
                    _buildProgressDot(isActive: true),
                  ],
                ),
                
                const SizedBox(height: KSizes.margin12x),
                
                // Title
                Text(
                  'Enter the code we texted you',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: KSizes.fontSizeHeading,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: KSizes.margin2x),
                
                // Phone number display
                Text(
                  'on ${widget.phoneNumber}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: KColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: KSizes.margin12x),
                
                // OTP input boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) => _buildOtpBox(index)),
                ),
                
                const SizedBox(height: KSizes.margin8x),
                
                // Resend OTP
                TextButton(
                  onPressed: _resendOtp,
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                      color: KColors.primary,
                      fontSize: KSizes.fontSizeL,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Loading indicator when verifying
                if (_isVerifying)
                  const CircularProgressIndicator(),
                
                const SizedBox(height: KSizes.margin6x),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressDot({required bool isActive}) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive 
            ? KColors.primary 
            : KColors.textSecondary.withValues(alpha: 0.3),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(KSizes.radiusM),
        border: Border.all(
          color: _hasError 
              ? KColors.error
              : _otpControllers[index].text.isNotEmpty
                  ? KColors.primary
                  : KColors.textSecondary.withValues(alpha: 0.3),
          width: _hasError || _otpControllers[index].text.isNotEmpty ? 2 : 1,
        ),
        color: _hasError 
            ? KColors.error.withValues(alpha: 0.1)
            : _otpControllers[index].text.isNotEmpty
                ? KColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
      ),
      child: TextFormField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: TextStyle(
          fontSize: KSizes.fontSizeLargeHeading,
          fontWeight: FontWeight.bold,
          color: _hasError ? KColors.error : null,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (value) {
          setState(() {
            _hasError = false;
          });
          
          if (value.isNotEmpty) {
            // Move to next field
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else {
              // All fields filled, verify OTP
              _verifyOtp();
            }
          } else {
            // Move to previous field on backspace
            if (index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          }
        },
        onTap: () {
          // Clear error state when user taps
          setState(() {
            _hasError = false;
          });
        },
      ),
    );
  }

  void _verifyOtp() {
    final otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length == 4) {
      setState(() {
        _isVerifying = true;
      });

      // Use Firebase phone verification through auth cubit
      context.read<AuthCubit>().verifyPhoneNumber(otpCode: otp);
    }
  }

  void _clearOtpFields() {
    for (var controller in _otpControllers) {
      controller.clear();
    }
  }

  void _resendOtp() {
    // Use Firebase resend OTP through auth cubit
    context.read<AuthCubit>().resendOtp();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP resent successfully'),
        backgroundColor: KColors.success,
      ),
    );
  }
}

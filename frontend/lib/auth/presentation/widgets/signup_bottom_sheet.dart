import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/k_colors.dart';
import '../../../core/constants/k_sizes.dart';
import '../../../core/constants/k_strings.dart';
import '../../application/auth_cubit.dart';
import '../../application/auth_state.dart';

class SignupBottomSheet extends StatelessWidget {
  const SignupBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => const SignupBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(KSizes.radiusXL),
          topRight: Radius.circular(KSizes.radiusXL),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.padding6x),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: KColors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(KSizes.radiusS),
                ),
              ),
              
              const SizedBox(height: KSizes.margin6x),
              
              // Title
              Text(
                'Join Comrade',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: KSizes.margin2x),
              
              // Subtitle
              Text(
                'Start your defense preparation journey',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: KColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: KSizes.margin8x),
              
              // Google Sign Up Button
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: state.isLoading ? null : () => _signUpWithGoogle(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        side: BorderSide(
                          color: KColors.textSecondary.withValues(alpha: 0.2),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: KSizes.padding4x,
                          horizontal: KSizes.padding6x,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(KSizes.radiusButton),
                        ),
                      ),
                      icon: state.isLoading
                          ? SizedBox(
                              width: KSizes.iconM,
                              height: KSizes.iconM,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black87,
                              ),
                            )
                          : Image.asset(
                              'assets/icons/google_icon.png',
                              width: KSizes.iconM,
                              height: KSizes.iconM,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.g_mobiledata,
                                size: KSizes.iconL,
                                color: Colors.black87,
                              ),
                            ),
                      label: Text(
                        state.isLoading ? 'Signing up...' : 'Sign Up with Google',
                        style: const TextStyle(
                          fontSize: KSizes.fontSizeL,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: KSizes.margin4x),
              
              // Terms and Privacy
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: KSizes.padding2x),
                child: Text(
                  'By signing up, you agree to our Terms of Service and Privacy Policy',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: KColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: KSizes.margin6x),
            ],
          ),
        ),
      ),
    );
  }

  void _signUpWithGoogle(BuildContext context) {
    // Trigger Google Sign-In through the auth cubit
    context.read<AuthCubit>().signInWithGoogle();

    // Close the bottom sheet
    Navigator.of(context).pop();
  }
}

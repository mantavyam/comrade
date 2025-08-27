import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/constants/k_strings.dart';
import '../../core/presentation/main_navigation.dart';
import '../application/auth_cubit.dart';
import '../application/auth_state.dart';
import 'get_started_screen.dart';
import 'name_capture_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateAfterDelay();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: KSizes.animationSlow),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  void _navigateAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _navigateBasedOnAuthState();
      }
    });
  }

  void _navigateBasedOnAuthState() {
    final authState = context.read<AuthCubit>().state;

    if (authState.isAuthenticated) {
      // User is fully authenticated, navigate to main navigation
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainNavigation(),
        ),
      );
    } else if (authState.isPartiallyAuthenticated) {
      // User signed in with Google but needs to complete onboarding
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NameCaptureScreen(),
        ),
      );
    } else {
      // User is not authenticated, navigate to get started screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const GetStartedScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Handle auth state changes during splash
        if (state.isAuthenticated) {
          _navigateBasedOnAuthState();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: KColors.primaryGradient,
            ),
          ),
          child: Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Logo/Icon
                        Container(
                          width: KSizes.iconXXXL * 2,
                          height: KSizes.iconXXXL * 2,
                          decoration: BoxDecoration(
                            color: KColors.textOnPrimary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(KSizes.radiusXL),
                          ),
                          child: const Icon(
                            Icons.shield,
                            size: KSizes.iconXXXL,
                            color: KColors.textOnPrimary,
                          ),
                        ),
                        
                        const SizedBox(height: KSizes.margin8x),
                        
                        // App Name
                        Text(
                          KStrings.appName,
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: KColors.textOnPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        const SizedBox(height: KSizes.margin2x),
                        
                        // App Tagline
                        Text(
                          KStrings.appTagline,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: KColors.textOnPrimary.withValues(alpha: 0.8),
                          ),
                        ),
                        
                        const SizedBox(height: KSizes.margin8x),
                        
                        // Loading Indicator
                        const SizedBox(
                          width: KSizes.iconL,
                          height: KSizes.iconL,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              KColors.textOnPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

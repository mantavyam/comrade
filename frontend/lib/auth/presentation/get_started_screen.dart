import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/constants/k_strings.dart';
import 'login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              KColors.background,
              KColors.backgroundLight,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(KSizes.padding6x),
            child: Column(
              children: [
                // Background Animation/GIF placeholder
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: KColors.backgroundCard,
                      borderRadius: BorderRadius.circular(KSizes.radiusL),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: KSizes.elevationMedium,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(KSizes.radiusL),
                      child: Stack(
                        children: [
                          // Placeholder for military/defense background
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: KColors.primaryGradient,
                              ),
                            ),
                          ),
                          
                          // Overlay with pattern
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.6),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          // Military-themed icon
                          const Center(
                            child: Icon(
                              Icons.military_tech,
                              size: KSizes.iconXXXL * 2,
                              color: KColors.textOnPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: KSizes.margin8x),
                
                // Content Section
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Welcome Title
                      Text(
                        KStrings.welcomeTitle,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: KColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: KSizes.margin4x),
                      
                      // Subtitle
                      Text(
                        KStrings.welcomeSubtitle,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: KColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: KSizes.margin8x),
                      
                      // Get Started Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(KStrings.getStarted),
                        ),
                      ),
                      
                      const SizedBox(height: KSizes.margin6x),
                      
                      // Terms and Conditions
                      GestureDetector(
                        onTap: () => _launchTermsAndConditions(),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: KColors.textTertiary,
                            ),
                            children: [
                              const TextSpan(text: 'By Continuing you agree to '),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(
                                  color: KColors.primary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchTermsAndConditions() async {
    // Placeholder URL - replace with actual terms and conditions URL
    const url = 'https://example.com/terms';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

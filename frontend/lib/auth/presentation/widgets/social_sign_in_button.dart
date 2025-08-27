import 'package:flutter/material.dart';
import '../../../core/constants/k_sizes.dart';
import '../../../core/constants/k_colors.dart';

enum SocialSignInProvider {
  google,
  apple,
  facebook,
}

class SocialSignInButton extends StatelessWidget {
  final SocialSignInProvider provider;
  final VoidCallback onPressed;
  final bool isLoading;
  final String? customText;

  const SocialSignInButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.isLoading = false,
    this.customText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: KSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(),
          foregroundColor: _getForegroundColor(),
          elevation: KSizes.elevationLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KSizes.radiusButton),
            side: BorderSide(
              color: _getBorderColor(),
              width: 1.0,
            ),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: KSizes.iconS,
                width: KSizes.iconS,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(_getForegroundColor()),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getIcon(),
                  SizedBox(width: KSizes.margin3x),
                  Text(
                    customText ?? _getDefaultText(),
                    style: TextStyle(
                      fontSize: KSizes.fontSizeM,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (provider) {
      case SocialSignInProvider.google:
        return Colors.white;
      case SocialSignInProvider.apple:
        return Colors.black;
      case SocialSignInProvider.facebook:
        return const Color(0xFF1877F2);
    }
  }

  Color _getForegroundColor() {
    switch (provider) {
      case SocialSignInProvider.google:
        return Colors.black87;
      case SocialSignInProvider.apple:
        return Colors.white;
      case SocialSignInProvider.facebook:
        return Colors.white;
    }
  }

  Color _getBorderColor() {
    switch (provider) {
      case SocialSignInProvider.google:
        return Colors.grey.shade300;
      case SocialSignInProvider.apple:
        return Colors.black;
      case SocialSignInProvider.facebook:
        return const Color(0xFF1877F2);
    }
  }

  Widget _getIcon() {
    switch (provider) {
      case SocialSignInProvider.google:
        return _GoogleIcon();
      case SocialSignInProvider.apple:
        return Icon(
          Icons.apple,
          size: KSizes.iconM,
          color: Colors.white,
        );
      case SocialSignInProvider.facebook:
        return Icon(
          Icons.facebook,
          size: KSizes.iconM,
          color: Colors.white,
        );
    }
  }

  String _getDefaultText() {
    switch (provider) {
      case SocialSignInProvider.google:
        return 'Continue with Google';
      case SocialSignInProvider.apple:
        return 'Continue with Apple';
      case SocialSignInProvider.facebook:
        return 'Continue with Facebook';
    }
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: KSizes.iconM,
      height: KSizes.iconM,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://developers.google.com/identity/images/g-logo.png',
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

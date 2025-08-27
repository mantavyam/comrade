import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/utils/slide_page_route.dart';
import '../../core/utils/responsive_utils.dart';
import '../application/auth_cubit.dart';
import '../application/auth_state.dart';
import 'phone_number_screen.dart';

class NameCaptureScreen extends StatefulWidget {
  const NameCaptureScreen({super.key});

  @override
  State<NameCaptureScreen> createState() => _NameCaptureScreenState();
}

class _NameCaptureScreenState extends State<NameCaptureScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus the text field when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.responsiveWidth,
            ),
            child: Padding(
              padding: context.responsivePadding,
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

                    // Progress indicator (1 of 3)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildProgressDot(isActive: true),
                        const SizedBox(width: KSizes.margin2x),
                        _buildProgressDot(isActive: false),
                        const SizedBox(width: KSizes.margin2x),
                        _buildProgressDot(isActive: false),
                      ],
                    ),

                    const SizedBox(height: KSizes.margin12x),

                    // Title
                    Text(
                      "What's your name?",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: KSizes.fontSizeHeading,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: KSizes.margin12x),

                    // Name input field with large font
                    TextFormField(
                      controller: _nameController,
                      focusNode: _focusNode,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: KSizes.fontSizeLargeHeading,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your full name',
                        hintStyle: TextStyle(
                          fontSize: KSizes.fontSizeLargeHeading,
                          fontWeight: FontWeight.w300,
                          color: KColors.textSecondary.withValues(alpha: 0.6),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.trim().length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        if (value.trim().length > 50) {
                          return 'Name must be less than 50 characters';
                        }
                        // Check for valid name format (letters, spaces, hyphens, apostrophes)
                        if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(value.trim())) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Trigger rebuild to enable/disable continue button
                        setState(() {});
                      },
                    ),

                    const Spacer(),

                    // Continue button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _canContinue() ? _continue : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: KSizes.padding4x,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(KSizes.radiusButton),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: KSizes.fontSizeL,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: KSizes.margin6x),
                  ],
                ),
              ),
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

  bool _canContinue() {
    return _nameController.text.trim().isNotEmpty &&
           _nameController.text.trim().length >= 2;
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();

      // Update user profile with the name
      context.read<AuthCubit>().updateUserProfile(name: name);

      // Navigate to phone number screen with slide animation
      context.pushSlide(
        PhoneNumberScreen(
          name: name,
        ),
      );
    }
  }
}
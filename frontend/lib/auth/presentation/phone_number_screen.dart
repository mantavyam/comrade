import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/utils/slide_page_route.dart';
import '../application/auth_cubit.dart';
import '../application/auth_state.dart';
import 'otp_verification_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  final String name;
  
  const PhoneNumberScreen({
    super.key,
    required this.name,
  });

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _focusNode = FocusNode();
  String _selectedCountryCode = '+91';
  String _selectedCountryFlag = '🇮🇳';

  // Common country codes for defense aspirants
  final List<Map<String, String>> _countryCodes = [
    {'code': '+91', 'flag': '🇮🇳', 'name': 'India'},
    {'code': '+1', 'flag': '🇺🇸', 'name': 'USA'},
    {'code': '+44', 'flag': '🇬🇧', 'name': 'UK'},
    {'code': '+61', 'flag': '🇦🇺', 'name': 'Australia'},
    {'code': '+971', 'flag': '🇦🇪', 'name': 'UAE'},
  ];

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
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                
                // Progress indicator (2 of 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProgressDot(isActive: true),
                    const SizedBox(width: KSizes.margin2x),
                    _buildProgressDot(isActive: true),
                    const SizedBox(width: KSizes.margin2x),
                    _buildProgressDot(isActive: false),
                  ],
                ),
                
                const SizedBox(height: KSizes.margin12x),
                
                // Title
                Text(
                  "What's your phone number?",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: KSizes.fontSizeHeading,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: KSizes.margin12x),
                
                // Phone number input
                Row(
                  children: [
                    // Country code selector
                    GestureDetector(
                      onTap: _showCountryCodePicker,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: KSizes.padding3x,
                          vertical: KSizes.padding4x,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: KColors.textSecondary.withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(KSizes.radiusM),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _selectedCountryFlag,
                              style: const TextStyle(fontSize: KSizes.fontSizeXL),
                            ),
                            const SizedBox(width: KSizes.margin1x),
                            Text(
                              _selectedCountryCode,
                              style: TextStyle(
                                fontSize: KSizes.fontSizeL,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: KSizes.margin1x),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: KSizes.iconM,
                              color: KColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: KSizes.margin3x),
                    
                    // Phone number input
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        style: TextStyle(
                          fontSize: KSizes.fontSizeLargeHeading,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(KSizes.radiusM),
                            borderSide: BorderSide(
                              color: KColors.textSecondary.withValues(alpha: 0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(KSizes.radiusM),
                            borderSide: BorderSide(
                              color: KColors.primary,
                              width: 2,
                            ),
                          ),
                          hintText: '9876543210',
                          hintStyle: TextStyle(
                            fontSize: KSizes.fontSizeLargeHeading,
                            fontWeight: FontWeight.w300,
                            color: KColors.textSecondary.withValues(alpha: 0.6),
                            letterSpacing: 2,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: KSizes.padding4x,
                            vertical: KSizes.padding4x,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (_selectedCountryCode == '+91' && value.length != 10) {
                            return 'Please enter a valid 10-digit phone number';
                          }
                          if (value.length < 7) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          // Trigger rebuild to enable/disable continue button
                          setState(() {});
                        },
                      ),
                    ),
                  ],
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
    if (_phoneController.text.isEmpty) return false;
    
    if (_selectedCountryCode == '+91') {
      return _phoneController.text.length == 10;
    }
    
    return _phoneController.text.length >= 7;
  }

  void _continue() {
    if (_formKey.currentState!.validate()) {
      final fullPhoneNumber = '$_selectedCountryCode${_phoneController.text}';

      // Start phone verification through auth cubit
      context.read<AuthCubit>().signInWithPhoneNumber(phoneNumber: fullPhoneNumber);

      // Navigate to OTP verification screen with slide animation
      context.pushSlide(
        OtpVerificationScreen(
          name: widget.name,
          phoneNumber: fullPhoneNumber,
        ),
      );
    }
  }

  void _showCountryCodePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(KSizes.padding4x),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Country',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: KSizes.margin4x),
            ..._countryCodes.map((country) => ListTile(
              leading: Text(
                country['flag']!,
                style: const TextStyle(fontSize: KSizes.fontSizeXL),
              ),
              title: Text(country['name']!),
              trailing: Text(
                country['code']!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                setState(() {
                  _selectedCountryCode = country['code']!;
                  _selectedCountryFlag = country['flag']!;
                });
                Navigator.of(context).pop();
              },
            )),
          ],
        ),
      ),
    );
  }
}

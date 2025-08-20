import 'package:flutter/material.dart';
import '../../core/constants/k_colors.dart';
import '../../core/constants/k_sizes.dart';
import '../../core/constants/k_strings.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.padding6x),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: KSizes.margin4x),
                
                // Title
                Text(
                  KStrings.findYourAccount,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: KSizes.margin2x),
                
                // Subtitle
                Text(
                  KStrings.findAccountSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: KColors.textSecondary,
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
                    hintText: 'Enter your email address',
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
                
                const SizedBox(height: KSizes.margin8x),
                
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _sendResetEmail,
                    child: const Text(KStrings.submit),
                  ),
                ),
                
                const SizedBox(height: KSizes.margin6x),
                
                // Info Card
                Container(
                  padding: const EdgeInsets.all(KSizes.padding4x),
                  decoration: BoxDecoration(
                    color: KColors.backgroundCard,
                    borderRadius: BorderRadius.circular(KSizes.radiusM),
                    border: Border.all(
                      color: KColors.border,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: KColors.info,
                        size: KSizes.iconM,
                      ),
                      const SizedBox(width: KSizes.margin3x),
                      Expanded(
                        child: Text(
                          'We\'ll send you a link to reset your password. Check your email after submitting.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: KColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Back to Login
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Back to Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendResetEmail() {
    if (_formKey.currentState!.validate()) {
      // For now, show a dialog that this will be implemented
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Reset Email Sent'),
          content: Text(
            'Password reset functionality will be implemented in the next phase.\n\nEmail: ${_emailController.text}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to login
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

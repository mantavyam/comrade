import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/constants/k_sizes.dart';
import '../../../core/constants/k_colors.dart';

class OtpInputWidget extends StatefulWidget {
  final Function(String) onCompleted;
  final Function(String)? onChanged;
  final String? errorText;
  final bool hasError;
  final int length;
  final bool autoFocus;

  const OtpInputWidget({
    super.key,
    required this.onCompleted,
    this.onChanged,
    this.errorText,
    this.hasError = false,
    this.length = 6,
    this.autoFocus = true,
  });

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget>
    with TickerProviderStateMixin {
  late TextEditingController _controller;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    
    // Initialize shake animation for errors
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void didUpdateWidget(OtpInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Trigger shake animation when error occurs
    if (widget.hasError && !oldWidget.hasError) {
      _shakeController.forward().then((_) {
        _shakeController.reverse();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_shakeAnimation.value, 0),
              child: child,
            );
          },
          child: PinCodeTextField(
            appContext: context,
            length: widget.length,
            controller: _controller,
            autoFocus: widget.autoFocus,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            animationType: AnimationType.fade,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            hapticFeedbackTypes: HapticFeedbackTypes.light,
            onCompleted: (value) {
              HapticFeedback.lightImpact();
              widget.onCompleted(value);
            },
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(KSizes.radiusButton),
              fieldHeight: KSizes.buttonHeight,
              fieldWidth: KSizes.buttonHeight,
              borderWidth: 2.0,
              activeFillColor: widget.hasError 
                  ? Colors.red.shade50 
                  : Colors.blue.shade50,
              inactiveFillColor: Colors.grey.shade100,
              selectedFillColor: Colors.blue.shade100,
              activeColor: widget.hasError 
                  ? Colors.red 
                  : Colors.blue,
              inactiveColor: Colors.grey.shade300,
              selectedColor: Colors.blue,
            ),
            textStyle: TextStyle(
              fontSize: KSizes.fontSizeXL,
              fontWeight: FontWeight.w600,
              color: widget.hasError ? Colors.red : Colors.black87,
            ),
            backgroundColor: Colors.transparent,
            cursorColor: Colors.blue,
          ),
        ),
        
        if (widget.errorText != null) ...[
          SizedBox(height: KSizes.margin2x),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: KSizes.padding4x,
              vertical: KSizes.padding2x,
            ),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(KSizes.radiusButton),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: KSizes.iconS,
                ),
                SizedBox(width: KSizes.margin2x),
                Flexible(
                  child: Text(
                    widget.errorText!,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: KSizes.fontSizeS,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class OtpResendButton extends StatefulWidget {
  final VoidCallback onPressed;
  final int resendTimeoutSeconds;

  const OtpResendButton({
    super.key,
    required this.onPressed,
    this.resendTimeoutSeconds = 30,
  });

  @override
  State<OtpResendButton> createState() => _OtpResendButtonState();
}

class _OtpResendButtonState extends State<OtpResendButton>
    with TickerProviderStateMixin {
  late AnimationController _timerController;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      duration: Duration(seconds: widget.resendTimeoutSeconds),
      vsync: this,
    );
    
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _canResend = false;
    });
    
    _timerController.forward().then((_) {
      setState(() {
        _canResend = true;
      });
    });
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _timerController,
      builder: (context, child) {
        final remainingSeconds = (widget.resendTimeoutSeconds * 
            (1 - _timerController.value)).ceil();
        
        return TextButton(
          onPressed: _canResend ? () {
            widget.onPressed();
            _timerController.reset();
            _startTimer();
          } : null,
          child: Text(
            _canResend 
                ? 'Resend Code'
                : 'Resend in ${remainingSeconds}s',
            style: TextStyle(
              fontSize: KSizes.fontSizeM,
              fontWeight: FontWeight.w500,
              color: _canResend ? Colors.blue : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}

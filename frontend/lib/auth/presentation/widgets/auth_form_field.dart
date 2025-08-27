import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/k_sizes.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double height;
  final IconData? icon;

  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height = KSizes.buttonHeight,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.blue,
          foregroundColor: foregroundColor ?? Colors.white,
          elevation: KSizes.elevationLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KSizes.radiusButton),
          ),
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade600,
        ),
        child: isLoading
            ? SizedBox(
                height: KSizes.iconS,
                width: KSizes.iconS,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    foregroundColor ?? Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: KSizes.iconS),
                    SizedBox(width: KSizes.margin2x),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: KSizes.fontSizeM,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class AuthFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool enabled;
  final bool autofocus;
  final int? maxLength;
  final int maxLines;

  const AuthFormField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.autofocus = false,
    this.maxLength,
    this.maxLines = 1,
  });

  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField>
    with TickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _animationController;
  late Animation<double> _labelAnimation;
  late Animation<Color?> _borderColorAnimation;
  
  bool _isFocused = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _hasText = widget.controller.text.isNotEmpty;
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _labelAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _borderColorAnimation = ColorTween(
      begin: Colors.grey.shade300,
      end: Colors.blue,
    ).animate(_animationController);
    
    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);
    
    if (_hasText || widget.autofocus) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    widget.controller.removeListener(_onTextChange);
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    
    if (_isFocused || _hasText) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _onTextChange() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
      
      if (_hasText || _isFocused) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              height: KSizes.inputHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(KSizes.radiusButton),
                border: Border.all(
                  color: widget.errorText != null
                      ? Colors.red
                      : _borderColorAnimation.value ?? Colors.grey.shade300,
                  width: _isFocused ? 2.0 : 1.0,
                ),
                color: widget.enabled ? Colors.white : Colors.grey.shade100,
              ),
              child: Stack(
                children: [
                  // Animated label
                  Positioned(
                    left: KSizes.padding3x,
                    top: _labelAnimation.value * 8 + (1 - _labelAnimation.value) * 16,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: _labelAnimation.value * KSizes.fontSizeS + 
                                 (1 - _labelAnimation.value) * KSizes.fontSizeM,
                        color: widget.errorText != null
                            ? Colors.red
                            : _isFocused
                                ? Colors.blue
                                : Colors.grey.shade600,
                        fontWeight: _isFocused ? FontWeight.w500 : FontWeight.normal,
                      ),
                      child: Text(widget.label),
                    ),
                  ),
                  
                  // Text field
                  Positioned.fill(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      enabled: widget.enabled,
                      autofocus: widget.autofocus,
                      obscureText: widget.obscureText,
                      keyboardType: widget.keyboardType,
                      inputFormatters: widget.inputFormatters,
                      maxLength: widget.maxLength,
                      maxLines: widget.maxLines,
                      onChanged: widget.onChanged,
                      onSubmitted: widget.onSubmitted,
                      style: TextStyle(
                        fontSize: KSizes.fontSizeM,
                        color: widget.enabled ? Colors.black87 : Colors.grey,
                      ),
                      decoration: InputDecoration(
                        hintText: _isFocused || _hasText ? widget.hintText : null,
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: KSizes.fontSizeM,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: KSizes.padding3x,
                          right: KSizes.padding3x,
                          top: KSizes.padding4x + 4,
                          bottom: KSizes.padding2x,
                        ),
                        prefixIcon: widget.prefixIcon,
                        suffixIcon: widget.suffixIcon != null
                            ? IconButton(
                                onPressed: widget.onSuffixIconPressed,
                                icon: widget.suffixIcon!,
                              )
                            : null,
                        counterText: '', // Hide character counter
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        
        // Error text
        if (widget.errorText != null) ...[
          SizedBox(height: KSizes.margin1x),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: KSizes.padding3x),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: KSizes.iconS,
                ),
                SizedBox(width: KSizes.margin1x),
                Expanded(
                  child: Text(
                    widget.errorText!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: KSizes.fontSizeS,
                    ),
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

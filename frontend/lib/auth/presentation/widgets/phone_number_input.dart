import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/k_sizes.dart';
import '../../../core/constants/k_colors.dart';

class PhoneNumberInput extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final VoidCallback? onChanged;
  final bool enabled;
  final String hintText;

  const PhoneNumberInput({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.enabled = true,
    this.hintText = 'Enter your phone number',
  });

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  String _selectedCountryCode = '+1';
  final Map<String, String> _countryCodes = {
    '+1': '🇺🇸 US',
    '+44': '🇬🇧 UK',
    '+91': '🇮🇳 IN',
    '+86': '🇨🇳 CN',
    '+49': '🇩🇪 DE',
    '+33': '🇫🇷 FR',
    '+81': '🇯🇵 JP',
    '+82': '🇰🇷 KR',
    '+61': '🇦🇺 AU',
    '+55': '🇧🇷 BR',
  };

  @override
  void initState() {
    super.initState();
    // Initialize with country code if controller has text
    if (widget.controller.text.isNotEmpty) {
      _extractCountryCode();
    }
  }

  void _extractCountryCode() {
    final text = widget.controller.text;
    for (final code in _countryCodes.keys) {
      if (text.startsWith(code)) {
        setState(() {
          _selectedCountryCode = code;
        });
        break;
      }
    }
  }

  void _updatePhoneNumber() {
    final currentText = widget.controller.text;
    final numbersOnly = currentText.replaceAll(RegExp(r'[^\d]'), '');
    
    if (numbersOnly.isNotEmpty) {
      widget.controller.text = '$_selectedCountryCode$numbersOnly';
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length),
      );
    } else {
      widget.controller.text = _selectedCountryCode;
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length),
      );
    }
    
    if (widget.onChanged != null) {
      widget.onChanged!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: KSizes.inputHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(KSizes.radiusButton),
            border: Border.all(
              color: widget.errorText != null 
                  ? Colors.red 
                  : Colors.grey.shade300,
              width: 1.0,
            ),
            color: widget.enabled ? Colors.white : Colors.grey.shade100,
          ),
          child: Row(
            children: [
              // Country code dropdown
              Container(
                padding: EdgeInsets.symmetric(horizontal: KSizes.padding3x),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCountryCode,
                    isDense: true,
                    onChanged: widget.enabled ? (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedCountryCode = newValue;
                        });
                        _updatePhoneNumber();
                      }
                    } : null,
                    items: _countryCodes.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(
                          '${entry.value} ${entry.key}',
                          style: TextStyle(
                            fontSize: KSizes.fontSizeM,
                            color: widget.enabled ? Colors.black87 : Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              
              // Divider
              Container(
                height: KSizes.iconM,
                width: 1,
                color: Colors.grey.shade300,
              ),
              
              // Phone number input
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  enabled: widget.enabled,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s\-\(\)]')),
                    LengthLimitingTextInputFormatter(20),
                  ],
                  onChanged: (_) {
                    if (widget.onChanged != null) {
                      widget.onChanged!();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: KSizes.fontSizeM,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: KSizes.padding3x,
                      vertical: KSizes.padding4x,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: KSizes.fontSizeM,
                    color: widget.enabled ? Colors.black87 : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Error text
        if (widget.errorText != null) ...[
          SizedBox(height: KSizes.margin1x),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: KSizes.padding3x),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: KSizes.fontSizeS,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hint; 
  final TextEditingController txtController;
  final double cornerRadius;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final bool obscureText;

  const CustomTextfield({
    super.key,
    required this.hint,
    required this.txtController,
    required this.cornerRadius,
    this.keyboardType,
    this.fillColor,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: txtController,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autocorrect: !obscureText,
      enableSuggestions: !obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: fillColor ?? const Color(0xFFF5F5F5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: const BorderSide(
            color: Color(0xFF07C160),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

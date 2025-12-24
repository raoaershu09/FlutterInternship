import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool isPasswordField;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool isEnabled;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusColor;
  final double borderRadius;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.isPasswordField = false,
    this.keyboardType,
    this.maxLines = 1,
    this.isEnabled = true,
    this.fillColor,
    this.borderColor,
    this.focusColor,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final bool showSuffix = isPasswordField || suffixIcon != null;
    final bool showObscureToggle = isPasswordField && obscure;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure && isPasswordField,
        enabled: isEnabled,
        keyboardType: keyboardType,
        maxLines: maxLines,
        cursorColor: focusColor ?? Theme.of(context).primaryColor,
        style: TextStyle(
          fontSize: 16,
          color: isEnabled ? Colors.black87 : Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 15,
          ),
          filled: true,
          fillColor: fillColor ?? Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: maxLines == 1 ? 18 : 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor ?? Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: focusColor ?? Theme.of(context).primaryColor,
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 1.5,
            ),
          ),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: Icon(
                    prefixIcon,
                    size: 22,
                    color: Colors.grey.shade600,
                  ),
                )
              : null,
          suffixIcon: showSuffix
              ? Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: onSuffixTap,
                    child: Icon(
                      showObscureToggle
                          ? (obscure ? Icons.visibility : Icons.visibility_off)
                          : suffixIcon,
                      size: 22,
                      color: Colors.grey.shade600,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
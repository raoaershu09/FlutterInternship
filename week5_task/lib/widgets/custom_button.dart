import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? prefixIcon;
  final double height;
  final double borderRadius;
  final bool hasShadow;
  final bool isDisabled;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.prefixIcon,
    this.height = 56,
    this.borderRadius = 16,
    this.hasShadow = true,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabledState = isDisabled || isLoading;
    
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow && !isDisabledState
            ? [
                BoxShadow(
                  color: (backgroundColor ?? Colors.blueAccent).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isDisabledState ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabledState
              ? Colors.grey.shade300
              : backgroundColor ?? Colors.blueAccent,
          foregroundColor: isDisabledState
              ? Colors.grey.shade600
              : textColor ?? Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    Icon(
                      prefixIcon,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
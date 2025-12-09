import 'package:flutter/material.dart';
import '../colors.dart';

class TTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final int? maxLines;
  final int? minLines;
  final VoidCallback? onTap;

  const TTextField({
    Key? key,
    this.controller,
    required this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.minLines,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final fillColor = isDark ? AppColors.darkFillColor : AppColors.lightFillColor;
    final borderColor = isDark ? AppColors.darkBorderColor : AppColors.lightBorderColor;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final labelColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      maxLines: obscureText ? 1 : maxLines,
      minLines: obscureText ? 1 : minLines,
      onTap: onTap,
      readOnly: onTap != null,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        // labelText: label,
        hintText: label,
        hintStyle: TextStyle(color: labelColor),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDark ? AppColors.darkBorderColor : AppColors.primaryBlue,
          ),          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

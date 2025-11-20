import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final int? maxLines;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    required this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.maxLines = 1,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textSecondary),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: AppColors.primary)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

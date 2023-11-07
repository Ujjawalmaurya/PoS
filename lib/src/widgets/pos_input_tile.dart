import 'package:flutter/material.dart';

class PoSInputField extends StatelessWidget {
  final int flex;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final String label;
  final String? hint;
  final String? initialValue;
  final String? prefixText;
  final String? suffixText;
  final String? helperText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool numbersOnly;
  TextEditingController? controller;
  final TextCapitalization textCapitalization;
  void Function()? onTap;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  bool obscureText;
  bool readOnly;

  PoSInputField({
    super.key,
    required this.label,
    required this.hint,
    this.initialValue,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.helperText,
    this.maxLength,
    this.numbersOnly = false,
    this.prefixText,
    this.suffixText,
    this.flex = 1,
    this.textCapitalization = TextCapitalization.words,
    this.onTap,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
        child: TextFormField(
          scrollPhysics: const BouncingScrollPhysics(),
          readOnly: readOnly,
          controller: controller,
          maxLength: maxLength,
          onTap: onTap,

          textCapitalization: textCapitalization,
          // inputFormatters: [
          // FilteringTextInputFormatter.digitsOnly,
          // FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          // WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
          // FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
          // ],
          keyboardType: numbersOnly ? TextInputType.phone : TextInputType.text,
          initialValue: initialValue,
          obscureText: obscureText,
          onChanged: onChanged,
          maxLines: maxLines,
          minLines: minLines,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            // isCollapsed: true,
            // counter: const SizedBox.shrink(),
            helperText: helperText,
            helperMaxLines: 2,
            isDense: true,
            contentPadding: const EdgeInsets.all(12),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            prefixText: prefixText,
            suffixText: suffixText,
            labelText: label,
            hintText: hint,
          ),
        ),
      ),
    );
  }
}

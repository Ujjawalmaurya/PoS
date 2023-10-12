import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    this.hint = 'search',
    this.onChanged,
    super.key,
  });

  final String hint;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          // border: InputBorder.none,
          hintText: hint,
          isDense: true,
        ),
      ),
    );
  }
}

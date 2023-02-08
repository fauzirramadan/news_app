import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  const CustomField(
      {super.key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.onEditingComplete});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: hintText ?? "Search News",
        ),
        onEditingComplete: onEditingComplete,
        onChanged: onChanged);
  }
}

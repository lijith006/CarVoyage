import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String? hintText;
  String? labelText;
  TextEditingController? controller;
  TextInputType? keyboardType;
  bool enabled;
  TextStyle? textStyle;
  final FormFieldValidator<String>? validator;
  bool readOnly;
  String? initialValue;
  final VoidCallback? onTap;
  //final inputFormatters;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  CustomTextField(
      {super.key,
      required this.hintText,
      required this.labelText,
      this.controller,
      this.keyboardType,
      this.textStyle,
      this.enabled = true,
      this.validator,
      this.readOnly = false,
      this.initialValue,
      this.inputFormatters,
      this.onChanged,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      onTap: onTap,
      initialValue: initialValue,
      readOnly: readOnly,
      enabled: enabled,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
      ),
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }
}

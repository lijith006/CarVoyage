import 'package:flutter/material.dart';

Widget customDropdownField({
  required String labelText,
  required String hintText,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
  final FormFieldValidator<String>? validator,
}) {
  return DropdownButtonFormField<String>(
      style: TextStyle(color: Colors.white),
      dropdownColor: Color(0xFF1E1E1E),
      iconEnabledColor: Colors.white,
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      hint: Text(
        hintText,
        style: const TextStyle(color: Colors.white),
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white)),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator);
}
// (value) {
//       // if (value == null || value.isEmpty) {
//       //   return 'Value is empty';
//       // } else {
//       //   return null;
//       // }
//     },

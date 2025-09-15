import 'package:flutter/material.dart';

class DateTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  const DateTextField({
    super.key,
    required this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    const enabledBorder = OutlineInputBorder();
    const focusedBorder = OutlineInputBorder();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          hintText: hintText ?? 'Nhập dữ liệu',
        ),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            controller.text = "${picked.day}/${picked.month}/${picked.year}";
          }
        },
      ),
    );
  }
}

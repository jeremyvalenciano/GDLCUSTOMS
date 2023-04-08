import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final Icon icon;
  final int maxLength;

  const InputTextField(
      {Key? key,
      required this.controller,
      required this.keyboardType,
      required this.labelText,
      required this.hintText,
      required this.icon,
      required this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: icon,
      ),
      controller: controller,
      maxLength: maxLength,
      obscureText: keyboardType == TextInputType.visiblePassword ? true : false,
      onTap: () => labelText == 'Fecha de nacimiento'
          ? showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100))
              .then((value) {
              final formattedDate = DateFormat('dd/MM/yyyy').format(value!);
              controller.text = formattedDate;
            })
          : null,
    );
  }
}

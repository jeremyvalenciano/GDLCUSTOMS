import 'package:flutter/material.dart';
import 'package:proyectobd/components/label_text.dart';
import 'package:proyectobd/components/simple_text.dart';
import 'package:proyectobd/components/rounded_button.dart';
import 'package:proyectobd/employee_class.dart';

class EmployeeProfile extends StatefulWidget {
  final Employee employee;
  const EmployeeProfile({required this.employee, super.key});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  @override
  Widget build(BuildContext context, {String? rfc}) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text('PERFIL DE EMPLEADO',
            style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.black,
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelText(text: "RFC:"),
            SimpleText(text: widget.employee.rfc),
            const LabelText(text: "Rol:"),
            SimpleText(text: widget.employee.role),
            const LabelText(text: "Correo:"),
            SimpleText(text: widget.employee.email),
            const LabelText(text: "Telefono:"),
            SimpleText(text: widget.employee.cellphone),
            const LabelText(text: "Direccion:"),
            SimpleText(text: widget.employee.address),
            const LabelText(text: "Fecha de nacimiento:"),
            SimpleText(text: widget.employee.birthday),
            const LabelText(text: "Genero"),
            SimpleText(text: widget.employee.genre),
            RoundedButton(
              text: "Eliminar",
              textColor: Colors.white,
              btnColor: Colors.red,
              fontSize: 18,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

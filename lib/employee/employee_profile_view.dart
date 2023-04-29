import 'package:flutter/material.dart';
import 'package:proyectobd/components/label_text.dart';
import 'package:proyectobd/components/simple_text.dart';
import 'package:proyectobd/components/rounded_button.dart';
import 'package:proyectobd/classes/employee_class.dart';
import 'package:proyectobd/database.dart';

final dbHelper = DatabaseHelper.instance;

class EmployeeProfileView extends StatefulWidget {
  final Employee employee;
  const EmployeeProfileView({required this.employee, super.key});

  @override
  State<EmployeeProfileView> createState() => _EmployeeProfileViewState();
}

class _EmployeeProfileViewState extends State<EmployeeProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text('PERFIL EMPLEADO',
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding:
              const EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.white,
                thickness: 0.3,
                indent: 50,
                endIndent: 50,
              ),
              const LabelText(text: "NOMBRE"),
              SimpleText(text: widget.employee.name),
              const LabelText(text: "CORREO"),
              SimpleText(text: widget.employee.email),
              const LabelText(text: "TELEFONO"),
              SimpleText(text: widget.employee.cellphone),
              const LabelText(text: "CIUDAD"),
              SimpleText(text: widget.employee.city),
              const LabelText(text: "DIRECCION"),
              SimpleText(text: widget.employee.address),
              const LabelText(text: "FECHA DE NACIMIENTO"),
              SimpleText(text: widget.employee.birthday),
              const LabelText(text: "EDAD"),
              SimpleText(text: widget.employee.age.toString()),
              const LabelText(text: "GENERO"),
              SimpleText(text: widget.employee.genre),
              const LabelText(text: "RFC"),
              SimpleText(text: widget.employee.rfc),
              const LabelText(text: "ROL"),
              SimpleText(text: widget.employee.role),
              const LabelText(text: "REGIMEN FISCAL"),
              SimpleText(text: widget.employee.fiscalRegime),
              const SizedBox(height: 50),
              Center(
                child: RoundedButton(
                  text: "Editar",
                  textColor: Colors.white,
                  btnColor: Colors.blue,
                  fontSize: 18,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:proyectobd/home_page.dart';
import 'login_screen_employee.dart';
import '../classes/employee_class.dart';
import 'package:sqflite/sqflite.dart';

//Components
import 'package:proyectobd/components/input_text_field.dart';
import 'package:proyectobd/components/rounded_button.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final rfcController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cellphoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final dateController = TextEditingController();
  final ageController = TextEditingController();
  final roleController = TextEditingController();
  final fiscalRegimeController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Empleado'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Empezar',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Rellena los siguientes campos',
                    style: TextStyle(fontSize: 17)),
              ),
              const SizedBox(height: 20.0),
              InputTextField(
                controller: rfcController,
                labelText: 'RFC',
                hintText: 'Ingrese su RFC',
                icon: const Icon(Icons.recent_actors),
                maxLength: 13,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: nameController,
                labelText: 'Nombre',
                hintText: 'Ingrese su nombre',
                icon: const Icon(Icons.person),
                maxLength: 40,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: emailController,
                labelText: 'Correo',
                hintText: 'Ingrese su correo',
                icon: const Icon(Icons.email),
                maxLength: 30,
                keyboardType: TextInputType.emailAddress,
              ),
              InputTextField(
                controller: passwordController,
                labelText: 'Contraseña',
                hintText: 'Ingrese su contraseña',
                icon: const Icon(Icons.lock),
                maxLength: 30,
                keyboardType: TextInputType.visiblePassword,
              ),
              InputTextField(
                controller: cellphoneController,
                labelText: 'Celular',
                hintText: 'Ingrese su celular',
                icon: const Icon(Icons.phone),
                maxLength: 10,
                keyboardType: TextInputType.phone,
              ),
              InputTextField(
                controller: fiscalRegimeController,
                labelText: 'Regimen Fiscal',
                hintText: 'Ingrese su regimen fiscal',
                icon: const Icon(Icons.attach_money_rounded),
                maxLength: 30,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: roleController,
                labelText: 'Rol',
                hintText: 'Ingrese su rol en la empresa',
                icon: const Icon(Icons.work),
                maxLength: 30,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: cityController,
                labelText: 'Estado de Nacimiento',
                hintText: 'Ingrese su estado',
                icon: const Icon(Icons.location_city),
                maxLength: 30,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: addressController,
                labelText: 'Direccion',
                hintText: 'Ingrese su direccion',
                icon: const Icon(Icons.location_on),
                maxLength: 30,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: ageController,
                labelText: 'Edad',
                hintText: 'Ingrese su edad',
                icon: const Icon(Icons.numbers),
                maxLength: 2,
                keyboardType: TextInputType.number,
              ),
              InputTextField(
                controller: dateController,
                labelText: 'Fecha de nacimiento',
                hintText: 'Ingrese su fecha de nacimiento',
                icon: const Icon(Icons.calendar_today),
                maxLength: 30,
                keyboardType: TextInputType.text,
              ),
              const Text('Seleccione su genero:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Column(children: [
                RadioListTile(
                  title: const Text('Masculino'),
                  value: 'Masculino',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                      _genderController.text = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Femenino'),
                  value: 'Femenino',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                      _genderController.text = value.toString();
                    });
                  },
                ),
              ]),
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 60),
                child: Center(
                  child: RoundedButton(
                    text: 'Registrar',
                    btnColor: Colors.blue,
                    fontSize: 15,
                    textColor: Colors.white,
                    onPressed: () async {
                      if (rfcController.text.isEmpty ||
                          nameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          cellphoneController.text.isEmpty ||
                          fiscalRegimeController.text.isEmpty ||
                          roleController.text.isEmpty ||
                          cityController.text.isEmpty ||
                          addressController.text.isEmpty ||
                          ageController.text.isEmpty ||
                          dateController.text.isEmpty ||
                          _genderController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, llene todos los campos'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        try {
                          int result = await dbHelper.insertEmployee(Employee(
                            rfc: rfcController.text,
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            cellphone: cellphoneController.text,
                            birthday: dateController.text,
                            address: addressController.text,
                            genre: _genderController.text,
                            city: cityController.text,
                            age: int.parse(ageController.text),
                            role: roleController.text,
                            fiscalRegime: fiscalRegimeController.text,
                          ));
                          if (result > 0 && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registro Exitoso!'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const HomePage();
                                },
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registro fallido!'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        } catch (e) {
                          if (e is DatabaseException) {
                            String errorMessage = e.toString();
                            if (errorMessage.contains("rfc already exists")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('RFC ya registrado!'),
                                  backgroundColor: Colors.orange,
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            } else if (errorMessage
                                .contains("Employee email already exists")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Correo ya registrado!'),
                                  backgroundColor: Colors.orange,
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            } else {
                              // Manejar cualquier otro tipo de error aquí
                            }
                          }
                        }
                      }
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Tienes cuenta?',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const LoginScreenEmployee();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

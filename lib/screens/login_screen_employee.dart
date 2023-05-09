import 'package:flutter/material.dart';
import 'package:proyectobd/components/rounded_button.dart';
import 'package:proyectobd/employee/home_page_employee.dart';
import '../select_user.dart';
import '../database.dart';

final dbHelper = DatabaseHelper.instance;

final emailController = TextEditingController();
final passwordController = TextEditingController();
//Validacion de email y de contraseña
Future submitLoginFormEmployee() async {
  // Get the email and password from the form fields
  final String email = emailController.text;
  final String password = passwordController.text;

  // Call the login method to check if the credentials are valid
  final bool isLoggedIn = await dbHelper.loginEmployee(email, password);

  // If the credentials are valid, navigate to the next screen; otherwise,
  // show an error message
  if (isLoggedIn) {
    debugPrint('Login successful');
    return true;
  } else {
    debugPrint('Login failed');
    return false;
  }
}

class LoginScreenEmployee extends StatefulWidget {
  const LoginScreenEmployee({Key? key}) : super(key: key);

  @override
  State<LoginScreenEmployee> createState() => _LoginScreenEmployeeState();
}

class _LoginScreenEmployeeState extends State<LoginScreenEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login de empleado'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: const Text('Bienvenido de nuevo a \n       GDL CUSTOMS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const Text('Rellena los siguientes campos',
                style: TextStyle(fontSize: 18)),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Correo electrónico:',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Contraseña',
                ),
                obscureText: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 25),
              child: RoundedButton(
                  text: "Iniciar sesion",
                  textColor: Colors.white,
                  btnColor: Colors.blue,
                  fontSize: 20,
                  onPressed: () async {
                    final bool isLoggedIn = await submitLoginFormEmployee();
                    if (isLoggedIn) {
                      if (mounted) {
                        setState(() async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login Exitoso!'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 4),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          //Obtenemos el cliente por email
                          final employee = await dbHelper
                              .getEmployeeByEmail(emailController.text);
                          if (mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return HomePageEmployee(employee: employee);
                                },
                              ),
                            );
                          }
                        });
                      }
                    } else {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Usuario o contraseña incorrectos'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 4),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      });
                    }
                  }),
            ),
            const Center(
              child: Text(
                'No tienes cuenta?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const SelectUser();
                      },
                    ),
                  );
                },
                child: const Text('Crea una cuenta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

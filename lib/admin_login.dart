import 'package:flutter/material.dart';
import 'package:proyectobd/select_admin_info.dart';
import 'database.dart';

final dbHelper = DatabaseHelper.instance;
bool isLoggedAdmin = false;

final emailController = TextEditingController();
final passwordController = TextEditingController();
//Validacion de email y de contraseña
void submitLoginFormAdmin() async {
  // Get the email and password from the form fields
  final String email = emailController.text;
  final String password = passwordController.text;

  // Call the login method to check if the credentials are valid
  final bool isLoggedIn = await dbHelper.loginAdmin(email, password);

  // If the credentials are valid, navigate to the next screen; otherwise,
  // show an error message
  if (isLoggedIn) {
    debugPrint('Login successful');
    isLoggedAdmin = true;
  } else {
    debugPrint('Login failed');
    isLoggedAdmin = false;
  }
}

//notification

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginScreen Admin'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 20),
              child: const Text('Bienvenido de nuevo a \n         GDL Customs',
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
              padding: const EdgeInsets.only(top: 20, bottom: 40),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: const BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  ),
                ),
                onPressed: () async {
                  submitLoginFormAdmin();
                  if (isLoggedAdmin) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectAdminInfo()),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content:
                              const Text('Usuario o contraseña incorrectos'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Iniciar Sesión',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

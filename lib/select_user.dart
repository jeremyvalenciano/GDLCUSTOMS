import 'package:flutter/material.dart';
import 'package:proyectobd/admin_login.dart';
import 'client_screen.dart';
import 'employee_screen.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({super.key});

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  bool isEmployee = false;
  bool isClient = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Text(
                'GDL CUSTOMS',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 50),
              child: const Text(
                'Selecciona tu tipo de usuario',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isClient = true;
                      isEmployee = false;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: isClient
                        ? MaterialStateProperty.all<Color>(Colors.blue)
                        : MaterialStateProperty.all<Color>(Colors.grey),
                    shape: isClient
                        ? MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Colors.blue, width: 2),
                            ),
                          )
                        : MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Colors.grey, width: 2),
                            ),
                          ),
                  ),
                  child: const Text('Cliente', style: TextStyle(fontSize: 22)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isClient = false;
                      isEmployee = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: isEmployee
                        ? MaterialStateProperty.all<Color>(Colors.blue)
                        : MaterialStateProperty.all<Color>(Colors.grey),
                    shape: isEmployee
                        ? MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Colors.blue, width: 2),
                            ),
                          )
                        : MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Colors.grey, width: 2),
                            ),
                          ),
                  ),
                  child: const Text('Empleado', style: TextStyle(fontSize: 22)),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 50),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        //Modificar Login de Admin
                        return const AdminLogin();
                      },
                    ),
                  );
                },
                child: const Text('Soy Administrador',
                    style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                    )),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      if (isClient) {
                        return const ClientScreen();
                      }
                      return const EmployeeScreen();
                    },
                  ),
                );
              },
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}

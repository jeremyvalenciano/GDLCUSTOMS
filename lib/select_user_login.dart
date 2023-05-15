import 'package:flutter/material.dart';
import 'package:proyectobd/admin/admin_login.dart';
import 'package:proyectobd/screens/login_screen_client.dart';
import 'package:proyectobd/screens/login_screen_employee.dart';

class SelectUserLogin extends StatefulWidget {
  const SelectUserLogin({super.key});

  @override
  State<SelectUserLogin> createState() => _SelectUserLoginState();
}

class _SelectUserLoginState extends State<SelectUserLogin> {
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
                Column(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isClient = true;
                          isEmployee = false;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              //Modificar Login de Admin
                              return const LoginScreenClient();
                            },
                          ),
                        );
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
                      child:
                          const Text('Cliente', style: TextStyle(fontSize: 22)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://static.vecteezy.com/system/resources/previews/006/877/514/original/work-character-solid-icon-illustration-office-workers-teachers-judges-police-artists-employees-free-vector.jpg'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isClient = false;
                          isEmployee = true;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              //Modificar Login de Admin
                              return const LoginScreenEmployee();
                            },
                          ),
                        );
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
                      child: const Text('Empleado',
                          style: TextStyle(fontSize: 22)),
                    ),
                  ],
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
          ],
        ),
      ),
    );
  }
}

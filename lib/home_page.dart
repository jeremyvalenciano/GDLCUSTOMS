import 'package:flutter/material.dart';
import 'package:proyectobd/client_screen.dart';
import 'package:proyectobd/employee_screen.dart';
import 'login_screen.dart';
//import 'select_user.dart';
import 'database.dart';

import 'client/home_page_client.dart';
import 'admin/home_page_admin.dart';

final dbHelper = DatabaseHelper.instance;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 180.0, bottom: 25.0),
          child: const Center(
            child: Text(
              'Guadalajara \n Customs',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25, bottom: 145.0),
          child: const Center(
            child: Text(
              'El lugar ideal para tu Auto',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 55.0),
          child: Center(
            child: ElevatedButton(
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
                      return const HomePageAdmin();
                    },
                  ),
                );
              },
              child: const Text('Empezar', style: TextStyle(fontSize: 22)),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const EmployeeScreen();
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
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: const Center(
            child: Text(
              '© 2023 Guadalajara Customs',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}

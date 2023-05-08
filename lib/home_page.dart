import 'package:flutter/material.dart';
import 'package:proyectobd/client/home_page_client.dart';
import 'package:proyectobd/screens/client_screen.dart';
import 'package:proyectobd/screens/login_screen_employee.dart';
import 'package:proyectobd/screens/employee_screen.dart';
import 'package:proyectobd/select_user.dart';
import 'package:proyectobd/select_user_login.dart';

import 'screens/login_screen_client.dart';
//import 'select_user.dart';
import 'package:proyectobd/components/rounded_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80.0, bottom: 25.0),
            child: const Center(
              child: Text(
                'GUADALAJARA \n CUSTOMS',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Center(
              child: Image(
                image: AssetImage('assets/images/Logo.png'),
                width: 150,
                height: 150,
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
              child: RoundedButton(
                text: 'Empezar',
                textColor: Colors.white,
                btnColor: Colors.blue,
                fontSize: 18,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const SelectUser();
                      },
                    ),
                  );
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const SelectUserLogin();
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
      ),
    );
  }
}

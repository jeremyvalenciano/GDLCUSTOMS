import 'package:flutter/material.dart';
import 'package:proyectobd/screens/client_screen.dart';

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
              child: RoundedButton(
                text: 'Empezar',
                textColor: Colors.white,
                btnColor: Colors.blue,
                fontSize: 18,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LoginScreenClient();
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
                          return const ClientScreen();
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

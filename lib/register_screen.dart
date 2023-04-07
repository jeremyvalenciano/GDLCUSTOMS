import 'package:flutter/material.dart';

//Validacion de email y de contraseña

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterScreen'),
      ),
      body: Column(
        children: const [
          Text('Empezar'),
          Text('Rellena los siguientes campos'),
          TextField(
            decoration: InputDecoration(
              labelText: 'Nombre:',
            ),
            textInputAction: TextInputAction
                .done, // Acción que se realiza al presionar la tecla de retorno
            maxLength: 30, // Máximo número de caracteres permitidos
            keyboardType: TextInputType
                .text, // Tipo de teclado que se muestra (en este caso, el teclado de texto)
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Correo electrónico:',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Contraseña',
            ),
            obscureText: true,
          ),
          Center(
            child: ElevatedButton(
              onPressed: null,
              child: Text('Crear cuenta'),
            ),
          ),
          Center(
            child: Text(
              'Tienes cuenta?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: null,
              child: Text('Iniciar sesión'),
            ),
          ),
        ],
      ),
    );
  }
}

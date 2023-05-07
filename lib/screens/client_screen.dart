import 'package:flutter/material.dart';
import '../database.dart';
import '../classes/client_class.dart';
import 'login_screen_client.dart';
import 'package:proyectobd/screens/car_screen.dart';

//Components
import 'package:proyectobd/components/input_text_field.dart';
import 'package:proyectobd/components/rounded_button.dart';

final dbHelper = DatabaseHelper.instance;

class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);
  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cellphoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final dateController = TextEditingController();
  final ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Cliente'),
        backgroundColor: Colors.orange.shade600,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
            children: [
              const Text('Empezar',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 25, bottom: 20),
                child: const Text(
                  'Rellena los siguientes campos',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
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
                maxLength: 35,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: passwordController,
                labelText: 'Contraseña',
                hintText: 'Ingrese su contraseña',
                icon: const Icon(Icons.lock),
                maxLength: 15,
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
                maxLength: 10,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: cityController,
                labelText: 'Estado',
                hintText: 'Ingrese su estado',
                icon: const Icon(Icons.location_city),
                maxLength: 20,
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Direccion:',
                  hintText: 'Ingrese su direccion',
                  prefixIcon: Icon(Icons.location_on),
                ),
                maxLength: 40,
                textInputAction: TextInputAction
                    .done, // Acción que se realiza al presionar la tecla de retorno
                keyboardType: TextInputType
                    .text, // Tipo de teclado que se muestra (en este caso, el teclado de texto)
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
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: RoundedButton(
                  text: 'Siguiente',
                  btnColor: Colors.orange.shade600,
                  fontSize: 15,
                  textColor: Colors.white,
                  onPressed: () {
                    final client = Client(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      cellphone: cellphoneController.text,
                      birthday: dateController.text,
                      address: addressController.text,
                      genre: _genderController.text,
                      city: cityController.text,
                      age: int.parse(ageController.text),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return CarScreen(
                            client: client,
                          );
                        },
                      ),
                    );
                  },
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
                              return const LoginScreenClient();
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

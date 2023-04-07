import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'login_screen.dart';
import 'employee_class.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class Gender {
  static const Gender male = Gender('Male');
  static const Gender female = Gender('Female');

  final String name;

  const Gender(this.name);
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  Gender? gender;

  final rfcController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cellphoneController = TextEditingController();
  final addressController = TextEditingController();
  final genreController = TextEditingController();
  final cityController = TextEditingController();
  final dateController = TextEditingController();
  final ageController = TextEditingController();
  final fiscalRegimeController = TextEditingController();
  final roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Empleado'),
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
                    style: TextStyle(fontSize: 15)),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'RFC:',
                  hintText: 'Ingrese su RFC',
                  prefixIcon: Icon(Icons.person),
                ),
                controller: rfcController,
                textInputAction: TextInputAction
                    .done, // Acción que se realiza al presionar la tecla de retorno
                maxLength: 30, // Máximo número de caracteres permitidos
                keyboardType: TextInputType
                    .text, // Tipo de teclado que se muestra (en este caso, el teclado de texto)
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Nombre:',
                  hintText: 'Ingrese su nombre',
                  prefixIcon: Icon(Icons.person),
                ),
                controller: nameController,
                textInputAction: TextInputAction
                    .done, // Acción que se realiza al presionar la tecla de retorno
                maxLength: 30, // Máximo número de caracteres permitidos
                keyboardType: TextInputType
                    .text, // Tipo de teclado que se muestra (en este caso, el teclado de texto)
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Correo electrónico:',
                  hintText: 'Ingrese su correo electrónico',
                  prefixIcon: Icon(Icons.email),
                ),
                controller: emailController,
                maxLength: 30,
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Contraseña',
                  hintText: 'Ingrese su contraseña',
                  prefixIcon: Icon(Icons.password),
                ),
                controller: passwordController,
                maxLength: 15,
                obscureText: true,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Número de teléfono',
                  hintText: 'Ingrese su número de teléfono',
                  prefixIcon: Icon(Icons.phone),
                ),
                controller: cellphoneController,
                maxLength: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Regimen Fiscal:',
                  hintText: 'Ingrese su regimen fiscal',
                  prefixIcon: Icon(Icons.money),
                ),
                controller: fiscalRegimeController,
                maxLength: 20,
                textInputAction: TextInputAction
                    .done, // Acción que se realiza al presionar la tecla de retorno
                keyboardType: TextInputType
                    .text, // Tipo de teclado que se muestra (en este caso, el teclado de texto)
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Rol en la empresa:',
                  hintText: 'Ingrese su rol',
                  prefixIcon: Icon(Icons.person),
                ),
                controller: roleController,
                maxLength: 20,
                textInputAction: TextInputAction
                    .done, // Acción que se realiza al presionar la tecla de retorno
                keyboardType: TextInputType
                    .text, // Tipo de teclado que se muestra (en este caso, el teclado de texto)
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Direccion:',
                  hintText: 'Ingrese su direccion',
                  prefixIcon: Icon(Icons.location_on),
                ),
                textInputAction: TextInputAction
                    .done, // Acción que se realiza al presionar la tecla de retorno
                maxLength: 30, // Máximo número de caracteres permitidos
                keyboardType: TextInputType
                    .text, // Tipo de teclado que se muestra (en este caso, el teclado de texto)
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Fecha de nacimiento',
                    hintText: 'Ingrese su fecha de nacimiento',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1900, 1, 1),
                        maxTime: DateTime(2022, 12, 31),
                        onChanged: (date) {}, onConfirm: (date) {
                      dateController.text = date.toString();
                    }, currentTime: DateTime.now(), locale: LocaleType.es);
                  },
                ),
              ),
              const Text('Seleccione su genero:'),
              Column(
                children: <Widget>[
                  RadioListTile<Gender>(
                    title: const Text('Masculino'),
                    value: Gender.male,
                    groupValue: gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                  RadioListTile<Gender>(
                    title: const Text('Femenino'),
                    value: Gender.female,
                    groupValue: gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ],
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Estado',
                  hintText: 'Ingrese su Estado',
                  prefixIcon: Icon(Icons.location_city),
                ),
                controller: cityController,
                maxLength: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Edad:',
                  hintText: 'Ingrese su edad',
                  prefixIcon: Icon(Icons.numbers),
                ),
                controller: ageController,
              ),
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 60),
                child: Center(
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
                        const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 20),
                      ),
                    ),
                    onPressed: () async {
                      await dbHelper.insertEmployee(Employee(
                        rfc: rfcController.text,
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        cellphone: cellphoneController.text,
                        birthday: dateController.text,
                        address: addressController.text,
                        genre: gender.toString(),
                        city: cityController.text,
                        age: int.parse(ageController.text),
                        role: roleController.text,
                        fiscalRegime: fiscalRegimeController.text,
                      ));
                    },
                    child: const Text('Crear cuenta',
                        style: TextStyle(fontSize: 20)),
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
                              return const LoginScreen();
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

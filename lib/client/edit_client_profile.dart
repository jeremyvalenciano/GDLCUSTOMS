import 'package:flutter/material.dart';
import 'package:proyectobd/client/home_page_client.dart';
import 'package:proyectobd/database.dart';
import 'package:proyectobd/components/input_text_field.dart';
import 'package:proyectobd/components/rounded_button.dart';
import 'package:proyectobd/client/edit_client_profile.dart';
import '../classes/client_class.dart';
import 'package:sqflite/sqflite.dart';

final dbHelper = DatabaseHelper.instance;

class EditClientprofile extends StatefulWidget {
  final Client client;
  const EditClientprofile({required this.client, super.key});

  @override
  State<EditClientprofile> createState() => _EditClientprofileState();
}

class _EditClientprofileState extends State<EditClientprofile> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cellphoneController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var dateController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController();
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.client.name;
    emailController.text = widget.client.email;
    passwordController.text = widget.client.password;
    cellphoneController.text = widget.client.cellphone;
    addressController.text = widget.client.address;
    cityController.text = widget.client.city;
    dateController.text = widget.client.birthday;
    ageController.text = widget.client.age.toString();
    genderController.text = widget.client.genre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar de Cliente'),
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
                      genderController.text = value.toString();
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
                      genderController.text = value.toString();
                    });
                  },
                ),
              ]),
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: RoundedButton(
                  text: 'Guardar cambios',
                  btnColor: Colors.orange.shade600,
                  fontSize: 15,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        cellphoneController.text.isEmpty ||
                        cityController.text.isEmpty ||
                        addressController.text.isEmpty ||
                        ageController.text.isEmpty ||
                        dateController.text.isEmpty ||
                        genderController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, llene todos los campos'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      final client = Client(
                        id: widget.client.id,
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        cellphone: cellphoneController.text,
                        birthday: dateController.text,
                        address: addressController.text,
                        genre: genderController.text,
                        city: cityController.text,
                        age: int.parse(ageController.text),
                      );
                      try {
                        int result = await dbHelper.updateClient(
                            widget.client.id!, client);
                        debugPrint('Update result: $result');

                        if (result > 0 && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Modificacion Exitosa de Cliente!'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePageClient(client: client)),
                              (Route<dynamic> route) => false);
                        }
                      } catch (e) {
                        if (e is DatabaseException) {
                          String errorMessage = e.toString();
                          RegExp regExp = RegExp(
                              "'Error: Client email already in use (.+)");
                          Match? match = regExp.firstMatch(errorMessage);
                          if (match != null) {
                            errorMessage = match.group(1) ?? errorMessage;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Correo en uso! intente de nuevo'),
                              backgroundColor: Colors.orange,
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

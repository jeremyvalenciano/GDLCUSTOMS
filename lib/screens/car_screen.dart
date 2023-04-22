import 'package:flutter/material.dart';
import '../database.dart';
import '../classes/car_class.dart';
import '../classes/client_class.dart';

//Components
import 'package:proyectobd/components/input_text_field.dart';
import 'package:proyectobd/components/rounded_button.dart';

final dbHelper = DatabaseHelper.instance;

class CarScreen extends StatefulWidget {
  final Client client;
  const CarScreen({required this.client, super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final licencePlateController = TextEditingController();
  final modelController = TextEditingController();
  final brandController = TextEditingController();
  final typeController = TextEditingController();
  final yearController = TextEditingController();
  final doorsController = TextEditingController();
  final colorController = TextEditingController();
  final kilometersController = TextEditingController();
  final lastServiceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Auto'),
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
                controller: licencePlateController,
                labelText: 'Placas de su auto',
                hintText: 'Ingrese sus placas',
                icon: const Icon(Icons.drive_eta),
                maxLength: 40,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: modelController,
                labelText: 'Modelo de su auto',
                hintText: 'Ingrese modelo de su auto',
                icon: const Icon(Icons.drive_eta),
                maxLength: 40,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: brandController,
                labelText: 'Marca de su auto',
                hintText: 'Ingrese marca de su auto',
                icon: const Icon(Icons.drive_eta),
                maxLength: 15,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: yearController,
                labelText: 'Año de su auto',
                hintText: 'Ingrese año de su auto',
                icon: const Icon(Icons.drive_eta),
                maxLength: 10,
                keyboardType: TextInputType.phone,
              ),
              InputTextField(
                controller: typeController,
                labelText: 'Tipo de auto',
                hintText: 'Ingrese el tipo de auto',
                icon: const Icon(Icons.drive_eta),
                maxLength: 30,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: doorsController,
                labelText: 'Numero de puertas',
                hintText: 'Ingrese el numero de puertas',
                icon: const Icon(Icons.numbers),
                maxLength: 30,
                keyboardType: TextInputType.phone,
              ),
              InputTextField(
                controller: colorController,
                labelText: 'Color de auto',
                hintText: 'Ingrese el color de su auto',
                icon: const Icon(Icons.color_lens),
                maxLength: 30,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: kilometersController,
                labelText: 'Kilometraje',
                hintText: 'Ingrese su kilometraje',
                icon: const Icon(Icons.numbers),
                maxLength: 30,
                keyboardType: TextInputType.phone,
              ),
              InputTextField(
                controller: lastServiceController,
                labelText: 'Fecha de ultimo servicio',
                hintText: 'Ingrese su fecha de ultimo servicio',
                icon: const Icon(Icons.calendar_today),
                maxLength: 30,
                keyboardType: TextInputType.text,
              ),
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: RoundedButton(
                  text: 'Finalizar registro',
                  btnColor: Colors.blue,
                  fontSize: 15,
                  textColor: Colors.white,
                  onPressed: () async {
                    await dbHelper.insertClient(Client(
                      name: widget.client.name,
                      email: widget.client.email,
                      password: widget.client.password,
                      cellphone: widget.client.cellphone,
                      birthday: widget.client.birthday,
                      address: widget.client.address,
                      genre: widget.client.genre,
                      city: widget.client.city,
                      age: widget.client.age,
                    ));
                    final clientWithId =
                        await dbHelper.getClientByEmail(widget.client.email);

                    await dbHelper.insertCar(Car(
                      clientId: clientWithId.id,
                      licencePlate: licencePlateController.text,
                      model: modelController.text,
                      brand: brandController.text,
                      carYear: yearController.text,
                      type: typeController.text,
                      doors: int.parse(doorsController.text),
                      color: colorController.text,
                      kilometers: int.parse(kilometersController.text),
                      lastService: lastServiceController.text,
                    ));
                    debugPrint('Car registered');
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

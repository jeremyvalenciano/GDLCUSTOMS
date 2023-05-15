import 'package:flutter/material.dart';
import 'package:proyectobd/client/home_page_client.dart';
import '../database.dart';
import '../classes/car_class.dart';
import '../classes/client_class.dart';
import 'package:sqflite/sqflite.dart';

//Components
import 'package:proyectobd/components/input_text_field.dart';
import 'package:proyectobd/components/rounded_button.dart';

final dbHelper = DatabaseHelper.instance;

class EditCar extends StatefulWidget {
  final Car car;
  final Client client;
  const EditCar({required this.car, required this.client, super.key});

  @override
  State<EditCar> createState() => _EditCarState();
}

class _EditCarState extends State<EditCar> {
  var licencePlateController = TextEditingController();
  var modelController = TextEditingController();
  var brandController = TextEditingController();
  var typeController = TextEditingController();
  var yearController = TextEditingController();
  var doorsController = TextEditingController();
  var colorController = TextEditingController();
  var kilometersController = TextEditingController();
  var lastServiceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    licencePlateController =
        TextEditingController(text: widget.car.licencePlate);
    modelController = TextEditingController(text: widget.car.model);
    brandController = TextEditingController(text: widget.car.brand);
    typeController = TextEditingController(text: widget.car.type);
    yearController = TextEditingController(text: widget.car.carYear.toString());
    doorsController = TextEditingController(text: widget.car.doors.toString());
    colorController = TextEditingController(text: widget.car.color);
    kilometersController =
        TextEditingController(text: widget.car.kilometers.toString());
    lastServiceController = TextEditingController(
        text: widget.car.lastService.toString().substring(0, 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modificar de Auto'),
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
                controller: licencePlateController,
                labelText: 'Placas de su auto',
                hintText: 'Ingrese sus placas',
                icon: const Icon(Icons.eight_k_plus_sharp),
                maxLength: 10,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: brandController,
                labelText: 'Marca de su auto',
                hintText: 'Ingrese marca de su auto',
                icon: const Icon(Icons.format_color_text),
                maxLength: 15,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: modelController,
                labelText: 'Modelo de su auto',
                hintText: 'Ingrese modelo de su auto',
                icon: const Icon(Icons.drive_eta),
                maxLength: 15,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: typeController,
                labelText: 'Tipo de auto',
                hintText: 'Ingrese el tipo de auto',
                icon: const Icon(Icons.toys_sharp),
                maxLength: 15,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: yearController,
                labelText: 'Año de su auto',
                hintText: 'Ingrese año de su auto',
                icon: const Icon(Icons.calendar_today),
                maxLength: 4,
                keyboardType: TextInputType.phone,
              ),
              InputTextField(
                controller: doorsController,
                labelText: 'Numero de puertas',
                hintText: 'Ingrese el numero de puertas',
                icon: const Icon(Icons.numbers),
                maxLength: 1,
                keyboardType: TextInputType.phone,
              ),
              InputTextField(
                controller: colorController,
                labelText: 'Color de auto',
                hintText: 'Ingrese el color de su auto',
                icon: const Icon(Icons.color_lens),
                maxLength: 10,
                keyboardType: TextInputType.text,
              ),
              InputTextField(
                controller: kilometersController,
                labelText: 'Kilometraje',
                hintText: 'Ingrese su kilometraje',
                icon: const Icon(Icons.do_not_disturb_on_outlined),
                maxLength: 6,
                keyboardType: TextInputType.phone,
              ),
              InputTextField(
                controller: lastServiceController,
                labelText: 'Fecha de ultimo servicio',
                hintText: 'Ingrese su fecha de ultimo servicio',
                icon: const Icon(Icons.calendar_today),
                maxLength: 10,
                keyboardType: TextInputType.text,
              ),
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: RoundedButton(
                  text: 'Modificar auto',
                  btnColor: Colors.orange.shade600,
                  fontSize: 15,
                  textColor: Colors.white,
                  onPressed: () async {
                    if (licencePlateController.text.isEmpty ||
                        modelController.text.isEmpty ||
                        brandController.text.isEmpty ||
                        typeController.text.isEmpty ||
                        yearController.text.isEmpty ||
                        doorsController.text.isEmpty ||
                        colorController.text.isEmpty ||
                        kilometersController.text.isEmpty ||
                        lastServiceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor llene todos los campos'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      final car = Car(
                        id: widget.car.id,
                        clientId: widget.car.clientId,
                        licencePlate: licencePlateController.text,
                        model: modelController.text,
                        brand: brandController.text,
                        carYear: yearController.text,
                        type: typeController.text,
                        doors: int.parse(doorsController.text),
                        color: colorController.text,
                        kilometers: int.parse(kilometersController.text),
                        lastService: lastServiceController.text,
                      );
                      try {
                        debugPrint('Editing car');
                        int result =
                            await dbHelper.updateCar(widget.car.id!, car);

                        if (result > 0 && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Modificacion Exitosa de auto!'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePageClient(client: widget.client)),
                              (Route<dynamic> route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Modificacion fallida!'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      } catch (e) {
                        if (e is DatabaseException) {
                          String errorMessage = e.toString();
                          debugPrint('Error: $errorMessage');
                          RegExp regExp =
                              RegExp("Error: LicencePlate already in use (.+)");
                          Match? match = regExp.firstMatch(errorMessage);
                          if (match != null) {
                            errorMessage = match.group(1) ?? errorMessage;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Auto ya registrado con esas Placas! intente de nuevo'),
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

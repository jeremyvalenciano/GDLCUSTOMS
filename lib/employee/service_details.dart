import 'package:flutter/material.dart';
import 'package:proyectobd/classes/service_request_class.dart';
import 'package:proyectobd/components/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:proyectobd/classes/service_class.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:proyectobd/database.dart';

Future<void> dialNumber(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

class ServiceDetails extends StatefulWidget {
  final int? clientId;
  final int? requestId;
  final int? employeeId;
  final int? carId;

  const ServiceDetails(
      {this.clientId, this.requestId, this.employeeId, this.carId, super.key});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  bool functionExecuted = false;
  List<Service> services = []; // Lista de servicios desde la BD
  List<Service> updatedServices = []; // lista de servicios actualizados
  final dbHelper = DatabaseHelper.instance;
  String clientName = '';
  String clientPhone = '';
  String clientEmail = '';
  String clientAddress = '';
  String clientCity = '';
  String carInfo = '';
  double total = 0;

  getClientById() async {
    Future<Client> futureClient = dbHelper.getClientById(widget.clientId!);
    futureClient.then((client) {
      setState(() {
        clientName = client.name;
        clientPhone = client.cellphone;
        clientEmail = client.email;
      });
    });
  }

  getServiceByRequestId() async {
    Future<List<Service>> futureServices =
        dbHelper.getServicesByRequestId(widget.requestId!);
    futureServices.then((services) {
      setState(() {
        this.services = services;
        calculateTotal();
      });
    });
  }

  calculateTotal() {
    total = 0;
    for (var service in services) {
      total += service.serviceCost;
    }
    dbHelper.updateTotalTicket(widget.requestId!, total);
  }

  getRequestById() async {
    Future<ServiceRequest> request = dbHelper.getRequestById(widget.requestId);
    request.then((req) {
      setState(() {
        carInfo = '${req.brandCar} - ${req.modelCar} - ${req.licencePlate}';
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getClientById();
    getServiceByRequestId();
    getRequestById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Detalles del servicio'),
        backgroundColor: Colors.blue.shade400,
        shadowColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 30, left: 15),
              decoration: BoxDecoration(
                color: Colors.blue.shade400,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(
                      25.0), // Radio de la esquina inferior izquierda
                  bottomRight: Radius.circular(
                      25.0), // Radio de la esquina inferior derecha
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.drive_eta_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 29.0),
                    child: Text('Numero de solicitud: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Text('${widget.requestId}0'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15, left: 15),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Información Personal',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Text('Nombre: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(clientName),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Auto: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(carInfo),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Celular: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(clientPhone),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Correo electronico: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(clientEmail),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                    indent: 8,
                    endIndent: 8,
                  ),
                  const Text('Servicios solicitados: ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: SizedBox(
                      height: 200,
                      child: FutureBuilder<List<Service>>(
                        future:
                            dbHelper.getServicesByRequestId(widget.requestId!),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Service>> snapshot) {
                          if (snapshot.hasData) {
                            List<Service> services = snapshot.data!;
                            return ListView.builder(
                              itemCount: services.length,
                              itemBuilder: (BuildContext context, int index) {
                                Service service = services[index];

                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(service.name),
                                        Text(service.description),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                service.serviceCost.toString()),
                                          ],
                                        ),
                                        // etc.
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                    indent: 8,
                    endIndent: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12, right: 20, left: 20, bottom: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(total.toString()),
                      ],
                    ),
                  ),
                  Center(
                    child: RoundedButton(
                      text: 'Editar',
                      textColor: Colors.black,
                      btnColor: Colors.blue.shade400,
                      fontSize: 15,
                      onPressed: () {
                        // Define los servicios disponibles

                        // Define los controladores para los inputs de precio de refacciones y costo adicional
                        final TextEditingController partsPriceController =
                            TextEditingController();
                        final TextEditingController additionalCostController =
                            TextEditingController();

                        // Crea el AlertDialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title:
                                Text('Editar solicitud ${widget.requestId}0'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Lista de servicios con inputs de precio
                                for (var service in services)
                                  Row(
                                    children: [
                                      Expanded(child: Text(service.name)),
                                      const Icon(Icons.attach_money),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                        width: 80,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: 'Precio'),
                                          controller: TextEditingController(
                                              text: service.serviceCost
                                                  .toString()),
                                          onChanged: (value) {
                                            // Actualiza el precio del servicio
                                            service.serviceCost =
                                                double.parse(value);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 16),
                                // Input para precio de refacciones
                                TextField(
                                  controller: partsPriceController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Costo de refacciones',
                                    suffixIcon: Icon(Icons.attach_money),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Input para costo adicional
                                TextField(
                                  controller: additionalCostController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Agregar costo adicional',
                                    suffixIcon: Icon(Icons.attach_money),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              // Botón de "Cancelar"
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              // Botón de "Guardar"
                              ElevatedButton(
                                onPressed: () {
                                  for (var service in services) {
                                    debugPrint(
                                        'ServiceId ${service.id} - ${service.serviceCost}');

                                    dbHelper.updateServiceCosts(
                                        service.id!, service.serviceCost);
                                    getServiceByRequestId();
                                    calculateTotal();
                                  }
                                  // Aquí podrías guardar los precios y realizar cualquier otra acción que necesites
                                  Navigator.pop(context);
                                  //updatedServices = services;
                                },
                                child: const Text('Guardar'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: RoundedButton(
                      text: 'Llamar Cliente',
                      textColor: Colors.white,
                      btnColor: Colors.black,
                      fontSize: 15,
                      onPressed: () {
                        dialNumber(clientPhone);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

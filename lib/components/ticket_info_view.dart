import 'package:flutter/material.dart';
import 'package:proyectobd/components/rounded_button.dart';
import 'package:proyectobd/components/service_element.dart';
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

class TicketInfoView extends StatefulWidget {
  final int? clientId;
  final int? requestId;

  const TicketInfoView({this.clientId, this.requestId, super.key});

  @override
  State<TicketInfoView> createState() => _TicketInfoViewState();
}

class _TicketInfoViewState extends State<TicketInfoView> {
  bool functionExecuted = false;
  List<Service> services = [];
  final dbHelper = DatabaseHelper.instance;
  String clientName = '';
  String clientPhone = '';
  String clientEmail = '';
  String clientAddress = '';
  String clientCity = '';
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
        for (var service in services) {
          total += service.serviceCost;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getClientById();
    getServiceByRequestId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Detalles del servicio'),
        backgroundColor: Colors.orange[600],
        shadowColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 30, left: 15),
            decoration: BoxDecoration(
              color: Colors.orange[600],
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                                          Text(service.serviceCost.toString()),
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
                    text: 'Enviar al Correo',
                    textColor: Colors.black,
                    btnColor: Colors.orange,
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
    );
  }
}
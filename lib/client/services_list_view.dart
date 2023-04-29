import 'package:flutter/material.dart';
import 'package:proyectobd/admin/admin_login.dart';
import 'package:proyectobd/classes/car_class.dart';
import 'package:proyectobd/classes/service_class.dart';
import 'package:proyectobd/classes/service_request_class.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServicesListView extends StatefulWidget {
  List<Car> autos;
  Car? autoSelected;
  final Client client;
  ServicesListView({Key? key, required this.autos, required this.client})
      : super(key: key);

  @override
  _ServicesListViewState createState() => _ServicesListViewState();
}

Future<int> getrequestId(String licence) async {
  ServiceRequest request = await dbHelper.getRequestIdBylicence(licence);
  int idRequest = request.id as int;
  return idRequest;
}

class _ServicesListViewState extends State<ServicesListView> {
  final List<Service> _services = [
    Service(
        name: 'Revisión General',
        description: 'Revision general para el automovil',
        serviceCost: 350.0,
        estimatedTime: 60),
    Service(
        name: 'Cambio de Aceite y Filtro',
        description: 'Cambio de aceite y filtro para el automovil',
        serviceCost: 500.0,
        estimatedTime: 60),
    Service(
        name: 'Cambio de Bujias ',
        description: 'Cambio de bujias para el automovil',
        serviceCost: 400.0,
        estimatedTime: 40),
    Service(
        name: 'Cambio de Frenos',
        description: 'Cambio de frenos para el automovil',
        serviceCost: 1400.0,
        estimatedTime: 120),
    Service(
        name: 'Alineacion y Balanceo',
        description: 'Alineacion y Balanceo para el automovil',
        serviceCost: 500.0,
        estimatedTime: 60),
    Service(
        name: 'Cambio de Amortiguadores',
        description: 'Cambio de Amortiguadores para el automovil',
        serviceCost: 40.0,
        estimatedTime: 120),
    Service(
        name: 'Cambio de Clutch',
        description: 'Cambio de Clutch para el automovil',
        serviceCost: 1200.0,
        estimatedTime: 150),
    Service(
        name: 'Detallado General',
        description: 'Detallado general para el automovil',
        serviceCost: 2500.0,
        estimatedTime: 240),
  ];

  final List<Service> _selectedServices = [];

  void _addService(Service service) {
    if (!_selectedServices.contains(service)) {
      setState(() {
        _selectedServices.add(service);
      });
    }
  }

  void _removeService(Service service) {
    setState(() {
      _selectedServices.remove(service);
    });
    Fluttertoast.showToast(
        msg: 'Servicio eliminado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          DropdownButtonFormField<Car>(
            value: widget.autoSelected,
            items: widget.autos.map((auto) {
              return DropdownMenuItem<Car>(
                value: auto,
                child: Text(
                    '${auto.brand} ${auto.model} ${auto.carYear} - ${auto.licencePlate}'),
              );
            }).toList(),
            onChanged: (Car? value) {
              setState(() {
                widget.autoSelected = value;
              });
            },
          ),
          const Text('Servicios disponibles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _services.length,
              itemBuilder: (BuildContext context, int index) {
                final Service service = _services[index];
                return ListTile(
                  title: Text(service.name),
                  subtitle: Text(
                      'Precio: \$${service.serviceCost} - Tiempo: ${service.estimatedTime} min.'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _addService(service);
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          const Text('Servicios seleccionados',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedServices.length,
              itemBuilder: (BuildContext context, int index) {
                final Service service = _selectedServices[index];
                return ListTile(
                  title: Text(service.name),
                  subtitle: Text(
                      'Precio: \$${service.serviceCost} - Tiempo: ${service.estimatedTime} min.'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _removeService(service);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (widget.autoSelected == null) {
            Fluttertoast.showToast(
                msg: 'Seleccione un auto o registre uno nuevo',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey[600],
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (_selectedServices.isEmpty) {
            Fluttertoast.showToast(
                msg: 'Seleccione al menos un servicio',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey[600],
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (widget.autoSelected != null && _selectedServices.isNotEmpty) {
            Fluttertoast.showToast(
                msg: 'Solicitud enviada',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey[600],
                textColor: Colors.white,
                fontSize: 16.0);
            Future<int> idRequest = dbHelper.insertRequest(ServiceRequest(
                clientId: widget.client.id,
                carId: widget.autoSelected!.id,
                clientName: widget.client.name,
                modelCar: widget.autoSelected!.model,
                brandCar: widget.autoSelected!.brand,
                licencePlate: widget.autoSelected!.licencePlate,
                status: 'En revisión',
                date: DateTime.now().toString().split('.')[0],
                paid: 'No'));
            int idNormal;
            idRequest.then((value) {
              idNormal = value;
              debugPrint('idRequest=: $idNormal');
              for (var service in _selectedServices) {
                dbHelper.insertService(Service(
                    requestId: idNormal,
                    clientId: widget.client.id,
                    carId: widget.autoSelected!.id,
                    name: service.name,
                    description: service.description,
                    serviceCost: service.serviceCost,
                    estimatedTime: service.estimatedTime));
                debugPrint(
                    '${widget.client.id} ${widget.autoSelected!.id} ${service.name} ${service.description} ${service.serviceCost} ${service.estimatedTime}');
              }
            });
          }
        },
        label: const Text('Solicitar servicios'),
        icon: const Icon(Icons.send),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:proyectobd/classes/small_service_class.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServicesListView extends StatefulWidget {
  const ServicesListView({Key? key}) : super(key: key);

  @override
  _ServicesListViewState createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  final List<Service> _services = [
    Service(name: 'Revisión General', price: 350.0, estimatedTime: 60),
    Service(name: 'Cambio de Aceite y Filtro', price: 500.0, estimatedTime: 60),
    Service(name: 'Cambio de Bujias ', price: 400.0, estimatedTime: 40),
    Service(name: 'Cambio de Frenos', price: 1400.0, estimatedTime: 120),
    Service(name: 'Alineacion y Balanceo', price: 500.0, estimatedTime: 60),
    Service(name: 'Cambio de Amortiguadores', price: 40.0, estimatedTime: 120),
    Service(name: 'Cambio de Clutch', price: 1200.0, estimatedTime: 150),
    Service(name: 'Detallado General', price: 2500.0, estimatedTime: 240),
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
                      'Precio: \$${service.price} - Tiempo: ${service.estimatedTime} min.'),
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
          const Text(
            'Servicios seleccionados',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedServices.length,
              itemBuilder: (BuildContext context, int index) {
                final Service service = _selectedServices[index];
                return ListTile(
                  title: Text(service.name),
                  subtitle: Text(
                      'Precio: \$${service.price} - Tiempo: ${service.estimatedTime} min.'),
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
          // Lógica para solicitar servicios
        },
        label: Text('Solicitar servicios'),
        icon: Icon(Icons.send),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

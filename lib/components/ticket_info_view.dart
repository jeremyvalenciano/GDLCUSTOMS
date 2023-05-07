import 'package:flutter/material.dart';
import 'package:proyectobd/classes/service_class.dart';
import 'package:proyectobd/database.dart';

class TicketInfoView extends StatefulWidget {
  final int? requestId;
  final int? employeeId;
  final int? clientId;
  final int? carId;
  final double total;
  final String date;
  const TicketInfoView(
      {this.requestId,
      this.employeeId,
      this.clientId,
      this.carId,
      required this.total,
      required this.date,
      Key? key})
      : super(key: key);
  @override
  _TicketInfoViewState createState() => _TicketInfoViewState();
}

final dbHelper = DatabaseHelper.instance;

class _TicketInfoViewState extends State<TicketInfoView> {
  double totalServiceCost = 0;
  List<Service> services = [];
  getServiceByRequestId() async {
    Future<List<Service>> futureServices =
        dbHelper.getServicesByRequestId(widget.requestId!);
    futureServices.then((services) {
      setState(() {
        this.services = services;
        for (var service in services) {
          totalServiceCost += service.serviceCost;
          debugPrint("total: $totalServiceCost");
          debugPrint('service: ${service.serviceCost}');
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del ticket'),
      ),
      body: Column(
        children: [
          const Text('Información del cliente'),
          Text('Nombre: ${widget.clientId}'),
          const Text('Información del vehículo'),
          const Text('Información del servicio'),
          const Text('Información del empleado'),
          const Text('Información del ticket'),
        ],
      ),
    );
  }
}

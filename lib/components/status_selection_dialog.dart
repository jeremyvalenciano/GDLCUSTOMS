import 'package:flutter/material.dart';
import 'package:proyectobd/classes/service_class.dart';

import 'package:proyectobd/classes/ticket_class.dart';
import 'package:proyectobd/employee/home_page_employee.dart';
import 'package:intl/intl.dart';

import '../classes/service_request_class.dart';

class StatusSelectionDialog extends StatefulWidget {
  final int? requestId;
  final int? employeeId;
  final int? clientId;
  final int? carId;
  final VoidCallback onUpdateRequestList;
  const StatusSelectionDialog(
      {this.requestId,
      this.employeeId,
      this.clientId,
      this.carId,
      required this.onUpdateRequestList,
      Key? key})
      : super(key: key);
  @override
  _StatusSelectionDialogState createState() => _StatusSelectionDialogState();
}

class _StatusSelectionDialogState extends State<StatusSelectionDialog> {
  double totalServiceCost = 0;
  double sparePartsCost = 0;
  double extraCost = 0;
  double total = 0;
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

  getRequestById() async {
    Future<ServiceRequest> request = dbHelper.getRequestById(widget.requestId);
    request.then((req) {
      setState(() {
        sparePartsCost = req.sparePartsCost!;
        extraCost = req.extraCost!;
        total = req.total!;
        debugPrint('spare: ${req.sparePartsCost}');
        debugPrint('extraCost: ${req.extraCost}');
        debugPrint('total: ${req.total}');
      });
    });
  }

  String? _selectedStatus;
  @override
  void initState() {
    super.initState();
    getServiceByRequestId();
    getRequestById();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Seleccionar Nuevo Status"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: const Text("En proceso"),
            value: "En proceso",
            groupValue: _selectedStatus,
            onChanged: (value) {
              setState(() {
                _selectedStatus = value;
              });
            },
          ),
          RadioListTile(
            title: const Text("Finalizado"),
            value: "Finalizado",
            groupValue: _selectedStatus,
            onChanged: (value) {
              setState(() {
                _selectedStatus = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blue.shade400),
          ),
          onPressed: () {
            _showConfirmationDialog(context);
          },
          child: const Text("Aceptar"),
        ),
      ],
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    bool? confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("¿Estás seguro?"),
          content: Text(
            "¿Estás seguro de que deseas cambiar el estado a '$_selectedStatus'?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue.shade400),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
                widget.onUpdateRequestList();
              },
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
    if (confirmed == true && _selectedStatus == "En proceso") {
      // hacer algo aquí cuando se confirme el cambio de estado
      dbHelper.updateRequestStatus(widget.requestId!, _selectedStatus!);
      debugPrint("en proceso");
    } else if (confirmed == true && _selectedStatus == "Finalizado") {
      dbHelper.updateRequestStatus(widget.requestId!, _selectedStatus!);
      getServiceByRequestId();
      String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
      dbHelper.insertTicket(Ticket(
        employeeId: widget.employeeId,
        clientId: widget.clientId,
        carId: widget.carId,
        requestId: widget.requestId,
        total: total,
        date: formattedDate,
      ));
      debugPrint("finalizado");
      debugPrint("cliente: ${widget.clientId}");
      debugPrint("empleado: ${widget.employeeId}");
      debugPrint("carId: ${widget.carId}");
      debugPrint("requestId: ${widget.requestId}");
    }
  }
}

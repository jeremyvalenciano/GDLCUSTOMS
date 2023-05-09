import 'package:flutter/material.dart';
import 'package:proyectobd/classes/employee_class.dart';
import 'package:proyectobd/employee/home_page_employee.dart';

class CardRequest extends StatelessWidget {
  final Employee employee;
  final int? requestId;
  final int? employeeId;
  final String clientName;
  final String brandCar;
  final String model;
  final String licencePlates;

  final String date;
  final VoidCallback onPressedDetails;
  final VoidCallback onUpdateRequestList;
  const CardRequest(
      {this.requestId,
      this.employeeId,
      required this.employee,
      required this.clientName,
      required this.brandCar,
      required this.model,
      required this.licencePlates,
      required this.date,
      required this.onPressedDetails,
      required this.onUpdateRequestList,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://static.vecteezy.com/system/resources/previews/007/033/146/original/profile-icon-login-head-icon-vector.jpg',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    clientName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$brandCar $model',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          licencePlates,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: onPressedDetails,
                    child: const Text(
                      'Ver detalles',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Aceptar petición"),
                          content: const Text(
                              "¿Está seguro de que deseas aceptar la petición?"),
                          actions: [
                            TextButton(
                              child: const Text("Cancelar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text("Si, aceptar"),
                              onPressed: () {
                                dbHelper.asignEmployeeIdToRequest(
                                    requestId!, employee.id!, employee.name);
                                onUpdateRequestList();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );

                    debugPrint('Se asignó el empleado a la petición');
                    debugPrint('employeeId: ${employee.id!}');
                    debugPrint('requestId: ${requestId!}');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: const Text('Aceptar',
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Eliminar petición"),
                          content: const Text(
                              "¿Está seguro de que desea eliminar la petición?"),
                          actions: [
                            TextButton(
                              child: const Text("Cancelar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text("Si, eliminar"),
                              onPressed: () {
                                dbHelper.deleteRequest(requestId!);
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePageEmployee(employee: employee)),
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  child: const Text('Rechazar',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

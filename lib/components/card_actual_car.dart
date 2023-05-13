import 'package:flutter/material.dart';
import 'package:proyectobd/components/status_selection_dialog.dart';
import 'package:proyectobd/employee/service_details.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<String>> searchImages(String query) async {
  const apiKey =
      'AIzaSyBgWozMBBzay_3aFfVeWDXqSvl-ijsrMLE'; // Reemplaza por tu propia API Key
  final searchUrl =
      'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=c712f948d33c04341&searchType=image&q=$query';

  final response = await http.get(Uri.parse(searchUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data['items'] != null) {
      final items = List.from(data['items']);
      final imageUrls = items.map((item) => item['link']).toList();
      return imageUrls.cast<String>();
    }
  }

  return [];
}

class CardActualCar extends StatelessWidget {
  final int? requestId;
  final int? employeeId;
  final int? clientId;
  final int? carId;
  final String clientName;
  final String brand;
  final String model;
  final String licencePlates;
  final String date;
  final String status;
  final String paid;

  final VoidCallback onUpdateRequestList;
  const CardActualCar(
      {required this.requestId,
      this.employeeId,
      this.clientId,
      this.carId,
      required this.clientName,
      required this.brand,
      required this.licencePlates,
      required this.model,
      required this.date,
      required this.status,
      required this.paid,
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
                      'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Auto',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$brand $model',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Status',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        status,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Fecha',
                        style: TextStyle(
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    debugPrint('paid: $paid');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ServiceDetails(
                            clientId: clientId,
                            requestId: requestId,
                            employeeId: employeeId,
                            carId: carId,
                          );
                        },
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: const Text('Ver Detalles',
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => StatusSelectionDialog(
                            requestId: requestId,
                            employeeId: employeeId,
                            clientId: clientId,
                            carId: carId,
                            onUpdateRequestList: onUpdateRequestList));
                    debugPrint('requestId: $requestId');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text('Editar Status',
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

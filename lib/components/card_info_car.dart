import 'package:flutter/material.dart';
import 'package:proyectobd/admin/admin_login.dart';
import 'package:proyectobd/components/rounded_button.dart';
import 'package:proyectobd/classes/car_class.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:proyectobd/client/home_page_client.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/*Future<String?> getFirstImageUrl(String searchText) async {
  final String apiKey = 'AIzaSyBal3rXuXMXcNeqkQ1F_OU0f825ptk1DcY';
  final String searchEngineId = 'c712f948d33c04341';
  final String url = 'https://www.googleapis.com/customsearch/v1?'
      'key=$apiKey'
      '&cx=$searchEngineId'
      '&searchType=image'
      '&q=$searchText';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data != null && data['items'] != null) {
      final items = data['items'] as List;
      if (items.isNotEmpty) {
        final imageUrl = items.first['link'] as String;
        debugPrint('imageUrl: $imageUrl');
        return imageUrl;
      }
    }
  }

  return '';
}*/

class CardInfoCar extends StatefulWidget {
  final Car car;
  final Client client;
  const CardInfoCar({required this.car, required this.client, super.key});

  @override
  State<CardInfoCar> createState() => _CardInfoCarState();
}

class _CardInfoCarState extends State<CardInfoCar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informacion de su Automovil'),
        backgroundColor: Colors.orange.shade500,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
            child: Text(
              'Su Automovil',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    'Modelo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.car.model),
                ],
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Marca',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.car.brand),
                ],
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Año',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.car.carYear),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                'https://static.vecteezy.com/system/resources/previews/008/561/510/non_2x/simple-icon-modern-sign-car-silhouette-on-background-front-view-car-icon-vehicle-inspiration-editable-eps10-free-vector.jpg',
                height: 325.0,
              ),
              const Text(
                'Placas',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.car.licencePlate),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        'Kilometraje',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text('${widget.car.kilometers}'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Text(
                        'Ultimo servicio',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(widget.car.lastService),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedButton(
                    text: 'Editar',
                    textColor: Colors.white,
                    btnColor: Colors.blue,
                    fontSize: 18,
                    onPressed: () {}),
                const SizedBox(
                  width: 10,
                  height: 25,
                ),
                RoundedButton(
                    text: 'Eliminar',
                    textColor: Colors.white,
                    btnColor: Colors.red,
                    fontSize: 18,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Eliminar automóvil'),
                            content: const Text(
                                '¿Está seguro de que desea eliminar este automóvil?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  dbHelper.deleteCar(widget.car.id);
                                  if (mounted) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return HomePageClient(
                                              client: widget.client);
                                        },
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:proyectobd/admin/admin_login.dart';
import '../classes/car_class.dart';

class CardInfoCar extends StatefulWidget {
  final Car car;
  const CardInfoCar({required this.car, super.key});

  @override
  State<CardInfoCar> createState() => _CardInfoCarState();
}

class _CardInfoCarState extends State<CardInfoCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informacion de su Automovil'),
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
                'https://www.topgear.com/sites/default/files/cars-car/image/2020/09/a203794_medium.jpg',
                width: 150.0,
                height: 150.0,
              ),
              const SizedBox(height: 16.0),
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
                        'Kilometraje al Ingreso',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('${widget.car.kilometers}'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Text(
                        'Fecha ultimo servicio',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.car.lastService),
                    ],
                  ),
                ],
              ),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Respond to button press
                },
                child: const Text('Editar'),
              ),
              ElevatedButton(
                onPressed: () {
                  dbHelper.deleteCar(widget.car.id);
                },
                child: const Text('Eliminar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

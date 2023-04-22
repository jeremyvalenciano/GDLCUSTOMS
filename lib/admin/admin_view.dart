import 'package:flutter/material.dart';
import '../classes/employee_class.dart';
import '../classes/car_class.dart';
import '../database.dart';

final dbHelper = DatabaseHelper.instance;

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista Admin de Empleados PRUEBAA'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<Car>>(
          future: dbHelper.getCars(),
          builder: (BuildContext context, AsyncSnapshot<List<Car>> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Cargando...');
            }
            return snapshot.data!.isEmpty
                ? const Text(
                    'No hay cars registrados',
                    style: TextStyle(fontSize: 20),
                  )
                : ListView(
                    children: snapshot.data!.map(
                      (car) {
                        return ListTile(
                          title: Text('CLientId: ${car.clientId}'),
                          subtitle: Text(
                              'Modelo: ${car.model} - Servicio: ${car.lastService}'),
                          onLongPress: () {},
                        );
                      },
                    ).toList(),
                  );
          },
        ),
      ),
    );
  }
}

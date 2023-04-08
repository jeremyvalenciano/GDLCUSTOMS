import 'package:flutter/material.dart';
import '../classes/employee_class.dart';
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
        title: const Text('Vista Admin de Empleados'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<Employee>>(
          future: dbHelper.getEmployees(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Cargando...');
            }
            return snapshot.data!.isEmpty
                ? const Text(
                    'No hay empleados registrados',
                    style: TextStyle(fontSize: 20),
                  )
                : ListView(
                    children: snapshot.data!.map(
                      (employee) {
                        return ListTile(
                          title: Text('RFC: ${employee.rfc}'),
                          subtitle: Text(
                              'Nombre: ${employee.name} - Cel: ${employee.cellphone}'),
                          onLongPress: () {
                            setState(() {
                              dbHelper.deleteEmployee(employee.rfc);
                            });
                          },
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

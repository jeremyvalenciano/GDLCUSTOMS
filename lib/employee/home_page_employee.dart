import 'package:flutter/material.dart';
import 'package:proyectobd/classes/service_request_class.dart';
import 'package:proyectobd/components/card_actual_car.dart';
import 'package:proyectobd/components/card_request.dart';
import 'package:proyectobd/employee/edit_status.dart';
import 'package:proyectobd/employee/service_details.dart';
import 'package:proyectobd/home_page.dart';
import 'package:proyectobd/database.dart';
import 'package:proyectobd/classes/employee_class.dart';
import 'package:proyectobd/classes/car_class.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:proyectobd/employee/employee_profile_view.dart';

class HomePageEmployee extends StatefulWidget {
  final Employee employee;
  const HomePageEmployee({required this.employee, super.key});

  @override
  State<HomePageEmployee> createState() => _HomePageEmployeeState();
}

final dbHelper = DatabaseHelper.instance;

class _HomePageEmployeeState extends State<HomePageEmployee> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      Container(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<ServiceRequest>>(
          future: dbHelper.getRequests(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ServiceRequest>> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Cargando...');
            }
            return snapshot.data!.isEmpty
                ? const Text(
                    'Sin Solicitudes de servicio actualmente',
                    style: TextStyle(fontSize: 20),
                  )
                : ListView(
                    children: snapshot.data!.map(
                      (request) {
                        return CardRequest(
                          employee: widget.employee,
                          clientName: request.clientName,
                          brandCar: request.brandCar,
                          model: request.modelCar,
                          licencePlates: request.licencePlate,
                          date: request.date,
                          requestId: request.id,
                          employeeId: widget.employee.id,
                          onPressedDetails: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return ServiceDetails(
                                      clientId: request.clientId);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  );
          },
        ),
      ),
      Container(
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
                    'No hay Clientes registrados',
                    style: TextStyle(fontSize: 20),
                  )
                : ListView(
                    children: snapshot.data!.map(
                      (client) {
                        return CardActualCar(
                            clientName: 'Jeremy Valenciano',
                            licencePlates: 'JHL-6631',
                            model: 'Mazda MX-5',
                            year: '2020',
                            date: '04-05-2023',
                            status: 'Aceptado',
                            paid: 'No',
                            onPressedChangeStatus: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const EditStatus();
                                  },
                                ),
                              );
                            },
                            onPressedSeeDetails: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const ServiceDetails();
                                  },
                                ),
                              );
                            });
                      },
                    ).toList(),
                  );
          },
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Principal de empleado'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.employee.name),
              accountEmail: Text(widget.employee.email),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://static.vecteezy.com/system/resources/previews/006/877/514/original/work-character-solid-icon-illustration-office-workers-teachers-judges-police-artists-employees-free-vector.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return EmployeeProfileView(employee: widget.employee);
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesion'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Cerrar Sesión"),
                      content: const Text(
                          "¿Está seguro de que desea cerrar sesion?"),
                      actions: [
                        TextButton(
                          child: const Text("Cancelar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Cerrar Sesión"),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cases_rounded),
            label: 'Solicitudes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.engineering),
            label: 'Servicios Actuales',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

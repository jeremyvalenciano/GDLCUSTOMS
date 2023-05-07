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
  List<ServiceRequest>? _requests;
  List<ServiceRequest>? _workingRequests;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void updateRequests() async {
    List<ServiceRequest> requests = await dbHelper.getRequests();
    setState(() {
      _requests = requests;
    });
  }

  void updateWorkingRequests() async {
    List<ServiceRequest> requests =
        await dbHelper.getRequestsByEmployeeId(widget.employee.id!);
    setState(() {
      _workingRequests = requests;
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
                    'Sin Solicitudes de Servicio',
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
                          onUpdateRequestList: updateRequests,
                          onPressedDetails: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return ServiceDetails(
                                    clientId: request.clientId,
                                    requestId: request.id,
                                  );
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
        child: FutureBuilder<List<ServiceRequest>>(
          future: dbHelper.getRequestsByEmployeeId(widget.employee.id!),
          builder: (BuildContext context,
              AsyncSnapshot<List<ServiceRequest>> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Cargando...');
            }
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text(
                      'No se esta atendiendo ningun servicio',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView(
                    children: snapshot.data!.map(
                      (request) {
                        return CardActualCar(
                          requestId: request.id,
                          employeeId: widget.employee.id,
                          carId: request.carId,
                          clientId: request.clientId,
                          clientName: request.clientName,
                          licencePlates: request.licencePlate,
                          model: request.modelCar,
                          brand: request.brandCar,
                          date: request.date,
                          status: request.status,
                          paid: request.paid,
                          onUpdateRequestList: updateWorkingRequests,
                        );
                      },
                    ).toList(),
                  );
          },
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu de Empleado'),
        backgroundColor: Colors.blue[500],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
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
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.blue[300],
        onTap: _onItemTapped,
      ),
    );
  }
}

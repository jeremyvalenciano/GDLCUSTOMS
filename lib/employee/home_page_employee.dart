import 'package:flutter/material.dart';
import 'package:proyectobd/components/card_actual_car.dart';
import 'package:proyectobd/components/card_request.dart';
import 'package:proyectobd/employee/edit_status.dart';
import 'package:proyectobd/employee/service_details.dart';
import 'package:proyectobd/home_page.dart';
import 'package:proyectobd/database.dart';
import 'package:proyectobd/classes/employee_class.dart';
import 'package:proyectobd/classes/car_class.dart';
import 'package:proyectobd/classes/client_class.dart';

class HomePageEmployee extends StatefulWidget {
  const HomePageEmployee({super.key});

  @override
  State<HomePageEmployee> createState() => _HomePageEmployeeState();
}

final dbHelper = DatabaseHelper.instance;

class _HomePageEmployeeState extends State<HomePageEmployee> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    Container(
      padding: const EdgeInsets.all(20),
      child: FutureBuilder<List<Car>>(
        future: dbHelper.getCars(),
        builder: (BuildContext context, AsyncSnapshot<List<Car>> snapshot) {
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
                    (car) {
                      return CardRequest(
                        clientName: 'Jeremy',
                        model: car.model,
                        year: car.carYear,
                        date: car.lastService,
                        onPressedDetails: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const ServiceDetails();
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
      child: FutureBuilder<List<Client>>(
        future: dbHelper.getClients(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
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
                          clientName: 'Jeremy',
                          licencePlates: 'JER-123',
                          model: 'Kia Rio',
                          year: '2011',
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
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page Employee'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Admin'),
              accountEmail: Text('a'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.lansweeper.com/wp-content/uploads/2018/05/ASSET-USER-ADMIN.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const HomePage();
                    },
                  ),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuracion'),
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
        child: _widgetOptions.elementAt(_selectedIndex),
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

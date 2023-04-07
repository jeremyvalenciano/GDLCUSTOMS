import 'package:flutter/material.dart';
import 'package:proyectobd/employee_class.dart';
import 'package:proyectobd/client_class.dart';
import 'package:proyectobd/database.dart';
import 'package:proyectobd/admin/employee_profile.dart';

final dbHelper = DatabaseHelper.instance;

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
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
                  'No hay empleados registrados',
                  style: TextStyle(fontSize: 20),
                )
              : ListView(
                  children: snapshot.data!.map(
                    (employee) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg'),
                        ),
                        title: Text('Nombre: ${employee.name}'),
                        subtitle: Text('RFC: ${employee.rfc}'),
                        trailing: OutlinedButton(
                          onPressed: () {
                            debugPrint(employee.rfc);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return EmployeeProfile(employee: employee);
                                },
                              ),
                            );
                          },
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
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
              ? const Text('No hay Clientes')
              : ListView(
                  children: snapshot.data!.map(
                    (client) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg'),
                        ),
                        title: Text('Nombre: ${client.name}'),
                        subtitle: Text('Celular: ${client.cellphone}'),
                        trailing: OutlinedButton(
                          onPressed: () {
                            /*Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const EmployeeProfile();
                                },
                              ),
                            );*/
                          },
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
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
        title: const Text('Home Page Admin'),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text('Admin'),
              accountEmail: Text('a'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.lansweeper.com/wp-content/uploads/2018/05/ASSET-USER-ADMIN.png'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuracion'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesion'),
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
            icon: Icon(Icons.playlist_add_check_sharp),
            label: 'Empleados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Clientes',
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

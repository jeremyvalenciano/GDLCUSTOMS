import 'package:flutter/material.dart';
import 'package:proyectobd/admin/admin_profile.dart';
import 'package:proyectobd/classes/employee_class.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:proyectobd/classes/ticket_class.dart';
import 'package:proyectobd/components/ticket_info_view.dart';
import 'package:proyectobd/database.dart';
import 'package:proyectobd/admin/employee_profile.dart';
import 'package:proyectobd/admin/client_profile.dart';
import 'package:proyectobd/home_page.dart';

final dbHelper = DatabaseHelper.instance;

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

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
                            //debugPrint(employee.rfc);
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
              ? const Text(
                  'No hay Clientes registrados',
                  style: TextStyle(fontSize: 20),
                )
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
                            debugPrint(client.name);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return ClientProfile(client: client);
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
    Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<Ticket>>(
          future: dbHelper.getTickets(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Ticket>> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Cargando...');
            }
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text(
                      'No hay Tickets',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                : ListView(
                    children: snapshot.data!.map(
                      (ticket) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://static.vecteezy.com/system/resources/previews/002/205/928/non_2x/payment-invoice-icon-free-vector.jpg'),
                          ),
                          title: Text('Folio: ${ticket.id}0'),
                          subtitle: Text(
                              'Fecha: ${ticket.date} - Total: \$${ticket.total} '),
                          trailing: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return TicketInfoView(
                                      clientId: ticket.clientId!,
                                      requestId: ticket.requestId!,
                                    );
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
        title: const Text('Menu de Administrador'),
        backgroundColor: Colors.green.shade400,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Admin'),
              accountEmail: Text('a'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.lansweeper.com/wp-content/uploads/2018/05/ASSET-USER-ADMIN.png'),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const AdminProfile();
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
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Tickets',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green.shade800,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

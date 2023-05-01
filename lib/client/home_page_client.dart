import 'package:flutter/material.dart';
import 'package:proyectobd/components/card_info_car.dart';
import 'package:proyectobd/home_page.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:proyectobd/classes/car_class.dart';
import 'package:proyectobd/screens/add_one_car.dart' hide dbHelper;
import 'package:proyectobd/client/client_profile_view.dart';
import 'package:proyectobd/client/services_list_view.dart';

class HomePageClient extends StatefulWidget {
  final Client client;

  const HomePageClient({required this.client, super.key});

  @override
  State<HomePageClient> createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {
  List<Car> clientCars = [];
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    getCarsByClientId();
  }

  void getCarsByClientId() async {
    clientCars = await dbHelper.getCarsByClientId(widget.client.id);
  }

  @override
  Widget build(BuildContext context) {
    getCarsByClientId();
    final List<Widget> widgetOptions = <Widget>[
      //Scaffold de la lista de autos del cliente
      Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<Car>>(
            future: dbHelper.getCarsByClientId(widget.client.id),
            builder: (BuildContext context, AsyncSnapshot<List<Car>> snapshot) {
              if (!snapshot.hasData) {
                return const Text('Cargando...');
              }
              return snapshot.data!.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay Autos registrados',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  : ListView(
                      children: snapshot.data!.map(
                        (car) {
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://media.istockphoto.com/id/1144092062/vector/car-flat-icon.jpg?s=170667a&w=0&k=20&c=4arjMU0azqnuGOQ39s5la9BnuQGj3pWC4ZKeF9atKLw='),
                            ),
                            title: Text('Modelo: ${car.model}'),
                            subtitle: Text(
                                'Marca: ${car.brand} - Placas: ${car.licencePlate}'),
                            trailing: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return CardInfoCar(
                                          car: car, client: widget.client);
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddOneCar(client: widget.client);
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .endFloat, // Coloca el botón en la posición deseada
      ),
      //Scaffold de la lista de servicios del cliente

      ServicesListView(
        autos: clientCars,
        client: widget.client,
      ),
      const Text(
        'Index 2: School',
        style: optionStyle,
      ),
      const Text(
        'Index 4: ',
        style: optionStyle,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.client.name),
              accountEmail: Text(widget.client.email),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://static.vecteezy.com/system/resources/previews/005/544/718/original/profile-icon-design-free-vector.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ClientProfileView(client: widget.client);
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
            icon: Icon(Icons.car_repair),
            label: 'Autos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Tickets',
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

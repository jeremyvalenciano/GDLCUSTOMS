import 'package:flutter/material.dart';
import 'package:proyectobd/home_page.dart';
import 'package:proyectobd/classes/client_class.dart';

//gogle images search

class HomePageClient extends StatefulWidget {
  final Client client;
  const HomePageClient({required this.client, super.key});

  @override
  State<HomePageClient> createState() => _HomePageClientState();
}

class _HomePageClientState extends State<HomePageClient> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    Column(
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
              children: const <Widget>[
                Text(
                  'Modelo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Audi A4'),
              ],
            ),
            Column(
              children: const <Widget>[
                Text(
                  'Marca',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Audi'),
              ],
            ),
            Column(
              children: const <Widget>[
                Text(
                  'Año',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('2019'),
              ],
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Column(
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
                const Text('JSJ-1234'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: const <Widget>[
                        Text(
                          'KM Prox. Servicio',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('25,000'),
                      ],
                    ),
                    Column(
                      children: const <Widget>[
                        Text(
                          'Kilometraje Actual',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('10,000'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Respond to button press
              },
              child: const Text('Ver Historial'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Ver Servicios'),
            ),
          ],
        ),
      ],
    ),
    const Text(
      'Index 1: ss',
      style: optionStyle,
    ),
    const Text(
      'Index 2: School',
      style: optionStyle,
    ),
    const Text(
      'Index 4: ',
      style: optionStyle,
    ),
    const Text(
      'Index 4: a',
      style: optionStyle,
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
        title: const Text('Client Home'),
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
            icon: Icon(Icons.car_repair),
            label: 'Auto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pagos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
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

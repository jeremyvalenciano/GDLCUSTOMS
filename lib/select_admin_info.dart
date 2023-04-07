import 'package:flutter/material.dart';
import 'crud_cliente.dart';
import 'admin_view.dart';

class SelectAdminInfo extends StatefulWidget {
  const SelectAdminInfo({super.key});

  @override
  State<SelectAdminInfo> createState() => _SelectAdminInfoState();
}

class _SelectAdminInfoState extends State<SelectAdminInfo> {
  bool viewEmployees = false;
  bool viewClients = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Text(
                'GDL CUSTOMS',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 50),
              child: const Text(
                'Selecciona que datos \n     desea visualizar',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      viewEmployees = true;
                      viewClients = false;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: viewEmployees
                        ? MaterialStateProperty.all<Color>(Colors.blue)
                        : MaterialStateProperty.all<Color>(Colors.grey),
                    shape: viewEmployees
                        ? MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Colors.blue, width: 2),
                            ),
                          )
                        : MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Colors.grey, width: 2),
                            ),
                          ),
                  ),
                  child: const Text('Ver Clientes',
                      style: TextStyle(fontSize: 22)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      viewEmployees = false;
                      viewClients = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: viewClients
                        ? MaterialStateProperty.all<Color>(Colors.blue)
                        : MaterialStateProperty.all<Color>(Colors.grey),
                    shape: viewClients
                        ? MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Colors.blue, width: 2),
                            ),
                          )
                        : MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                  color: Colors.grey, width: 2),
                            ),
                          ),
                  ),
                  child: const Text('Ver Empleados',
                      style: TextStyle(fontSize: 22)),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 50),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      if (viewEmployees) {
                        return const CrudCliente();
                      }
                      return const AdminView();
                    },
                  ),
                );
              },
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}

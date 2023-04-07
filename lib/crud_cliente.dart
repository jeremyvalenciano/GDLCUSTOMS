import 'package:flutter/material.dart';
import 'database.dart';
import 'client_class.dart';

final dbHelper = DatabaseHelper.instance;

class CrudCliente extends StatefulWidget {
  const CrudCliente({super.key});

  @override
  State<CrudCliente> createState() => _CrudClienteState();
}

class _CrudClienteState extends State<CrudCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes GDL Customs'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<Client>>(
          future: dbHelper.getClients(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Cargando...');
            }
            return snapshot.data!.isEmpty
                ? const Text('No hay Clientes')
                : ListView(
                    children: snapshot.data!.map(
                      (client) {
                        return ListTile(
                          title: Text('Nombre: ${client.name}'),
                          subtitle: Text(
                              'Email: ${client.email} - Cel: ${client.cellphone}'),
                          onLongPress: () {
                            setState(() {
                              dbHelper.deleteClient(client.email);
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

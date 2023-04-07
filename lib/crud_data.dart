import 'package:flutter/material.dart';

import 'database.dart';
import 'admin_class.dart';

final dbHelper = DatabaseHelper.instance;

class CrudData extends StatefulWidget {
  const CrudData({super.key});

  @override
  State<CrudData> createState() => _CrudDataState();
}

class _CrudDataState extends State<CrudData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Data'),
      ),
      body: Center(
        child: FutureBuilder<List<Admin>>(
          future: dbHelper.getAdmins(),
          builder: (BuildContext context, AsyncSnapshot<List<Admin>> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Laoading...');
            }
            return snapshot.data!.isEmpty
                ? const Text('No hay admins')
                : ListView(
                    children: snapshot.data!.map(
                      (admin) {
                        return ListTile(
                          title: Text(admin.email),
                          subtitle: Text(admin.password),
                          onLongPress: () {
                            setState(() {
                              dbHelper.deleteAdmin(admin.email);
                            });
                          },
                        );
                      },
                    ).toList(),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await dbHelper.insertAdmin(Admin(
              email: 'LOL',
              password: '33333',
              name: 'admin',
              cellphone: '1234567890'));
          setState(() {});
        },
      ),
    );
  }
}

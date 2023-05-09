import 'package:flutter/material.dart';

import 'package:proyectobd/components/label_text.dart';
import 'package:proyectobd/components/simple_text.dart';


import 'package:proyectobd/database.dart';

final dbHelper = DatabaseHelper.instance;
Future admin = dbHelper.getAdminByEmail('admin@gmail.com');

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title:
            const Text('PERFIL CLIENTE', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.9,
          color: Colors.black,
          padding:
              const EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Divider(
                color: Colors.white,
                thickness: 0.3,
                indent: 50,
                endIndent: 50,
              ),
              LabelText(text: "NOMBRE"),
              SimpleText(text: 'Administrador'),
              LabelText(text: "CORREO"),
              LabelText(text: "admin@gmail.com"),
              LabelText(text: "TELEFONO"),
              SimpleText(text: '33-13-58-22-87'),
              SizedBox(height: 20),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

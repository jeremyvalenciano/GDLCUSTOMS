import 'package:flutter/material.dart';
import 'package:proyectobd/admin/home_page_admin.dart';
import 'package:proyectobd/components/label_text.dart';
import 'package:proyectobd/components/simple_text.dart';
import 'package:proyectobd/components/rounded_button.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:proyectobd/database.dart';

final dbHelper = DatabaseHelper.instance;

class ClientProfile extends StatefulWidget {
  final Client client;
  const ClientProfile({required this.client, super.key});

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
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
          color: Colors.black,
          padding:
              const EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.white,
                thickness: 0.3,
                indent: 50,
                endIndent: 50,
              ),
              const LabelText(text: "NOMBRE"),
              SimpleText(text: widget.client.name),
              const LabelText(text: "CORREO"),
              SimpleText(text: widget.client.email),
              const LabelText(text: "TELEFONO"),
              SimpleText(text: widget.client.cellphone),
              const LabelText(text: "CIUDAD"),
              SimpleText(text: widget.client.city),
              const LabelText(text: "DIRECCION"),
              SimpleText(text: widget.client.address),
              const LabelText(text: "FECHA DE NACIMIENTO"),
              SimpleText(text: widget.client.birthday),
              const LabelText(text: "EDAD"),
              SimpleText(text: widget.client.age.toString()),
              const LabelText(text: "GENERO"),
              SimpleText(text: widget.client.genre),
              const SizedBox(height: 20),
              Center(
                child: RoundedButton(
                  text: "Editar",
                  textColor: Colors.white,
                  btnColor: Colors.blue,
                  fontSize: 18,
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: RoundedButton(
                  text: "Eliminar",
                  textColor: Colors.white,
                  btnColor: Colors.red,
                  fontSize: 18,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Eliminar cliente"),
                          content: const Text(
                              "¿Está seguro de que desea eliminar este cliente?"),
                          actions: [
                            TextButton(
                              child: const Text("Cancelar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text("Eliminar"),
                              onPressed: () {
                                dbHelper.deleteClient(widget.client.email);
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomePageAdmin()),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

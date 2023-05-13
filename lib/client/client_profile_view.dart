import 'package:flutter/material.dart';
import 'package:proyectobd/client/edit_client_profile.dart';
import 'package:proyectobd/components/label_text.dart';
import 'package:proyectobd/components/simple_text.dart';
import 'package:proyectobd/components/rounded_button.dart';
import 'package:proyectobd/classes/client_class.dart';
import 'package:proyectobd/database.dart';

final dbHelper = DatabaseHelper.instance;

class ClientProfileView extends StatefulWidget {
  final Client client;
  const ClientProfileView({required this.client, super.key});

  @override
  State<ClientProfileView> createState() => _ClientProfileViewState();
}

class _ClientProfileViewState extends State<ClientProfileView> {
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
          height: MediaQuery.of(context).size.height * 0.9,
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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return EditClientprofile(client: widget.client);
                        },
                      ),
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

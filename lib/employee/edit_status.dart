import 'package:flutter/material.dart';
import 'package:proyectobd/components/rounded_button.dart';

class EditStatus extends StatefulWidget {
  const EditStatus({super.key});

  @override
  State<EditStatus> createState() => _EditStatusState();
}

class _EditStatusState extends State<EditStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Editar estado del servicio'),
        backgroundColor: Colors.yellow[600],
        shadowColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 30, left: 15),
              decoration: BoxDecoration(
                color: Colors.yellow[600],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(
                      25.0), // Radio de la esquina inferior izquierda
                  bottomRight: Radius.circular(
                      25.0), // Radio de la esquina inferior derecha
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.drive_eta_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: const Text('Id del servicio: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const Text('123456789'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, left: 15),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Información Personal',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Text('Nombre: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('Juan Perez'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Celular: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('3326207135'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Correo electronico: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('juan@gmail.com'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Descripcion: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('Lavado y puldio de carro'),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                    indent: 8,
                    endIndent: 8,
                  ),
                  Text('Costos del Servicio',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 25, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Encerado'),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'Precio: '),
                              TextSpan(
                                text: '\$100',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 25, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pulido'),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'Precio: '),
                              TextSpan(
                                text: '\$100',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.8,
                    indent: 8,
                    endIndent: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 25, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'Precio: '),
                              TextSpan(
                                text: '\$100',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: RoundedButton(
                        text: 'Contactar',
                        textColor: Colors.black,
                        btnColor: Colors.yellow,
                        fontSize: 24,
                        onPressed: () {}),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

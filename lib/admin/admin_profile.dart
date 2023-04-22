import 'package:flutter/material.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Imagen de perfil centrada
            SizedBox(
              height: 200,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    'https://www.w3schools.com/howto/img_avatar.png'),
              ),
            ),

            // Nombre de usuario centrado
            SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  'Nombre de Usuario',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Fila para correo electrónico
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 24,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Correo electrónico:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'usuario@example.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Fila para celular
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 24,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Celular:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '555-555-5555',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

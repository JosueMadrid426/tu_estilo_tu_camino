import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';

class UserFormScreen extends StatelessWidget {
  final UserController userController =
      Get.find(); // Obtiene la instancia del controlador
  final User?
      user; // Se usa '?' para permitir nulos si no se pasa ningún usuario (para crear uno nuevo)

  // Controladores de texto para los campos de nombre y correo
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Constructor que recibe un usuario existente o null si se va a agregar uno nuevo
  UserFormScreen(this.user, {super.key}) {
    if (user != null) {
      // Si se está editando, inicializa los campos de texto con los valores actuales del usuario
      nameController.text = user!.nombre;
      emailController.text = user!.correo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user == null
            ? 'Agregar Usuario'
            : 'Editar Usuario'), // Cambia el título según si se está agregando o editando
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ), // TextField para el nombre
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Correo',
              ),
            ), // TextField para el correo
            const SizedBox(height: 20), // Espacio entre campos y el botón
            ElevatedButton(
              onPressed: () {
                // Comprueba si estamos agregando o actualizando un usuario
                if (user == null) {
                  // Si no hay usuario, crea uno nuevo
                  User newUser = User(
                    id: 0, // Asumimos que el backend asigna el ID automáticamente
                    nombre: nameController.text,
                    correo: emailController.text,
                  );
                  userController.addUser(
                      newUser); // Llama al método para agregar el usuario
                } else {
                  // Si ya hay un usuario, lo actualiza
                  user!.nombre = nameController.text;
                  user!.correo = emailController.text;
                  userController.updateUser(
                      user!); // Llama al método para actualizar el usuario
                }
                Get.back(); // Vuelve a la pantalla anterior después de agregar o actualizar
              },
              child: Text(user == null
                  ? 'Agregar'
                  : 'Actualizar'), // Cambia el texto del botón según la acción
            ), // ElevatedButton
          ],
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../controllers/user_controller.dart';
import 'user_form_screen.dart';

// Pantalla para listar a todos los usuarios
class HomeScreen extends StatelessWidget {
  final UserController userController =
      Get.put(UserController()); // Inicializa el controlador

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Usuarios'),
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          // Si está cargando, muestra un indicador de progreso
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: userController.userList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(userController.userList[index].nombre),
                subtitle: Text(userController.userList[index].correo),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Al presionar el ícono de borrar, elimina el usuario
                    userController
                        .deleteUser(userController.userList[index].id);
                  },
                ),
                onTap: () {
                  // Al presionar un usuario, abre la pantalla de edición
                  Get.to(() => UserFormScreen(userController.userList[index]));
                },
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Al presionar el botón flotante, abre la pantalla para agregar un nuevo usuario
          Get.to(
              () => UserFormScreen(null)); // null para agregar un nuevo usuario
        },
      ),
    );
  }
}
*/
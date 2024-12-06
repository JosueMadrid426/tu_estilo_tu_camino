import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Modelo3DViewer extends StatefulWidget {
  final String modelPath;
  final String? mtlPath;

  const Modelo3DViewer({Key? key, required this.modelPath, this.mtlPath})
      : super(key: key);

  @override
  _Modelo3DViewerState createState() => _Modelo3DViewerState();
}

class _Modelo3DViewerState extends State<Modelo3DViewer> {
  late Object object3D;
  final ValueNotifier<Color> selectedColor = ValueNotifier<Color>(Colors.white);
  final ValueNotifier<String?> selectedTexture = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modelo 3D"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          Center(
            child: Cube(
              onSceneCreated: (Scene scene) {
                object3D = Object(fileName: widget.modelPath);
                if (widget.mtlPath != null) {
                  object3D.mtl = widget.mtlPath;
                }
                scene.world.add(object3D);
                scene.camera.zoom = 5;

                // Actualizar el color dinámicamente
                selectedColor.addListener(() {
                  object3D.updateMaterial(
                    ambient: _toVector4(selectedColor.value),
                    diffuse: _toVector4(selectedColor.value),
                  );
                });

                // Actualizar la textura dinámicamente
                selectedTexture.addListener(() {
                  object3D.texture = selectedTexture.value;
                });
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _showColorPalette(context),
                    child: const Text("Seleccionar Color"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: () => _showTextureSelection(context),
                    child: const Text("Seleccionar Textura"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: _buttonStyle(),
                    onPressed: _showPaymentConfirmation,
                    child: const Text("Pago"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPalette(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Selecciona un Color",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: List.generate(12, (index) {
                    return GestureDetector(
                      onTap: () {
                        selectedColor.value = _getColor(index);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _getColor(index),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTextureSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final textures = [
          'assets/textures/texture1.jpg',
          'assets/textures/texture2.jpg',
          'assets/textures/texture3.jpg',
        ];

        return Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Selecciona una Textura",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: textures.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedTexture.value = textures[index];
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(textures[index]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmación de Compra"),
          content: const Text("¡Compra realizada con éxito!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  Color _getColor(int index) {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      Colors.amber,
      Colors.teal,
      Colors.indigo,
      Colors.yellow,
      Colors.brown,
      Colors.pink
    ];
    return colors[index];
  }

  Vector4 _toVector4(Color color) {
    return Vector4(
      color.red / 255.0,
      color.green / 255.0,
      color.blue / 255.0,
      1.0,
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 254, 253, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}

extension on Object {
  void updateMaterial({required Vector4 ambient, required Vector4 diffuse}) {
    for (final material in materials) {
      material.ambient = ambient;
      material.diffuse = diffuse;
    }
  }

  set texture(String? path) {
    if (path != null) {
      for (final material in materials) {
        material.texture = path;
      }
    }
  }
}

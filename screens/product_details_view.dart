import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductDetailsView extends StatefulWidget {
  final String nombre;
  final String precio;
  final String imagen;
  final String? descripcion;

  const ProductDetailsView({
    required this.nombre,
    required this.precio,
    required this.imagen,
    this.descripcion,
    Key? key,
  }) : super(key: key);

  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nombre),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Acción para navegar al carrito de compras
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(widget.imagen),
            const SizedBox(height: 20),
            _buildText(widget.nombre, fontSize: 26, fontWeight: FontWeight.bold),
            const SizedBox(height: 10),
            _buildText(
              '\$${widget.precio}',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            _buildText(
              widget.descripcion ??
                  'Descripción del producto. Puedes detallar las características del producto, materiales, cuidados, etc.',
              fontSize: 16,
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Personalización'),
            const SizedBox(height: 10),
            _buildCustomizationSection(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _addToCart,
                child: const Text('Agregar al carrito'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 30),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.nombre} agregado al carrito!'),
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCustomizationSection() {
    return InkWell(
      onTap: _pickImage,
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
          image: _selectedImage == null
              ? const DecorationImage(
            image: AssetImage('assets/tshirt_placeholder.png'),
            fit: BoxFit.contain,
          )
              : null,
        ),
        child: _selectedImage != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.file(
            _selectedImage!,
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        )
            : const Center(
          child: Text(
            'Toca para subir una imagen',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text,
      {double fontSize = 16,
        FontWeight fontWeight = FontWeight.normal,
        Color? color}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

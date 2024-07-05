import 'package:flutter/material.dart';
import 'package:flutter_restaurante_1/pantalla_inicio.dart';
import 'package:flutter_restaurante_1/pantallacarrito.dart';
import 'package:flutter_restaurante_1/carrito/carrito.dart';
import 'package:flutter_restaurante_1/segunda_pantalla.dart'; // Asegúrate de importar la ruta correcta para MenuScreen si está en una ubicación diferente
import 'package:provider/provider.dart';
import 'package:flutter_restaurante_1/nosotros.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => Carrito()), // Proveedor de Carrito
      ],
      child: MaterialApp(
        title: 'La Mamita',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug
        initialRoute: '/pantalla_inicio', // Ruta inicial
        routes: {
          '/pantalla_inicio': (context) =>
              const PantallaInicio(), // Ruta para PantallaInicio
          '/menu': (context) => const MenuScreen(), // Ruta para MenuScreen
          '/segunda_pantalla': (context) =>
              const MenuScreen(), // Ruta para MenuScreen (puedes ajustar esto según sea necesario)
          '/pantallacarrito': (context) =>
              const PantallaCarrito(), // Ruta para PantallaCarrito
          '/': (context) =>
              const MenuScreen(), // Ruta predeterminada, dirigida a MenuScreen
          '/nosotros': (context) => const NosotrosScreen(),
        },
      ),
    );
  }
}

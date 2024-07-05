import 'package:flutter/material.dart';
import 'package:flutter_restaurante_1/pantalla_inicio.dart';
import 'package:flutter_restaurante_1/pantallacarrito.dart';
import 'package:flutter_restaurante_1/carrito/carrito.dart';
import 'package:flutter_restaurante_1/segunda_pantalla.dart';
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
        ChangeNotifierProvider(create: (_) => Carrito()),
      ],
      child: MaterialApp(
        title: 'La Mamita',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/pantalla_inicio',
        routes: {
          '/pantalla_inicio': (context) => const PantallaInicio(),
          '/menu': (context) => const MenuScreen(),
          '/segunda_pantalla': (context) => const MenuScreen(),
          '/pantallacarrito': (context) => const PantallaCarrito(),
          '/': (context) => const MenuScreen(),
          '/nosotros': (context) => const NosotrosScreen(),
        },
      ),
    );
  }
}

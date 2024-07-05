import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurante_1/carrito/carrito.dart';

class PantallaCarrito extends StatelessWidget {
  const PantallaCarrito({super.key});

  Future<void> _enviarPedidoPorWhatsApp(
      BuildContext context, Carrito carrito) async {
    String numeroDeTelefono = '50557245824';
    String detallesDelCarrito = await _obtenerDetallesDelCarrito(carrito);
    String mensaje =
        'Hola, he realizado un pedido con los siguientes detalles:\n\n$detallesDelCarrito';
    String encodedMessage = Uri.encodeComponent(mensaje);

    Uri uri = Uri.parse('https://wa.me/$numeroDeTelefono?text=$encodedMessage');

    try {
      // Check if the URL can be launched
      if (await canLaunchUrl(uri)) {
        // Launch the URL using an external application
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Mensaje enviado por WhatsApp'),
          ));
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('No se pudo abrir WhatsApp. Verifique si está instalado.'),
          ));
        }
        if (kDebugMode) {
          print('No se pudo abrir WhatsApp. Verifique si está instalado.');
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al enviar por WhatsApp: $e'),
          ),
        );
      }
      if (kDebugMode) {
        print('Error al enviar por WhatsApp: $e');
      }
    }
  }

  Future<String> _obtenerDetallesDelCarrito(Carrito carrito) async {
    String detalles = '';
    for (var item in carrito.items.values) {
      detalles +=
          '${item.nombre} - Cantidad: ${item.cantidad} - Total: C\$${(item.precio * item.cantidad).toStringAsFixed(2)}\n';
    }
    return detalles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
        backgroundColor: const Color.fromARGB(255, 127, 148, 103),
        actions: [
          Consumer<Carrito>(
            builder: (context, carrito, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                  if (carrito.numeroItems > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 0, 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        child: Text(
                          '${carrito.numeroItems}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<Carrito>(
          builder: (context, carrito, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Center(
                  child: Text(
                    'Detalles del Carrito',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: carrito.items.length,
                    itemBuilder: (context, index) {
                      final item = carrito.items.values.toList()[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                item.imagen,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.nombre,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          color: Colors.red,
                                          onPressed: () {
                                            carrito
                                                .decrementarCantidad(item.id);
                                          },
                                        ),
                                        Text(
                                          'Cantidad: ${item.cantidad}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          color: Colors.green,
                                          onPressed: () {
                                            carrito
                                                .incrementarCantidad(item.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'C\$${(item.precio * item.cantidad).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'C\$${carrito.subTotal.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Impuesto (15%):',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'C\$${carrito.impuesto.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'C\$${carrito.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Enviar Pedido'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('¿Desea enviar el pedido por WhatsApp?'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Enviar'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await _enviarPedidoPorWhatsApp(
                                      context, carrito);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 105, 114, 50),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 14),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Finalizar Compra'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}

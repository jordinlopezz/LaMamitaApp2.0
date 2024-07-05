import 'package:flutter/material.dart';

class NosotrosScreen extends StatelessWidget {
  const NosotrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nosotros'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Nicaragua Restaurant Image
            Image.asset(
              'assets/img/nicaragua_restaurant.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),

            // Vision Section
            const Text(
              'Visión',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Ser el restaurante líder en la promoción de la gastronomía nicaragüense, '
              'ofreciendo experiencias culinarias auténticas y memorables.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // Mision Section
            const Text(
              'Misión',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Promover y preservar la cultura gastronómica de Nicaragua, '
              'a través de la preparación y comercialización de platillos típicos '
              'con ingredientes frescos y de calidad, satisfaciendo así los gustos '
              'y preferencias de nuestros clientes.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),

            // Contact information
            const Text(
              'Contacto',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            // Contact details with images
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/img/phone_icon.png', // Ruta de la imagen del teléfono
                  height: 24,
                  width: 24,
                  color: Colors.blue, // Color opcional para la imagen
                ),
                const SizedBox(width: 8.0),
                const Expanded(
                  child: Text(
                    '+505 1234 5678',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/img/email_icon.png', // Ruta de la imagen del correo electrónico
                  height: 24,
                  width: 24,
                  color: Colors.red, // Color opcional para la imagen
                ),
                const SizedBox(width: 8.0),
                const Expanded(
                  child: Text(
                    'info@restaurante-nicaraguense.com',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/img/location_icon.png', // Ruta de la imagen de ubicación
                  height: 24,
                  width: 24,
                  color: Colors.green, // Color opcional para la imagen
                ),
                const SizedBox(width: 8.0),
                const Expanded(
                  child: Text(
                    'Dirección: Avenida Principal, Managua, Nicaragua',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Social media icons
            const Text(
              'Síguenos en redes sociales:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // se implementara la acción al presionar Facebook
                  },
                  child: Image.asset(
                    'assets/img/facebook_logo.png', // Ruta de la imagen de Facebook
                    height: 48,
                    width: 48,
                    color: Colors.blue, // Color opcional para la imagen
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Implementa la acción al presionar Instagram
                  },
                  child: Image.asset(
                    'assets/img/instagram_logo.png', // Ruta de la imagen de Instagram
                    height: 48,
                    width: 48,
                    color: Colors.pink, // Color opcional para la imagen
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Implementa la acción al presionar Twitter
                  },
                  child: Image.asset(
                    'assets/img/twitter_logo.png', // Ruta de la imagen de Twitter
                    height: 48,
                    width: 48,
                    color: Colors.lightBlue, // Color opcional para la imagen
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

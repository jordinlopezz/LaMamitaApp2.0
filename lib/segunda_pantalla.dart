import 'package:flutter/material.dart';
import 'package:flutter_restaurante_1/carrito/carrito.dart';
import 'package:flutter_restaurante_1/model/carta.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double drawerWidth = MediaQuery.of(context).size.width * 0.75;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('La Mamita'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Comidas'),
              Tab(text: 'Bebidas'),
              Tab(text: 'Postres'),
            ],
          ),
          actions: [
            Consumer<Carrito>(
              builder: (context, carrito, child) {
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.pushNamed(context, '/pantallacarrito');
                      },
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
                            '${carrito.totalItems}',
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
        drawer: Drawer(
          elevation: 0,
          child: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: drawerWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(47, 66, 44, 1),
                        image: DecorationImage(
                          image: AssetImage("assets/background.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'La Mamita',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                    ),
                    const UserAccountsDrawerHeader(
                      accountName: Text('Jordin Lopez'),
                      accountEmail: Text('jordinalexanderlopezperez@gmail.com'),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/img/profile_image.png'),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(43, 60, 40, 1),
                      ),
                      margin: EdgeInsets.zero,
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Inicio'),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/pantalla_inicio');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.restaurant_menu),
                      title: const Text('Menú'),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/segunda_pantalla');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: const Text('Carrito'),
                      onTap: () {
                        Navigator.pushNamed(context, '/pantallacarrito');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('Nosotros'),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/nosotros');
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Cerrar sesión'),
                      onTap: () {
                        // Manejar la opción de cerrar sesión
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: <Widget>[
              _buildGridView(context, comidas),
              _buildGridView(context, bebidas),
              _buildGridView(context, postres),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(
    BuildContext context,
    List<Carta> lista,
  ) {
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: lista.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        final item = lista[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: Image.asset(
                    item.imagen,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.descripcion,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'C\$${item.precio.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        final carrito =
                            Provider.of<Carrito>(context, listen: false);
                        carrito.agregarItem(
                          item.id.toString(),
                          item.nombre,
                          item.precio,
                          '',
                          item.imagen,
                          1,
                        );
                        ScaffoldMessenger.of(context)
                            .removeCurrentSnackBar(); // Remover Snackbar actual si existe
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Añadido al carrito'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      child: const Text(
                        'Añadir al carrito',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

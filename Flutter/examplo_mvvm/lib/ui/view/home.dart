import 'package:examplo_mvvm/ui/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Bienvenido a la página de inicio'),
      ),
      drawer: context.watch<AuthViewModel>().currentUser != null
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('Menú'),
                  ),
                  ListTile(
                    title: const Text('Cerrar sesión'),
                    onTap: () {
                      context.read<AuthViewModel>().logout();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                ],
              ),
            )
          : null,
      bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.api_rounded),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/listPosts');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.outbox_rounded),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ],
              ),
            )
          
    );
  }
}
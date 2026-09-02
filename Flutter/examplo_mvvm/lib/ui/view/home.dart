import 'package:examplo_mvvm/ui/view/homeContent.dart';
import 'package:examplo_mvvm/ui/view/pedido_list_view.dart';
import 'package:examplo_mvvm/ui/view/post_list_view.dart';
import 'package:examplo_mvvm/ui/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectIndex = 0;

  List<Widget> _pages = [
    const HomeContent(), //0
    const PostListView(), //1
    const PedidoListView(), //2
    //mas de páginas que quieras agregar
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('MI APLICACION ITBM'),),
      body: IndexedStack(
        index: _selectIndex,
        children: _pages,
      ),
      /*drawer: context.watch<AuthViewModel>().currentUser != null
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
          : null,*/

      bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      setState(() {
                        _selectIndex = 0;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.api_rounded),
                    onPressed: () {
                     setState(() {
                        _selectIndex = 1;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.outbox_rounded),
                    onPressed: () {
                      setState(() {
                        _selectIndex = 2;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      //Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ],
              ),
            )
          
    );
  }
}
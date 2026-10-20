import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/chat_viewmodel.dart';
import 'auth/login_view.dart';
import 'chat_detail_view.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final user = context.read<AuthViewModel>().usuario;
      if (user != null) {
        context.read<ChatViewModel>().cargarChats(user.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    final chatVM = context.watch<ChatViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authVM.logout();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginView()),
                );
              }
            },
          ),
        ],
      ),
      body: chatVM.cargandoChats
          ? const Center(child: CircularProgressIndicator())
          : chatVM.chats.isEmpty
              ? const Center(child: Text('No tienes chats activos'))
              : ListView.builder(
                  itemCount: chatVM.chats.length,
                  itemBuilder: (context, index) {
                    final item = chatVM.chats[index];
                    final chatData = item['chats'] as Map<String, dynamic>;
                    final String chatId = chatData['id'];
                    final bool esGrupo = chatData['es_grupo'] ?? false;
                    final String nombre = esGrupo
                        ? (chatData['nombre_grupo'] ?? 'Grupo')
                        : 'Chat (${chatId.substring(0, 5)})';

                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(esGrupo ? Icons.group : Icons.person),
                      ),
                      title: Text(nombre),
                      subtitle: const Text('Toca para abrir la conversación'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatDetailView(
                              chatId: chatId,
                              nombreChat: nombre,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/chat_viewmodel.dart';

class ChatDetailView extends StatefulWidget {
  final String chatId;
  final String nombreChat;

  const ChatDetailView({
    super.key,
    required this.chatId,
    required this.nombreChat,
  });

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final _mensajeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ChatViewModel>().escucharMensajes(widget.chatId);
    });
  }

  void _enviar() {
    final miId = context.read<AuthViewModel>().usuario?.id;
    if (miId == null) return;

    context.read<ChatViewModel>().enviarMensaje(
          chatId: widget.chatId,
          usuarioId: miId,
          contenido: _mensajeController.text,
        );
    _mensajeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final chatVM = context.watch<ChatViewModel>();
    final miId = context.watch<AuthViewModel>().usuario?.id;

    return Scaffold(
      appBar: AppBar(title: Text(widget.nombreChat)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: chatVM.mensajes.length,
              itemBuilder: (context, index) {
                final mensaje = chatVM.mensajes[index];
                final esMio = mensaje.usuarioId == miId;
                final hora = DateFormat('HH:mm').format(mensaje.creadoEn);

                return Align(
                  alignment: esMio ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: esMio ? Colors.teal.shade200 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(mensaje.contenido),
                        const SizedBox(height: 2),
                        Text(hora, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _mensajeController,
                      decoration: const InputDecoration(
                        hintText: 'Escribe un mensaje...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _enviar(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  chatVM.enviando
                      ? const CircularProgressIndicator()
                      : IconButton(
                          icon: const Icon(Icons.send, color: Colors.teal),
                          onPressed: _enviar,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mensajeController.dispose();
    super.dispose();
  }
}
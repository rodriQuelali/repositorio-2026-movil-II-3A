import 'dart:async';
import 'package:flutter/material.dart';
import '../models/mensaje_model.dart';
import '../repositories/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatRepository _repository = ChatRepository();
  StreamSubscription<List<MensajeModel>>? _subscription;

  List<MensajeModel> _mensajes = [];
  List<MensajeModel> get mensajes => _mensajes;

  List<Map<String, dynamic>> _chats = [];
  List<Map<String, dynamic>> get chats => _chats;

  bool _cargandoChats = false;
  bool get cargandoChats => _cargandoChats;

  bool _enviando = false;
  bool get enviando => _enviando;

  Future<void> cargarChats(String usuarioId) async {
    _cargandoChats = true;
    notifyListeners();
    try {
      _chats = await _repository.getChatsDelUsuario(usuarioId);
    } catch (_) {
      _chats = [];
    } finally {
      _cargandoChats = false;
      notifyListeners();
    }
  }

  void escucharMensajes(String chatId) {
    _subscription?.cancel();
    _subscription = _repository.streamMensajes(chatId).listen((nuevos) {
      _mensajes = nuevos;
      notifyListeners();
    });
  }

  Future<void> enviarMensaje({
    required String chatId,
    required String usuarioId,
    required String contenido,
  }) async {
    if (contenido.trim().isEmpty) return;
    _enviando = true;
    notifyListeners();
    try {
      await _repository.enviarMensaje(
        chatId: chatId,
        usuarioId: usuarioId,
        contenido: contenido.trim(),
      );
    } finally {
      _enviando = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
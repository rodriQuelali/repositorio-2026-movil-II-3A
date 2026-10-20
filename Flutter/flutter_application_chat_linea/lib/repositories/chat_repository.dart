import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase/supabase_client.dart';
import '../models/mensaje_model.dart';

class ChatRepository {
  final SupabaseClient _client = SupabaseService.client;

  /// Stream en tiempo real: cada vez que hay cambios en mensajes
  Stream<List<MensajeModel>> streamMensajes(String chatId) {
    return _client
        .from('mensajes')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('creado_en')
        .map((rows) => rows.map((row) => MensajeModel.fromMap(row)).toList());
  }

  /// Envía un mensaje nuevo (INSERT)
  Future<void> enviarMensaje({
    required String chatId,
    required String usuarioId,
    required String contenido,
  }) async {
    await _client.from('mensajes').insert({
      'chat_id': chatId,
      'usuario_id': usuarioId,
      'contenido': contenido,
    });
  }

  /// Carga la lista de chats asignados al usuario
  Future<List<Map<String, dynamic>>> getChatsDelUsuario(String usuarioId) async {
    final response = await _client
        .from('chat_participantes')
        .select('chat_id, chats(id, es_grupo, nombre_grupo)')
        .eq('usuario_id', usuarioId);

    return List<Map<String, dynamic>>.from(response);
  }
}
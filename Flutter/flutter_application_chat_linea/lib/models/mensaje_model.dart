class MensajeModel {
  final String id;
  final String chatId;
  final String usuarioId;
  final String contenido;
  final DateTime creadoEn;
  final bool leido;

  MensajeModel({
    required this.id,
    required this.chatId,
    required this.usuarioId,
    required this.contenido,
    required this.creadoEn,
    required this.leido,
  });

  factory MensajeModel.fromMap(Map<String, dynamic> map) {
    return MensajeModel(
      id: map['id'] as String,
      chatId: map['chat_id'] as String,
      usuarioId: map['usuario_id'] as String,
      contenido: map['contenido'] as String,
      creadoEn: DateTime.parse(map['creado_en'] as String),
      leido: map['leido'] as bool? ?? false,
    );
  }
}
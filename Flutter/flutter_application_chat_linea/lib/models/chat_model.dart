class ChatModel {
  final String id;
  final bool esGrupo;
  final String? nombreGrupo;

  ChatModel({
    required this.id,
    required this.esGrupo,
    this.nombreGrupo,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as String,
      esGrupo: map['es_grupo'] as bool? ?? false,
      nombreGrupo: map['nombre_grupo'] as String?,
    );
  }
}
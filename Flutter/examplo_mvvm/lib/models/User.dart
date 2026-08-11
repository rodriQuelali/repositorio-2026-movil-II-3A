class UserModel {
  final int? id;
  final String nombre;
  final String apellido;
  final String correo;
  final String contrasena;
  final DateTime fechaNacimiento;

  UserModel({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.contrasena,
    required this.fechaNacimiento,
  });

  //lista de usuarios List<UserModel> userList = [];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'contrasena': contrasena,
      'fecha_nacimiento': fechaNacimiento.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      apellido: map['apellido'] as String,
      correo: map['correo'] as String,
      contrasena: map['contrasena'] as String,
      fechaNacimiento: DateTime.parse(map['fecha_nacimiento'] as String),
    );
  }

  UserModel copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? correo,
    String? contrasena,
    DateTime? fechaNacimiento,
  }) {
    return UserModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      correo: correo ?? this.correo,
      contrasena: contrasena ?? this.contrasena,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
    );
  }
}
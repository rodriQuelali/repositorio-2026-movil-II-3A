import '../core/database/database_helper.dart';
import '../core/utils/password_hasher.dart';
import '../models/User.dart';

class AuthRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // REGISTRO
  Future<UserModel> registerUser(UserModel user) async {
    final db = await _dbHelper.database;

    // Hasheamos la contraseña antes de guardar
    final userToSave = user.copyWith(
      contrasena: PasswordHasher.hash(user.contrasena),
    );

    final id = await db.insert(
      DatabaseHelper.tableName,
      userToSave.toMap()..remove('id'),
    );

    return userToSave.copyWith(id: id);
  }

  // LOGIN
  Future<UserModel?> login(String correo, String contrasena) async {
    final db = await _dbHelper.database;
    final hashedPass = PasswordHasher.hash(contrasena);

    final maps = await db.query(
      DatabaseHelper.tableName,
      where: 'correo = ? AND contrasena = ?',
      whereArgs: [correo, hashedPass],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null; // Credenciales incorrectas
  }
}
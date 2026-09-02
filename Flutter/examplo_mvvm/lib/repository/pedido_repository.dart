import '../core/database/database_helper.dart';
import '../models/pedido_model.dart';

class PedidoRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // CREATE
  Future<PedidoModel> createPedido(PedidoModel pedido) async {
    final db = await _dbHelper.database;
    final id = await db.insert(
      DatabaseHelper.tablePedidos,
      pedido.toMap()..remove('id'),
    );
    return pedido.copyWith(id: id);
  }

  // READ — todos, más recientes primero
  Future<List<PedidoModel>> getPedidos() async {
    final db = await _dbHelper.database;
    final maps = await db.query(DatabaseHelper.tablePedidos, orderBy: 'id DESC');
    return maps.map((map) => PedidoModel.fromMap(map)).toList();
  }

  // READ — por id
  Future<PedidoModel?> getPedidoById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      DatabaseHelper.tablePedidos,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return PedidoModel.fromMap(maps.first);
  }

  // UPDATE
  Future<int> updatePedido(PedidoModel pedido) async {
    final db = await _dbHelper.database;
    return await db.update(
      DatabaseHelper.tablePedidos,
      pedido.toMap(),
      where: 'id = ?',
      whereArgs: [pedido.id],
    );
  }

  // DELETE
  Future<int> deletePedido(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      DatabaseHelper.tablePedidos,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
enum EstadoPedido { pendiente, enProceso, entregado }

extension EstadoPedidoExt on EstadoPedido {
  String get label {
    switch (this) {
      case EstadoPedido.pendiente:
        return 'Pendiente';
      case EstadoPedido.enProceso:
        return 'En proceso';
      case EstadoPedido.entregado:
        return 'Entregado';
    }
  }
}

class PedidoModel {
  final int? id;
  final String cliente;
  final String producto;
  final int cantidad;
  final double precio;
  final String descripcion;
  final DateTime fechaPedido;
  final EstadoPedido estado;
  final String? fotoPath; // ruta local de la imagen tomada con la cámara
  final double? latitud;  // campo independiente de ubicación
  final double? longitud; // campo independiente de ubicación

  PedidoModel({
    this.id,
    required this.cliente,
    required this.producto,
    required this.cantidad,
    required this.precio,
    this.descripcion = '',
    required this.fechaPedido,
    this.estado = EstadoPedido.pendiente,
    this.fotoPath,
    this.latitud,
    this.longitud,
  });

  double get total => cantidad * precio;

  /// true solo si AMBAS coordenadas están presentes
  bool get tieneUbicacion => latitud != null && longitud != null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': cliente,
      'producto': producto,
      'cantidad': cantidad,
      'precio': precio,
      'descripcion': descripcion,
      'fecha_pedido': fechaPedido.toIso8601String(),
      'estado': estado.index,
      'foto_path': fotoPath,
      'latitud': latitud,
      'longitud': longitud,
    };
  }

  factory PedidoModel.fromMap(Map<String, dynamic> map) {
    return PedidoModel(
      id: map['id'] as int?,
      cliente: map['cliente'] as String,
      producto: map['producto'] as String,
      cantidad: map['cantidad'] as int,
      precio: (map['precio'] as num).toDouble(),
      descripcion: map['descripcion'] as String? ?? '',
      fechaPedido: DateTime.parse(map['fecha_pedido'] as String),
      estado: EstadoPedido.values[map['estado'] as int],
      fotoPath: map['foto_path'] as String?,
      latitud: (map['latitud'] as num?)?.toDouble(),
      longitud: (map['longitud'] as num?)?.toDouble(),
    );
  }

  PedidoModel copyWith({
    int? id,
    String? cliente,
    String? producto,
    int? cantidad,
    double? precio,
    String? descripcion,
    DateTime? fechaPedido,
    EstadoPedido? estado,
    String? fotoPath,
    double? latitud,
    double? longitud,
  }) {
    return PedidoModel(
      id: id ?? this.id,
      cliente: cliente ?? this.cliente,
      producto: producto ?? this.producto,
      cantidad: cantidad ?? this.cantidad,
      precio: precio ?? this.precio,
      descripcion: descripcion ?? this.descripcion,
      fechaPedido: fechaPedido ?? this.fechaPedido,
      estado: estado ?? this.estado,
      fotoPath: fotoPath ?? this.fotoPath,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
    );
  }
}
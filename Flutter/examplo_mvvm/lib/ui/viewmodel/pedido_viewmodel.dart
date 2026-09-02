import 'package:examplo_mvvm/core/services/camera_service.dart';
import 'package:examplo_mvvm/core/services/location_service.dart';
import 'package:examplo_mvvm/models/pedido_model.dart';
import 'package:examplo_mvvm/repository/pedido_repository.dart';
import 'package:flutter/material.dart';



enum ViewState { idle, loading, error }

class PedidoViewModel extends ChangeNotifier {
  final PedidoRepository _repository = PedidoRepository();
  final CameraService _cameraService = CameraService();
  final LocationService _locationService = LocationService();

  List<PedidoModel> _pedidos = [];
  List<PedidoModel> get pedidos => _pedidos;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Foto tomada temporalmente mientras se llena el formulario
  String? _fotoTemporal;
  String? get fotoTemporal => _fotoTemporal;

  // Ubicación capturada temporalmente mientras se llena el formulario
  double? _latitudTemporal;
  double? get latitudTemporal => _latitudTemporal;

  double? _longitudTemporal;
  double? get longitudTemporal => _longitudTemporal;

  bool _obteniendoUbicacion = false;
  bool get obteniendoUbicacion => _obteniendoUbicacion;

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchPedidos() async {
    _setState(ViewState.loading);
    try {
      _pedidos = await _repository.getPedidos();
      _setState(ViewState.idle);
    } catch (e) {
      _errorMessage = 'Error al cargar pedidos: $e';
      _setState(ViewState.error);
    }
  }

  /// Abre la cámara y guarda la ruta en memoria hasta que se
  /// confirme el guardado del pedido.
  Future<void> tomarFoto() async {
    try {
      final path = await _cameraService.takePhoto();
      if (path != null) {
        _fotoTemporal = path;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'No se pudo acceder a la cámara: $e';
      notifyListeners();
    }
  }

  void limpiarFotoTemporal() {
    _fotoTemporal = null;
    notifyListeners();
  }

  /// Precarga la foto temporal cuando se abre el form para EDITAR
  /// un pedido que ya tenía una foto guardada.
  void cargarFotoExistente(String? path) {
    _fotoTemporal = path;
  }

  /// Precarga las coordenadas cuando se abre el form para EDITAR
  /// un pedido que ya tenía ubicación guardada.
  void cargarUbicacionExistente(double? lat, double? lng) {
    _latitudTemporal = lat;
    _longitudTemporal = lng;
  }

  /// Captura la ubicación GPS actual y la deja lista para
  /// guardarse junto con el pedido.
  Future<void> capturarUbicacion() async {
    _obteniendoUbicacion = true;
    notifyListeners();
    try {
      final position = await _locationService.getCurrentLocation();
      _latitudTemporal = position.latitude;
      _longitudTemporal = position.longitude;
    } on LocationServiceDisabledException {
      _errorMessage = 'El GPS está desactivado. Actívalo e intenta de nuevo.';
    } on LocationPermissionDeniedException {
      _errorMessage = 'Permiso de ubicación denegado.';
    } catch (e) {
      _errorMessage = 'No se pudo obtener la ubicación: $e';
    } finally {
      _obteniendoUbicacion = false;
      notifyListeners();
    }
  }

  void limpiarUbicacionTemporal() {
    _latitudTemporal = null;
    _longitudTemporal = null;
    notifyListeners();
  }

  Future<bool> addPedido(PedidoModel pedido) async {
    try {
      final nuevo = await _repository.createPedido(
        pedido.copyWith(
          fotoPath: _fotoTemporal,
          latitud: _latitudTemporal,
          longitud: _longitudTemporal,
        ),
      );
      _pedidos.insert(0, nuevo);
      _fotoTemporal = null;
      _latitudTemporal = null;
      _longitudTemporal = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al registrar el pedido: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> editPedido(PedidoModel pedido) async {
    try {
      final actualizado = pedido.copyWith(
        fotoPath: _fotoTemporal,
        latitud: _latitudTemporal,
        longitud: _longitudTemporal,
      );
      await _repository.updatePedido(actualizado);
      final index = _pedidos.indexWhere((p) => p.id == actualizado.id);
      if (index != -1) {
        _pedidos[index] = actualizado;
        notifyListeners();
      }
      _fotoTemporal = null;
      _latitudTemporal = null;
      _longitudTemporal = null;
      return true;
    } catch (e) {
      _errorMessage = 'Error al actualizar el pedido: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> removePedido(int id, String? fotoPath) async {
    try {
      await _repository.deletePedido(id);
      await _cameraService.deletePhoto(fotoPath);
      _pedidos.removeWhere((p) => p.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Error al eliminar el pedido: $e';
      notifyListeners();
      return false;
    }
  }
}
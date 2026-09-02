import 'package:geolocator/geolocator.dart';

class LocationPermissionDeniedException implements Exception {}
class LocationServiceDisabledException implements Exception {}

class LocationService {
  /// Obtiene la posición GPS actual (latitud, longitud).
  /// Lanza excepciones específicas si el GPS está apagado
  /// o si el usuario negó el permiso.
  Future<Position> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedException();
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
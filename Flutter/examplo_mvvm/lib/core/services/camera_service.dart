import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  /// Abre la cámara, toma la foto y la copia a la carpeta
  /// permanente de la app. Devuelve la ruta final del archivo,
  /// o null si el usuario canceló.
  Future<String?> takePhoto() async {
    final XFile? capturedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75, // comprime un poco para no ocupar tanto espacio
    );

    if (capturedFile == null) return null;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'pedido_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await File(capturedFile.path).copy('${appDir.path}/$fileName');

    return savedImage.path;
  }

  /// Elimina el archivo de foto del almacenamiento (por ejemplo,
  /// al borrar un pedido o al reemplazar la foto).
  Future<void> deletePhoto(String? path) async {
    if (path == null) return;
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
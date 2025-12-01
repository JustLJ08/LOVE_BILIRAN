import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  final ImagePicker _picker = ImagePicker();

  Future<({XFile? file, Uint8List? webBytes, File? mobileFile})?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    if (kIsWeb) {
      final bytes = await image.readAsBytes();
      return (file: image, webBytes: bytes, mobileFile: null);
    } else {
      return (file: image, webBytes: null, mobileFile: File(image.path));
    }
  }
}
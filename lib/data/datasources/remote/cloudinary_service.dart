import 'dart:io';
import 'dart:typed_data';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import '../../../core/error/exceptions.dart';

abstract class CloudinaryService {
  Future<String> uploadImage(File? file, Uint8List? webBytes);
}

class CloudinaryServiceImpl implements CloudinaryService {
  final CloudinaryPublic cloudinary;

  CloudinaryServiceImpl({required this.cloudinary});

  @override
  Future<String> uploadImage(File? file, Uint8List? webBytes) async {
    try {
      CloudinaryResponse response;
      if (kIsWeb && webBytes != null) {
        response = await cloudinary.uploadFile(
          CloudinaryFile.fromByteData(
            ByteData.view(webBytes.buffer),
            identifier: 'biliran_${DateTime.now().millisecondsSinceEpoch}',
            folder: 'love_biliran',
          ),
        );
      } else if (file != null) {
        response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            file.path,
            resourceType: CloudinaryResourceType.Image,
            folder: 'love_biliran',
          ),
        );
      } else {
        throw ServerException("No image data provided");
      }
      return response.secureUrl;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
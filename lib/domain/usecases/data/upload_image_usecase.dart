import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/data_repository.dart';

class UploadImageUseCase implements UseCase<String, UploadImageParams> {
  final DataRepository repository;

  UploadImageUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return repository.uploadImage(params.mobileFile, params.webBytes);
  }
}

class UploadImageParams extends Equatable {
  final File? mobileFile;
  final Uint8List? webBytes;

  const UploadImageParams({this.mobileFile, this.webBytes});

  @override
  List<Object?> get props => [mobileFile, webBytes];
}
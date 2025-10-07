import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/contact_info.dart';
import '../repositories/contact_repository.dart';

class GetContactDetails {
  final ContactRepository repository;

  GetContactDetails(this.repository);

  Future<Either<Failure, ContactInfo>> call(String id) async {
    return await repository.getContactDetails(id);
  }
}

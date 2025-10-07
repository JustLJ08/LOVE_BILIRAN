import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/contact_info.dart';
import '../repositories/contact_repository.dart';

class GetAllContacts {
  final ContactRepository repository;

  GetAllContacts(this.repository);

  Future<Either<Failure, List<ContactInfo>>> call() async {
    return await repository.getAllContacts();
  }
}

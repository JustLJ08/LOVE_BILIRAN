import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/contact_info.dart';
import '../repositories/contact_repository.dart';

class AddContact {
  final ContactRepository repository;

  AddContact(this.repository);

  Future<Either<Failure, void>> call(ContactInfo contact) async {
    return await repository.addContact(contact);
  }
}

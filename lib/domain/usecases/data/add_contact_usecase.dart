import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/contact.dart';
import '../../repositories/data_repository.dart';

class AddContactUseCase implements UseCase<void, Contact> {
  final DataRepository repository;

  AddContactUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Contact contact) {
    return repository.addContact(contact);
  }
}
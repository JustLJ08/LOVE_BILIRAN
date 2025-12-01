import '../../entities/contact.dart';
import '../../repositories/data_repository.dart';

class GetContactsUseCase {
  final DataRepository repository;

  GetContactsUseCase(this.repository);

  Stream<List<Contact>> call() {
    return repository.getContacts();
  }
}
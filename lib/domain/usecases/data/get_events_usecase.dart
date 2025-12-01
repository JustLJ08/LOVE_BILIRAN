import '../../entities/event.dart';
import '../../repositories/data_repository.dart';

class GetEventsUseCase {
  final DataRepository repository;

  GetEventsUseCase(this.repository);

  Stream<List<LocalEvent>> call() {
    return repository.getEvents();
  }
}
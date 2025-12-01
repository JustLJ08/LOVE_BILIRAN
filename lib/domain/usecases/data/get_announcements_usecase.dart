import '../../entities/announcement.dart';
import '../../repositories/data_repository.dart';

class GetAnnouncementsUseCase {
  final DataRepository repository;

  GetAnnouncementsUseCase(this.repository);

  Stream<List<Announcement>> call() {
    return repository.getAnnouncements();
  }
}
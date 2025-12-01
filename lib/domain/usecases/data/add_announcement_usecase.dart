import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/announcement.dart';
import '../../repositories/data_repository.dart';

class AddAnnouncementUseCase implements UseCase<void, Announcement> {
  final DataRepository repository;

  AddAnnouncementUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Announcement announcement) {
    return repository.addAnnouncement(announcement);
  }
}
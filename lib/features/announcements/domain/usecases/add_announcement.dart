import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/announcement.dart';
import '../repositories/announcement_repository.dart';

class AddAnnouncement {
  final AnnouncementRepository repository;

  AddAnnouncement(this.repository);

  Future<Either<Failure, void>> call(Announcement announcement) async {
    return await repository.addAnnouncement(announcement);
  }
}

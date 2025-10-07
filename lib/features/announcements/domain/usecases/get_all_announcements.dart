import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/announcement.dart';
import '../repositories/announcement_repository.dart';

class GetAllAnnouncements {
  final AnnouncementRepository repository;

  GetAllAnnouncements(this.repository);

  Future<Either<Failure, List<Announcement>>> call() async {
    return await repository.getAllAnnouncements();
  }
}

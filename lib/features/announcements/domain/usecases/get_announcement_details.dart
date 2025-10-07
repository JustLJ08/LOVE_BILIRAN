import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/announcement.dart';
import '../repositories/announcement_repository.dart';

class GetAnnouncementDetails {
  final AnnouncementRepository repository;

  GetAnnouncementDetails(this.repository);

  Future<Either<Failure, Announcement>> call(String id) async {
    return await repository.getAnnouncementDetails(id);
  }
}

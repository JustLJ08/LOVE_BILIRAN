import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/announcement.dart';

abstract class AnnouncementRepository {
  Future<Either<Failure, List<Announcement>>> getAllAnnouncements();
  Future<Either<Failure, Announcement>> getAnnouncementDetails(String id);
  Future<Either<Failure, void>> addAnnouncement(Announcement announcement);
  Future<Either<Failure, void>> updateAnnouncement(Announcement announcement);
}

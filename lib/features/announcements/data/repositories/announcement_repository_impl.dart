import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/announcement.dart';
import '../../domain/repositories/announcement_repository.dart';
import '../datasources/announcement_remote_data_source.dart';

// Implementation of the AnnouncementRepository interface
// This class acts as a bridge between the domain layer and the data source layer
class AnnouncementRepositoryImpl implements AnnouncementRepository {
  // Reference to the remote data source responsible for Firestore communication
  final AnnouncementRemoteDataSource remoteDataSource;

  // Constructor requiring a remote data source instance
  AnnouncementRepositoryImpl({required this.remoteDataSource});

  // ---------------------- GET ALL ANNOUNCEMENTS ----------------------
  @override
  Future<Either<Failure, List<Announcement>>> getAllAnnouncements() async {
    try {
      // Attempt to fetch all announcements from the remote data source
      final list = await remoteDataSource.getAllAnnouncements();

      // Return the successful result wrapped in a Right (indicating success)
      return Right(list);
    } catch (e) {
      // If any exception occurs, wrap it in a Left containing a ServerFailure
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- GET ANNOUNCEMENT DETAILS BY ID ----------------------
  @override
  Future<Either<Failure, Announcement>> getAnnouncementDetails(String id) async {
    try {
      // Fetch a single announcement using its unique ID
      final item = await remoteDataSource.getAnnouncementById(id);

      // Return the successful announcement wrapped in Right
      return Right(item);
    } catch (e) {
      // Return a failure if any error occurs during fetching
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- ADD NEW ANNOUNCEMENT ----------------------
  @override
  Future<Either<Failure, Announcement>> addAnnouncement(Announcement announcement) async {
    try {
      // Call the data source method to add a new announcement
      // The cast to 'dynamic' allows it to accept the entity as a model
      final model = await remoteDataSource.addAnnouncement(announcement as dynamic);

      // Return the created announcement wrapped in Right
      return Right(model);
    } catch (e) {
      // Handle any exception and return it as a failure
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- UPDATE EXISTING ANNOUNCEMENT ----------------------
  @override
  Future<Either<Failure, Announcement>> updateAnnouncement(Announcement announcement) async {
    try {
      // Call the data source method to update the announcement
      final model = await remoteDataSource.updateAnnouncement(announcement as dynamic);

      // Return the updated announcement wrapped in Right
      return Right(model);
    } catch (e) {
      // Catch errors and return them as a ServerFailure
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- DELETE ANNOUNCEMENT ----------------------
  Future<Either<Failure, Unit>> deleteAnnouncement(String id) async {
    try {
      // Call the data source to delete the announcement by its ID
      await remoteDataSource.deleteAnnouncement(id);

      // Return a success (unit means "no meaningful value", similar to void)
      return const Right(unit);
    } catch (e) {
      // Return a ServerFailure if deletion fails
      return Left(ServerFailure(e.toString()));
    }
  }
}

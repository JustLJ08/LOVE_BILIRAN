import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/tourist_spot.dart';
import '../../domain/repositories/tourist_spot_repository.dart';
import '../datasources/tourist_spot_remote_data_source.dart';
import '../models/tourist_spot_model.dart';

// Implementation of the TouristSpotRepository interface
// This class acts as a bridge between the domain layer and the data layer.
// It handles errors and converts data between entity and model formats.
class TouristSpotRepositoryImpl implements TouristSpotRepository {
  final TouristSpotRemoteDataSource remoteDataSource;

  // Constructor that requires a remote data source (e.g., Firestore)
  TouristSpotRepositoryImpl(this.remoteDataSource);

  // Adds a new tourist spot by converting the entity into a model
  // and passing it to the remote data source. Handles possible errors.
  @override
  Future<Either<Failure, void>> addTouristSpot(TouristSpot touristSpot) async {
    try {
      final model = TouristSpotModel(
        id: touristSpot.id,
        name: touristSpot.name,
        description: touristSpot.description,
        imageUrls: touristSpot.imageUrls,
        locationLink: touristSpot.locationLink,
      );
      await remoteDataSource.addTouristSpot(model);
      return const Right(null); // Returns success result
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Returns failure if an error occurs
    }
  }

  // Retrieves all tourist spots from the remote data source
  // and returns them as a list of entities.
  @override
  Future<Either<Failure, List<TouristSpot>>> getAllTouristSpots() async {
    try {
      final spots = await remoteDataSource.getAllTouristSpots();
      return Right(spots);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Fetches details of a specific tourist spot using its ID.
  // Returns either the tourist spot data or a failure.
  @override
  Future<Either<Failure, TouristSpot>> getTouristSpotDetails(String id) async {
    try {
      final spot = await remoteDataSource.getTouristSpotDetails(id);
      return Right(spot);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Updates an existing tourist spot by converting the entity into a model
  // and calling the remote data source's update function.
  @override
  Future<Either<Failure, void>> updateTouristSpot(TouristSpot touristSpot) async {
    try {
      final model = TouristSpotModel(
        id: touristSpot.id,
        name: touristSpot.name,
        description: touristSpot.description,
        imageUrls: touristSpot.imageUrls,
        locationLink: touristSpot.locationLink,
      );
      await remoteDataSource.updateTouristSpot(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

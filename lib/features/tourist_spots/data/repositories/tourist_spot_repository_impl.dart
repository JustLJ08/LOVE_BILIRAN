import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/tourist_spot.dart';
import '../../domain/repositories/tourist_spot_repository.dart';
import '../datasources/tourist_spot_remote_data_source.dart';
import '../models/tourist_spot_model.dart';

class TouristSpotRepositoryImpl implements TouristSpotRepository {
  final TouristSpotRemoteDataSource remoteDataSource;

  TouristSpotRepositoryImpl(this.remoteDataSource);

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
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TouristSpot>>> getAllTouristSpots() async {
    try {
      final spots = await remoteDataSource.getAllTouristSpots();
      return Right(spots);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TouristSpot>> getTouristSpotDetails(String id) async {
    try {
      final spot = await remoteDataSource.getTouristSpotDetails(id);
      return Right(spot);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

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

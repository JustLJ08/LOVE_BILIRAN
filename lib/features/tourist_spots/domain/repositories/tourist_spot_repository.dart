import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/tourist_spot.dart';

abstract class TouristSpotRepository {
  Future<Either<Failure, List<TouristSpot>>> getAllTouristSpots();
  Future<Either<Failure, TouristSpot>> getTouristSpotDetails(String id);
  Future<Either<Failure, void>> addTouristSpot(TouristSpot spot);
  Future<Either<Failure, void>> updateTouristSpot(TouristSpot spot);
}

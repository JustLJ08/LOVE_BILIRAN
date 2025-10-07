import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/tourist_spot.dart';
import '../repositories/tourist_spot_repository.dart';

class GetAllTouristSpots {
  final TouristSpotRepository repository;

  GetAllTouristSpots(this.repository);

  Future<Either<Failure, List<TouristSpot>>> call() async {
    return await repository.getAllTouristSpots();
  }
}

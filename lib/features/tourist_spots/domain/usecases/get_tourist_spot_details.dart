import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/tourist_spot.dart';
import '../repositories/tourist_spot_repository.dart';

class GetTouristSpotDetails {
  final TouristSpotRepository repository;

  GetTouristSpotDetails(this.repository);

  Future<Either<Failure, TouristSpot>> call(String id) async {
    return await repository.getTouristSpotDetails(id);
  }
}

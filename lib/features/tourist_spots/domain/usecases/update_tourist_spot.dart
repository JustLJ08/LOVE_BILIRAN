import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/tourist_spot.dart';
import '../repositories/tourist_spot_repository.dart';

class UpdateTouristSpot {
  final TouristSpotRepository repository;

  UpdateTouristSpot(this.repository);

  Future<Either<Failure, void>> call(TouristSpot spot) async {
    return await repository.updateTouristSpot(spot);
  }
}

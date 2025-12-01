  import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/tourist_spot.dart';
import '../../repositories/data_repository.dart';

class AddSpotUseCase implements UseCase<void, TouristSpot> {
  final DataRepository repository;

  AddSpotUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(TouristSpot spot) {
    return repository.addSpot(spot);
  }
}
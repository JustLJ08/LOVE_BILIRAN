import '../../entities/tourist_spot.dart';
import '../../repositories/data_repository.dart';

class GetSpotsUseCase {
  final DataRepository repository;

  GetSpotsUseCase(this.repository);

  Stream<List<TouristSpot>> call() {
    return repository.getSpots();
  }
}
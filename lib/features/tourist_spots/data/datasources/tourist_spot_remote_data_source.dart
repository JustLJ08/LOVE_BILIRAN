import '../models/tourist_spot_model.dart';

abstract class TouristSpotRemoteDataSource {
  Future<void> addTouristSpot(TouristSpotModel touristSpot);
  Future<List<TouristSpotModel>> getAllTouristSpots();
  Future<TouristSpotModel> getTouristSpotDetails(String id);
  Future<void> updateTouristSpot(TouristSpotModel touristSpot);
}

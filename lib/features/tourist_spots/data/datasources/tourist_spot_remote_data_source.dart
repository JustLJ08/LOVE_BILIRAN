import '../models/tourist_spot_model.dart';

// This abstract class defines the contract (or blueprint)
// for interacting with tourist spot data stored in a remote database (like Firestore).
abstract class TouristSpotRemoteDataSource {

  // Adds a new tourist spot record to the remote data source.
  Future<void> addTouristSpot(TouristSpotModel touristSpot);

  // Retrieves all tourist spots from the remote database.
  // It returns a list of TouristSpotModel objects
  // representing all tourist spots currently stored.
  Future<List<TouristSpotModel>> getAllTouristSpots();

  // Fetches detailed information about a specific tourist spot,
  // using its unique document ID from the remote data source.
  // The returned TouristSpotModel contains all data about that spot.
  Future<TouristSpotModel> getTouristSpotDetails(String id);

  // Updates an existing tourist spot record in the remote database.
  // The method expects a TouristSpotModel object that includes an ID,
  // which is used to find and update the corresponding document.
  Future<void> updateTouristSpot(TouristSpotModel touristSpot);
}

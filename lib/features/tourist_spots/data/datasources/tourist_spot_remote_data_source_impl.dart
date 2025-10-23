import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tourist_spot_model.dart';
import 'tourist_spot_remote_data_source.dart';

// This class is responsible for handling all remote (cloud) data operations
// related to tourist spots using Google Cloud Firestore.
// It implements the TouristSpotRemoteDataSource interface, ensuring
// it provides all required methods for CRUD operations.
class TouristSpotRemoteDataSourceImpl implements TouristSpotRemoteDataSource {
  final FirebaseFirestore firestore;

  // The constructor accepts an instance of FirebaseFirestore,
  // allowing this class to communicate with the Firestore database.
  // This makes the class easier to test and more flexible.
  TouristSpotRemoteDataSourceImpl(this.firestore);

  // Adds a new tourist spot document to the 'tourist_spots' collection in Firestore.
  // The touristSpot object is converted into a Map using toMap(),
  // since Firestore requires data in key-value format for storage.
  @override
  Future<void> addTouristSpot(TouristSpotModel touristSpot) async {
    await firestore.collection('tourist_spots').add(touristSpot.toMap());
  }

  // Retrieves all tourist spots from the Firestore collection.
  // The .get() method fetches all documents in the collection.
  // Each document snapshot is then converted from a Map to a TouristSpotModel
  // using the fromMap() factory constructor.
  @override
  Future<List<TouristSpotModel>> getAllTouristSpots() async {
    final snapshot = await firestore.collection('tourist_spots').get();

    // snapshot.docs returns a list of QueryDocumentSnapshot objects.
    // Each document is mapped into a TouristSpotModel.
    return snapshot.docs
        .map((doc) => TouristSpotModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  // Retrieves the details of a specific tourist spot using its document ID.
  // The .doc(id).get() method fetches the Firestore document by ID.
  // Then the retrieved document data is passed into fromMap() to create a model object.
  @override
  Future<TouristSpotModel> getTouristSpotDetails(String id) async {
    final doc = await firestore.collection('tourist_spots').doc(id).get();

    // doc.data()! returns the map of data stored in the document.
    // The doc.id provides the Firestore document's unique identifier.
    return TouristSpotModel.fromMap(doc.data()!, doc.id);
  }

  // Updates an existing tourist spot document in Firestore.
  // The document is identified by touristSpot.id.
  // The update() method only updates fields specified in the provided map,
  // leaving other fields unchanged.
  @override
  Future<void> updateTouristSpot(TouristSpotModel touristSpot) async {
    await firestore
        .collection('tourist_spots')
        .doc(touristSpot.id)
        .update(touristSpot.toMap());
  }
}

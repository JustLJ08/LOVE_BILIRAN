import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tourist_spot_model.dart';
import 'tourist_spot_remote_data_source.dart';

class TouristSpotRemoteDataSourceImpl implements TouristSpotRemoteDataSource {
  final FirebaseFirestore firestore;

  TouristSpotRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addTouristSpot(TouristSpotModel touristSpot) async {
    await firestore.collection('tourist_spots').add(touristSpot.toMap());
  }

  @override
  Future<List<TouristSpotModel>> getAllTouristSpots() async {
    final snapshot = await firestore.collection('tourist_spots').get();
    return snapshot.docs
        .map((doc) => TouristSpotModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<TouristSpotModel> getTouristSpotDetails(String id) async {
    final doc = await firestore.collection('tourist_spots').doc(id).get();
    return TouristSpotModel.fromMap(doc.data()!, doc.id);
  }

  @override
  Future<void> updateTouristSpot(TouristSpotModel touristSpot) async {
    await firestore
        .collection('tourist_spots')
        .doc(touristSpot.id)
        .update(touristSpot.toMap());
  }
}

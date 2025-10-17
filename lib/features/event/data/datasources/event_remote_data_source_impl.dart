import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';
import 'event_remote_data_source.dart';

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final FirebaseFirestore firestore;

  EventRemoteDataSourceImpl({required this.firestore});

  CollectionReference get _col => firestore.collection('events');

  @override
  Future<List<EventModel>> getAllEvents() async {
    final snap = await _col.orderBy('date', descending: false).get();
    return snap.docs.map((d) => EventModel.fromMap(d.data() as Map<String, dynamic>, d.id)).toList();
  }

  @override
  Future<EventModel> getEventById(String id) async {
    final doc = await _col.doc(id).get();
    return EventModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  Future<EventModel> addEvent(EventModel event) async {
    final docRef = await _col.add(event.toMap());
    final doc = await docRef.get();
    return EventModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  Future<EventModel> updateEvent(EventModel event) async {
    await _col.doc(event.id).update(event.toMap());
    final doc = await _col.doc(event.id).get();
    return EventModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  Future<void> deleteEvent(String id) async {
    await _col.doc(id).delete();
  }
}
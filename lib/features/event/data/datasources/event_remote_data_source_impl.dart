import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';
import 'event_remote_data_source.dart';

// Implementation class for EventRemoteDataSource
// Handles all Firestore operations related to events.
class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  // Firestore instance for accessing the database.
  final FirebaseFirestore firestore;

  // Constructor requires a Firestore instance to be injected.
  EventRemoteDataSourceImpl({required this.firestore});

  // Shortcut getter to access the 'events' collection in Firestore.
  CollectionReference get _col => firestore.collection('events');

  // ---------------------- FETCH ALL EVENTS ----------------------
  @override
  Future<List<EventModel>> getAllEvents() async {
    // Fetches all documents from 'events', ordered by 'date' in ascending order.
    final snap = await _col.orderBy('date', descending: false).get();

    // Maps each document snapshot into an EventModel instance.
    return snap.docs.map((d) => EventModel.fromMap(d.data() as Map<String, dynamic>, d.id)).toList();
  }

  // ---------------------- FETCH EVENT BY ID ----------------------
  @override
  Future<EventModel> getEventById(String id) async {
    // Fetches a single event document using its ID.
    final doc = await _col.doc(id).get();

    // Converts the document data into an EventModel object.
    return EventModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ---------------------- ADD NEW EVENT ----------------------
  @override
  Future<EventModel> addEvent(EventModel event) async {
    // Adds a new event document to the 'events' collection.
    final docRef = await _col.add(event.toMap());

    // Retrieves the added document to get its full data (including the auto-generated ID).
    final doc = await docRef.get();

    // Converts the document snapshot into an EventModel instance and returns it.
    return EventModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ---------------------- UPDATE EXISTING EVENT ----------------------
  @override
  Future<EventModel> updateEvent(EventModel event) async {
    // Updates the event document using its ID and new data.
    await _col.doc(event.id).update(event.toMap());

    // Retrieves the updated document to get the latest data.
    final doc = await _col.doc(event.id).get();

    // Converts the updated data into an EventModel and returns it.
    return EventModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ---------------------- DELETE EVENT ----------------------
  @override
  Future<void> deleteEvent(String id) async {
    // Deletes the event document with the specified ID from Firestore.
    await _col.doc(id).delete();
  }
}

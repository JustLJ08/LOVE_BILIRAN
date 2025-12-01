import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/announcement_model.dart';
import '../../models/contact_model.dart';
import '../../models/event_model.dart';
import '../../models/tourist_spot_model.dart';

abstract class FirestoreService {
  Stream<List<TouristSpotModel>> getSpots();
  Stream<List<EventModel>> getEvents();
  Stream<List<AnnouncementModel>> getAnnouncements();
  Stream<List<ContactModel>> getContacts();
  Future<void> addSpot(TouristSpotModel spot);
  Future<void> addEvent(EventModel event);
  Future<void> addAnnouncement(AnnouncementModel announcement);
  Future<void> addContact(ContactModel contact);
}

class FirestoreServiceImpl implements FirestoreService {
  final FirebaseFirestore firestore;

  FirestoreServiceImpl({required this.firestore});

  @override
  Stream<List<TouristSpotModel>> getSpots() {
    return firestore.collection('spots').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TouristSpotModel.fromFirestore(doc)).toList();
    });
  }

  @override
  Stream<List<EventModel>> getEvents() {
    return firestore.collection('events').orderBy('date').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList();
    });
  }

  @override
  Stream<List<AnnouncementModel>> getAnnouncements() {
    return firestore
        .collection('announcements')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => AnnouncementModel.fromFirestore(doc)).toList();
    });
  }

  @override
  Stream<List<ContactModel>> getContacts() {
    return firestore.collection('contacts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ContactModel.fromFirestore(doc)).toList();
    });
  }

  @override
  Future<void> addSpot(TouristSpotModel spot) async {
    await firestore.collection('spots').add(spot.toFirestore());
  }

  @override
  Future<void> addEvent(EventModel event) async {
    await firestore.collection('events').add(event.toFirestore());
  }

  @override
  Future<void> addAnnouncement(AnnouncementModel announcement) async {
    await firestore.collection('announcements').add(announcement.toFirestore());
  }

  @override
  Future<void> addContact(ContactModel contact) async {
    await firestore.collection('contacts').add(contact.toFirestore());
  }
}
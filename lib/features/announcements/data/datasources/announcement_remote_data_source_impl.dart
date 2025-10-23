import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/announcement_model.dart';
import 'announcement_remote_data_source.dart';

// This class implements the AnnouncementRemoteDataSource interface
// It handles all CRUD operations (Create, Read, Update, Delete) for announcements in Firestore
class AnnouncementRemoteDataSourceImpl implements AnnouncementRemoteDataSource {
  // A Firestore instance is required to perform database operations
  final FirebaseFirestore firestore;

  // Constructor that requires a Firestore instance to be passed in
  AnnouncementRemoteDataSourceImpl({required this.firestore});

  // A private getter that returns a reference to the 'announcements' collection in Firestore
  CollectionReference get _col => firestore.collection('announcements');

  // ---------------------- READ ALL ANNOUNCEMENTS ----------------------
  @override
  Future<List<AnnouncementModel>> getAllAnnouncements() async {
    // Fetch all documents from the 'announcements' collection, ordered by 'createdAt' in descending order
    final snap = await _col.orderBy('createdAt', descending: true).get();

    // Map each document snapshot to an AnnouncementModel and return as a list
    return snap.docs.map((d) => AnnouncementModel.fromMap(d.data() as Map<String, dynamic>, d.id)).toList();
  }

  // ---------------------- READ SINGLE ANNOUNCEMENT BY ID ----------------------
  @override
  Future<AnnouncementModel> getAnnouncementById(String id) async {
    // Get a single document from Firestore using its ID
    final doc = await _col.doc(id).get();

    // Convert the document data to an AnnouncementModel and return it
    return AnnouncementModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ---------------------- CREATE / ADD ANNOUNCEMENT ----------------------
  @override
  Future<AnnouncementModel> addAnnouncement(AnnouncementModel announcement) async {
    // Add a new document to the 'announcements' collection using the data from the AnnouncementModel
    final docRef = await _col.add(announcement.toMap());

    // Retrieve the newly added document to get its data and generated ID
    final doc = await docRef.get();

    // Convert the Firestore document into an AnnouncementModel and return it
    return AnnouncementModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ---------------------- UPDATE EXISTING ANNOUNCEMENT ----------------------
  @override
  Future<AnnouncementModel> updateAnnouncement(AnnouncementModel announcement) async {
    // Update an existing document in Firestore using the announcement's ID and data
    await _col.doc(announcement.id).update(announcement.toMap());

    // Retrieve the updated document to reflect the latest changes
    final doc = await _col.doc(announcement.id).get();

    // Convert the updated Firestore document into an AnnouncementModel and return it
    return AnnouncementModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ---------------------- DELETE ANNOUNCEMENT ----------------------
  @override
  Future<void> deleteAnnouncement(String id) async {
    // Delete a document from the 'announcements' collection using its ID
    await _col.doc(id).delete();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/announcement_model.dart';
import 'announcement_remote_data_source.dart';

class AnnouncementRemoteDataSourceImpl implements AnnouncementRemoteDataSource {
  final FirebaseFirestore firestore;

  AnnouncementRemoteDataSourceImpl({required this.firestore});

  CollectionReference get _col => firestore.collection('announcements');

  @override
  Future<List<AnnouncementModel>> getAllAnnouncements() async {
    final snap = await _col.orderBy('createdAt', descending: true).get();
    return snap.docs.map((d) => AnnouncementModel.fromMap(d.data() as Map<String, dynamic>, d.id)).toList();
  }

  @override
  Future<AnnouncementModel> getAnnouncementById(String id) async {
    final doc = await _col.doc(id).get();
    return AnnouncementModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  Future<AnnouncementModel> addAnnouncement(AnnouncementModel announcement) async {
    final docRef = await _col.add(announcement.toMap());
    final doc = await docRef.get();
    return AnnouncementModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  Future<AnnouncementModel> updateAnnouncement(AnnouncementModel announcement) async {
    await _col.doc(announcement.id).update(announcement.toMap());
    final doc = await _col.doc(announcement.id).get();
    return AnnouncementModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  Future<void> deleteAnnouncement(String id) async {
    await _col.doc(id).delete();
  }
}
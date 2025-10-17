import '../models/announcement_model.dart';

abstract class AnnouncementRemoteDataSource {
  Future<List<AnnouncementModel>> getAllAnnouncements();
  Future<AnnouncementModel> getAnnouncementById(String id);
  Future<AnnouncementModel> addAnnouncement(AnnouncementModel announcement);
  Future<AnnouncementModel> updateAnnouncement(AnnouncementModel announcement);
  Future<void> deleteAnnouncement(String id);
}
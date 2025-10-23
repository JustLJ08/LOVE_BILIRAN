import '../models/announcement_model.dart';

// Define an abstract class (interface) for the AnnouncementRemoteDataSource
// This serves as a contract that any implementation must follow
abstract class AnnouncementRemoteDataSource {

  // ---------------------- GET ALL ANNOUNCEMENTS ----------------------
  // Defines a method that retrieves all announcements from the data source
  // Returns a Future that completes with a list of AnnouncementModel objects
  Future<List<AnnouncementModel>> getAllAnnouncements();

  // ---------------------- GET ANNOUNCEMENT BY ID ----------------------
  // Defines a method that retrieves a single announcement by its unique ID
  // Returns a Future that completes with one AnnouncementModel object
  Future<AnnouncementModel> getAnnouncementById(String id);

  // ---------------------- ADD ANNOUNCEMENT ----------------------
  // Defines a method that adds a new announcement to the data source
  // Accepts an AnnouncementModel as input and returns the created model with its new ID
  Future<AnnouncementModel> addAnnouncement(AnnouncementModel announcement);

  // ---------------------- UPDATE ANNOUNCEMENT ----------------------
  // Defines a method that updates an existing announcement
  // Takes an updated AnnouncementModel and returns the new version after updating
  Future<AnnouncementModel> updateAnnouncement(AnnouncementModel announcement);

  // ---------------------- DELETE ANNOUNCEMENT ----------------------
  // Defines a method that deletes an announcement by its ID
  // Returns a Future that completes with no value (void) once deletion is done
  Future<void> deleteAnnouncement(String id);
}

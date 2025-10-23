import '../models/event_model.dart';

// Abstract class that defines the contract for event-related data operations.
// This ensures consistent implementation across different data sources (e.g., remote, local).
abstract class EventRemoteDataSource {
  // Fetches all events from the data source and returns them as a list of EventModel objects.
  Future<List<EventModel>> getAllEvents();

  // Fetches a single event by its unique ID.
  Future<EventModel> getEventById(String id);

  // Adds a new event to the data source and returns the created EventModel.
  Future<EventModel> addEvent(EventModel event);

  // Updates an existing event and returns the updated EventModel.
  Future<EventModel> updateEvent(EventModel event);

  // Deletes an event from the data source using its ID.
  Future<void> deleteEvent(String id);
}

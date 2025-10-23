import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/event_remote_data_source.dart';

// Implementation of the EventRepository interface.
// This class handles communication between the domain layer and the remote data source (Firestore).
// It manages data fetching, error handling, and converts results into Either<Failure, Type> responses.
class EventRepositoryImpl implements EventRepository {
  // A reference to the remote data source that interacts directly with Firestore.
  final EventRemoteDataSource remoteDataSource;

  // Constructor that requires a remote data source instance (dependency injection).
  EventRepositoryImpl({required this.remoteDataSource});

  // ---------------------- GET ALL EVENTS ----------------------
  @override
  Future<Either<Failure, List<Event>>> getAllEvents() async {
    try {
      // Fetches all event data from Firestore through the remote data source.
      final list = await remoteDataSource.getAllEvents();

      // Returns the result wrapped in Right (indicating success).
      return Right(list);
    } catch (e) {
      // If an exception occurs, wrap it in a ServerFailure (Left indicates failure).
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- GET EVENT DETAILS ----------------------
  @override
  Future<Either<Failure, Event>> getEventDetails(String id) async {
    try {
      // Fetches a single event from Firestore using its document ID.
      final item = await remoteDataSource.getEventById(id);

      // Returns the event wrapped in Right to indicate a successful operation.
      return Right(item);
    } catch (e) {
      // Returns a failure with the error message if fetching fails.
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- ADD NEW EVENT ----------------------
  @override
  Future<Either<Failure, Event>> addEvent(Event event) async {
    try {
      // Adds a new event by passing the entity to the remote data source.
      // The 'as dynamic' cast ensures compatibility between entity and model layers.
      final model = await remoteDataSource.addEvent(event as dynamic);

      // Returns the created event wrapped in Right.
      return Right(model);
    } catch (e) {
      // If adding the event fails, return a ServerFailure with the error message.
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- UPDATE EXISTING EVENT ----------------------
  @override
  Future<Either<Failure, Event>> updateEvent(Event event) async {
    try {
      // Updates an existing event in Firestore.
      final model = await remoteDataSource.updateEvent(event as dynamic);

      // Returns the updated event wrapped in Right (success).
      return Right(model);
    } catch (e) {
      // Returns a failure result if updating fails.
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- DELETE EVENT ----------------------
  Future<Either<Failure, Unit>> deleteEvent(String id) async {
    try {
      // Deletes an event from Firestore by its ID.
      await remoteDataSource.deleteEvent(id);

      // Returns Right(unit) to indicate success (no data returned).
      return const Right(unit);
    } catch (e) {
      // Wraps the error in a ServerFailure to indicate an issue during deletion.
      return Left(ServerFailure(e.toString()));
    }
  }
}

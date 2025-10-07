import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/event.dart';

abstract class EventRepository {
  Future<Either<Failure, List<Event>>> getAllEvents();
  Future<Either<Failure, Event>> getEventDetails(String id);
  Future<Either<Failure, void>> addEvent(Event event);
  Future<Either<Failure, void>> updateEvent(Event event);
}

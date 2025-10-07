import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class GetAllEvents {
  final EventRepository repository;

  GetAllEvents(this.repository);

  Future<Either<Failure, List<Event>>> call() async {
    return await repository.getAllEvents();
  }
}

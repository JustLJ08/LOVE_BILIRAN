import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class GetEventDetails {
  final EventRepository repository;

  GetEventDetails(this.repository);

  Future<Either<Failure, Event>> call(String id) async {
    return await repository.getEventDetails(id);
  }
}

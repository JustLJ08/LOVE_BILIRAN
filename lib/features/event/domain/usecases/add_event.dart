import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class AddEvent {
  final EventRepository repository;

  AddEvent(this.repository);

  Future<Either<Failure, void>> call(Event event) async {
    return await repository.addEvent(event);
  }
}

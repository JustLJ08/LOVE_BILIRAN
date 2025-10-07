import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

class UpdateEvent {
  final EventRepository repository;

  UpdateEvent(this.repository);

  Future<Either<Failure, void>> call(Event event) async {
    return await repository.updateEvent(event);
  }
}

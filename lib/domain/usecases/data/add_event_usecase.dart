import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/event.dart';
import '../../repositories/data_repository.dart';

class AddEventUseCase implements UseCase<void, LocalEvent> {
  final DataRepository repository;

  AddEventUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(LocalEvent event) {
    return repository.addEvent(event);
  }
}
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/contact_info.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/contact_remote_data_source.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteDataSource remoteDataSource;

  ContactRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ContactInfo>>> getAllContacts() async {
    try {
      final list = await remoteDataSource.getAllContacts();
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ContactInfo>> getContactDetails(String id) async {
    try {
      final item = await remoteDataSource.getContactById(id);
      return Right(item);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ContactInfo>> addContact(ContactInfo contact) async {
    try {
      final model = await remoteDataSource.addContact(contact as dynamic);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ContactInfo>> updateContact(ContactInfo contact) async {
    try {
      final model = await remoteDataSource.updateContact(contact as dynamic);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, Unit>> deleteContact(String id) async {
    try {
      await remoteDataSource.deleteContact(id);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
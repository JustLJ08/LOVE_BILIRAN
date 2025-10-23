import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/contact_info.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/contact_remote_data_source.dart';

// The ContactRepositoryImpl class implements the ContactRepository interface.
// It acts as a bridge between the domain layer and the data source layer.
// This class handles business logic errors and converts them into Failure objects
// using functional programming concepts (Either, Left, Right) from the Dartz package.
class ContactRepositoryImpl implements ContactRepository {
  // Reference to the remote data source that interacts with Firestore
  final ContactRemoteDataSource remoteDataSource;

  // Constructor that requires a remote data source instance for dependency injection
  ContactRepositoryImpl({required this.remoteDataSource});

  // ---------------------- GET ALL CONTACTS ----------------------
  @override
  Future<Either<Failure, List<ContactInfo>>> getAllContacts() async {
    try {
      // Fetch all contacts from the remote data source (Firestore)
      final list = await remoteDataSource.getAllContacts();

      // Return the list wrapped in Right (indicates success)
      return Right(list);
    } catch (e) {
      // In case of error, return Left containing a ServerFailure with the error message
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- GET CONTACT DETAILS ----------------------
  @override
  Future<Either<Failure, ContactInfo>> getContactDetails(String id) async {
    try {
      // Fetch a single contact by its ID from Firestore
      final item = await remoteDataSource.getContactById(id);

      // Return the contact wrapped in Right (success)
      return Right(item);
    } catch (e) {
      // Catch any exception and return it as a ServerFailure
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- ADD NEW CONTACT ----------------------
  @override
  Future<Either<Failure, ContactInfo>> addContact(ContactInfo contact) async {
    try {
      // Add a new contact by calling the remote data source
      // 'as dynamic' cast allows passing the domain entity as a model
      final model = await remoteDataSource.addContact(contact as dynamic);

      // Return the created contact wrapped in Right
      return Right(model);
    } catch (e) {
      // If an error occurs, return it wrapped in Left with a ServerFailure
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- UPDATE EXISTING CONTACT ----------------------
  @override
  Future<Either<Failure, ContactInfo>> updateContact(ContactInfo contact) async {
    try {
      // Update the existing contact through the remote data source
      final model = await remoteDataSource.updateContact(contact as dynamic);

      // Return the updated contact wrapped in Right
      return Right(model);
    } catch (e) {
      // Return ServerFailure if any exception occurs
      return Left(ServerFailure(e.toString()));
    }
  }

  // ---------------------- DELETE CONTACT ----------------------
  Future<Either<Failure, Unit>> deleteContact(String id) async {
    try {
      // Delete the contact by its ID from the remote data source
      await remoteDataSource.deleteContact(id);

      // Return Right(unit) to indicate success with no return data
      return const Right(unit);
    } catch (e) {
      // If deletion fails, return Left(ServerFailure)
      return Left(ServerFailure(e.toString()));
    }
  }
}

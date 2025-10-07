import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/contact_info.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactInfo>>> getAllContacts();
  Future<Either<Failure, ContactInfo>> getContactDetails(String id);
  Future<Either<Failure, void>> addContact(ContactInfo contact);
  Future<Either<Failure, void>> updateContact(ContactInfo contact);
}

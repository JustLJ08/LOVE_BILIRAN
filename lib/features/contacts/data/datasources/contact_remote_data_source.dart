import '../models/contact_model.dart';

abstract class ContactRemoteDataSource {
  Future<List<ContactModel>> getAllContacts();
  Future<ContactModel> getContactById(String id);
  Future<ContactModel> addContact(ContactModel contact);
  Future<ContactModel> updateContact(ContactModel contact);
  Future<void> deleteContact(String id);
}
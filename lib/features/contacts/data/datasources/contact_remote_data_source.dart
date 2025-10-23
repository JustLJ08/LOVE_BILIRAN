import '../models/contact_model.dart';

// Defines an abstract class (interface) that specifies the contract for contact data operations.
// Any class that implements this must provide the actual logic for these methods.
abstract class ContactRemoteDataSource {

  // ---------------------- GET ALL CONTACTS ----------------------
  // Defines a method to retrieve all contact records from the data source.
  // Returns a Future that completes with a list of ContactModel objects.
  Future<List<ContactModel>> getAllContacts();

  // ---------------------- GET CONTACT BY ID ----------------------
  // Defines a method to fetch a single contact using its unique ID.
  // Returns a Future that completes with a ContactModel object.
  Future<ContactModel> getContactById(String id);

  // ---------------------- ADD NEW CONTACT ----------------------
  // Defines a method to add a new contact to the data source.
  // Accepts a ContactModel and returns the newly created ContactModel.
  Future<ContactModel> addContact(ContactModel contact);

  // ---------------------- UPDATE CONTACT ----------------------
  // Defines a method to update an existing contact’s information.
  // Takes a ContactModel and returns the updated version.
  Future<ContactModel> updateContact(ContactModel contact);

  // ---------------------- DELETE CONTACT ----------------------
  // Defines a method to remove a contact from the data source using its ID.
  // Returns a Future that completes with no value (void) once deletion is done.
  Future<void> deleteContact(String id);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact_model.dart';
import 'contact_remote_data_source.dart';

// This class implements the ContactRemoteDataSource interface.
// It is responsible for performing all CRUD operations (Create, Read, Update, Delete)
// for the 'contacts' collection in Firebase Firestore.
// Each method interacts directly with the Firestore database and converts the data
// to and from the ContactModel class for structured access and manipulation.
class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  // Firestore instance used to communicate with the Firebase database
  final FirebaseFirestore firestore;

  // Constructor that requires a Firestore instance when creating the class
  ContactRemoteDataSourceImpl({required this.firestore});

  // Getter that returns a reference to the 'contacts' collection in Firestore
  CollectionReference get _col => firestore.collection('contacts');

  // ---------------------- GET ALL CONTACTS ----------------------
  @override
  Future<List<ContactModel>> getAllContacts() async {
    // Retrieve all documents from the 'contacts' collection
    final snap = await _col.get();

    // Map each document into a ContactModel object and return as a list
    return snap.docs.map((d) => ContactModel.fromMap(d.data() as Map<String, dynamic>, d.id)).toList();
  }

  // ---------------------- GET CONTACT BY ID ----------------------
  @override
  Future<ContactModel> getContactById(String id) async {
    // Get a single document from Firestore using its unique ID
    final doc = await _col.doc(id).get();

    // Convert the Firestore document into a ContactModel instance
    return ContactModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ---------------------- ADD NEW CONTACT ----------------------
  @override
  Future<ContactModel> addContact(ContactModel contact) async {
    // Add a new document to the 'contacts' collection with the data from the model
    final docRef = await _col.add(contact.toMap());

    // Retrieve the document just added to get its data and Firestore-generated ID
    final doc = await docRef.get();

    // Convert the document snapshot into a ContactModel object and return it
    return ContactModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ---------------------- UPDATE EXISTING CONTACT ----------------------
  @override
  Future<ContactModel> updateContact(ContactModel contact) async {
    // Update the existing contact document using its ID and updated data
    await _col.doc(contact.id).update(contact.toMap());

    // Retrieve the updated document to reflect the new data
    final doc = await _col.doc(contact.id).get();

    // Convert the updated document into a ContactModel and return it
    return ContactModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ---------------------- DELETE CONTACT ----------------------
  @override
  Future<void> deleteContact(String id) async {
    // Delete the contact document from the 'contacts' collection using its ID
    await _col.doc(id).delete();
  }
}

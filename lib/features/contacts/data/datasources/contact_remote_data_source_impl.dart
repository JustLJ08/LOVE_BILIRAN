import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact_model.dart';
import 'contact_remote_data_source.dart';

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final FirebaseFirestore firestore;

  ContactRemoteDataSourceImpl({required this.firestore});

  CollectionReference get _col => firestore.collection('contacts');

  @override
  Future<List<ContactModel>> getAllContacts() async {
    final snap = await _col.get();
    return snap.docs.map((d) => ContactModel.fromMap(d.data() as Map<String, dynamic>, d.id)).toList();
  }

  @override
  Future<ContactModel> getContactById(String id) async {
    final doc = await _col.doc(id).get();
    return ContactModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  Future<ContactModel> addContact(ContactModel contact) async {
    final docRef = await _col.add(contact.toMap());
    final doc = await docRef.get();
    return ContactModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  Future<ContactModel> updateContact(ContactModel contact) async {
    await _col.doc(contact.id).update(contact.toMap());
    final doc = await _col.doc(contact.id).get();
    return ContactModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  @override
  Future<void> deleteContact(String id) async {
    await _col.doc(id).delete();
  }
}
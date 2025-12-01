import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/announcement.dart';
import '../entities/contact.dart';
import '../entities/event.dart';
import '../entities/tourist_spot.dart';

abstract class DataRepository {
  // Read
  Stream<List<TouristSpot>> getSpots();
  Stream<List<LocalEvent>> getEvents();
  Stream<List<Announcement>> getAnnouncements();
  Stream<List<Contact>> getContacts();

  // Write
  Future<Either<Failure, void>> addSpot(TouristSpot spot);
  Future<Either<Failure, void>> addEvent(LocalEvent event);
  Future<Either<Failure, void>> addAnnouncement(Announcement announcement);
  Future<Either<Failure, void>> addContact(Contact contact);
  Future<Either<Failure, String>> uploadImage(File? file, Uint8List? webBytes);
}
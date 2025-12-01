import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/announcement.dart';
import '../../domain/entities/contact.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/tourist_spot.dart';
import '../../domain/repositories/data_repository.dart';
import '../datasources/remote/cloudinary_service.dart';
import '../datasources/remote/firestore_service.dart';
import '../models/announcement_model.dart';
import '../models/contact_model.dart';
import '../models/event_model.dart';
import '../models/tourist_spot_model.dart';

class DataRepositoryImpl implements DataRepository {
  final FirestoreService firestoreService;
  final CloudinaryService cloudinaryService;

  DataRepositoryImpl({
    required this.firestoreService,
    required this.cloudinaryService,
  });

  @override
  Stream<List<TouristSpot>> getSpots() {
    return firestoreService.getSpots();
  }

  @override
  Stream<List<LocalEvent>> getEvents() {
    return firestoreService.getEvents();
  }

  @override
  Stream<List<Announcement>> getAnnouncements() {
    return firestoreService.getAnnouncements();
  }

  @override
  Stream<List<Contact>> getContacts() {
    return firestoreService.getContacts();
  }

  @override
  Future<Either<Failure, void>> addSpot(TouristSpot spot) async {
    try {
      final spotModel = TouristSpotModel(
        id: spot.id,
        name: spot.name,
        description: spot.description,
        imageUrl: spot.imageUrl,
        address: spot.address,
      );
      await firestoreService.addSpot(spotModel);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure("Failed to add spot"));
    }
  }

  @override
  Future<Either<Failure, void>> addEvent(LocalEvent event) async {
    try {
      final eventModel = EventModel(
        id: event.id,
        title: event.title,
        date: event.date,
        location: event.location,
      );
      await firestoreService.addEvent(eventModel);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure("Failed to add event"));
    }
  }

  @override
  Future<Either<Failure, void>> addAnnouncement(Announcement announcement) async {
    try {
      final announcementModel = AnnouncementModel(
        id: announcement.id,
        title: announcement.title,
        message: announcement.message,
        timestamp: announcement.timestamp,
      );
      await firestoreService.addAnnouncement(announcementModel);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure("Failed to add announcement"));
    }
  }

  @override
  Future<Either<Failure, void>> addContact(Contact contact) async {
    try {
      final contactModel = ContactModel(
        id: contact.id,
        name: contact.name,
        number: contact.number,
        type: contact.type,
      );
      await firestoreService.addContact(contactModel);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure("Failed to add contact"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File? file, Uint8List? webBytes) async {
    try {
      final imageUrl = await cloudinaryService.uploadImage(file, webBytes);
      return Right(imageUrl);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/announcement.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/entities/event.dart';
import '../../../domain/entities/tourist_spot.dart';
import '../../../domain/usecases/data/add_announcement_usecase.dart';
import '../../../domain/usecases/data/add_contact_usecase.dart';
import '../../../domain/usecases/data/add_event_usecase.dart';
import '../../../domain/usecases/data/add_spot_usecase.dart';
import '../../../domain/usecases/data/get_announcements_usecase.dart';
import '../../../domain/usecases/data/get_contacts_usecase.dart';
import '../../../domain/usecases/data/get_events_usecase.dart';
import '../../../domain/usecases/data/get_spots_usecase.dart';
import '../../../domain/usecases/data/upload_image_usecase.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final GetSpotsUseCase getSpots;
  final GetEventsUseCase getEvents;
  final GetAnnouncementsUseCase getAnnouncements;
  final GetContactsUseCase getContacts;
  final AddSpotUseCase addSpot;
  final AddEventUseCase addEvent;
  final AddAnnouncementUseCase addAnnouncement;
  final AddContactUseCase addContact;
  final UploadImageUseCase uploadImage;

  DataBloc({
    required this.getSpots,
    required this.getEvents,
    required this.getAnnouncements,
    required this.getContacts,
    required this.addSpot,
    required this.addEvent,
    required this.addAnnouncement,
    required this.addContact,
    required this.uploadImage,
  }) : super(DataInitial()) {
    on<AddSpotSubmitted>(_onAddSpotSubmitted);
    on<AddEventSubmitted>(_onAddEventSubmitted);
    on<AddAnnouncementSubmitted>(_onAddAnnouncementSubmitted);
    on<AddContactSubmitted>(_onAddContactSubmitted);
  }

  Stream<List<TouristSpot>> get spotsStream => getSpots();
  Stream<List<LocalEvent>> get eventsStream => getEvents();
  Stream<List<Announcement>> get announcementsStream => getAnnouncements();
  Stream<List<Contact>> get contactsStream => getContacts();

  Future<void> _onAddSpotSubmitted(
    AddSpotSubmitted event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    if (event.mobileFile == null && event.webBytes == null) {
      emit(const DataError("Please select an image"));
      return;
    }

    final imageResult = await uploadImage(UploadImageParams(
      mobileFile: event.mobileFile,
      webBytes: event.webBytes,
    ));

    await imageResult.fold(
      (failure) async => emit(DataError(failure.message)),
      (imageUrl) async {
        final spot = TouristSpot(
          id: '', // Firestore generates this
          name: event.name,
          description: event.description,
          imageUrl: imageUrl,
          address: event.address,
        );
        final result = await addSpot(spot);
        result.fold(
          (failure) => emit(DataError(failure.message)),
          (_) => emit(const DataSuccess("Spot added successfully!")),
        );
      },
    );
  }

  Future<void> _onAddEventSubmitted(
    AddEventSubmitted event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    final localEvent = LocalEvent(
      id: '',
      title: event.title,
      date: event.date,
      location: event.location,
    );
    final result = await addEvent(localEvent);
    result.fold(
      (failure) => emit(DataError(failure.message)),
      (_) => emit(const DataSuccess("Event added successfully!")),
    );
  }

  Future<void> _onAddAnnouncementSubmitted(
    AddAnnouncementSubmitted event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    final announcement = Announcement(
      id: '',
      title: event.title,
      message: event.message,
      timestamp: DateTime.now(),
    );
    final result = await addAnnouncement(announcement);
    result.fold(
      (failure) => emit(DataError(failure.message)),
      (_) => emit(const DataSuccess("Announcement added successfully!")),
    );
  }

  Future<void> _onAddContactSubmitted(
    AddContactSubmitted event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoading());
    final contact = Contact(
      id: '',
      name: event.name,
      number: event.number,
      type: event.type,
    );
    final result = await addContact(contact);
    result.fold(
      (failure) => emit(DataError(failure.message)),
      (_) => emit(const DataSuccess("Contact added successfully!")),
    );
  }
}
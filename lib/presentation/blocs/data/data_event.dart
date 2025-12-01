part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();
  @override
  List<Object?> get props => [];
}

class AddSpotSubmitted extends DataEvent {
  final String name;
  final String description;
  final String address;
  final File? mobileFile;
  final Uint8List? webBytes;

  const AddSpotSubmitted({
    required this.name,
    required this.description,
    required this.address,
    this.mobileFile,
    this.webBytes,
  });
  @override
  List<Object?> get props => [name, description, address, mobileFile, webBytes];
}

class AddEventSubmitted extends DataEvent {
  final String title;
  final DateTime date;
  final String location;

  const AddEventSubmitted({
    required this.title,
    required this.date,
    required this.location,
  });
  @override
  List<Object> get props => [title, date, location];
}

class AddAnnouncementSubmitted extends DataEvent {
  final String title;
  final String message;

  const AddAnnouncementSubmitted({required this.title, required this.message});
  @override
  List<Object> get props => [title, message];
}

class AddContactSubmitted extends DataEvent {
  final String name;
  final String number;
  final String type;

  const AddContactSubmitted({
    required this.name,
    required this.number,
    required this.type,
  });
  @override
  List<Object> get props => [name, number, type];
}
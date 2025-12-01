import 'package:equatable/equatable.dart';

class LocalEvent extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final String location;

  const LocalEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
  });

  @override
  List<Object> get props => [id, title, date, location];
}
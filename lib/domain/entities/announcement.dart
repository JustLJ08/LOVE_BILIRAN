import 'package:equatable/equatable.dart';

class Announcement extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;

  const Announcement({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object> get props => [id, title, message, timestamp];
}
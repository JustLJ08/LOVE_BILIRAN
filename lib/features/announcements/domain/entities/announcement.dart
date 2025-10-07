import 'package:equatable/equatable.dart';

class Announcement extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime datePosted;
  final String author;
  final String? imageUrl;

  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.datePosted,
    required this.author,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, title, content, datePosted, author, imageUrl];
}

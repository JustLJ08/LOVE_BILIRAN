import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String id;
  final String name;
  final String number;
  final String type;

  const Contact({
    required this.id,
    required this.name,
    required this.number,
    required this.type,
  });

  @override
  List<Object> get props => [id, name, number, type];
}
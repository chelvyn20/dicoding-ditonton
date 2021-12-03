import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  const Genre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

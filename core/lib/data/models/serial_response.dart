import 'dart:convert';

import 'package:core/data/models/serial_model.dart';
import 'package:equatable/equatable.dart';

class SerialResponse extends Equatable {
  final List<SerialModel> serialList;

  const SerialResponse({
    required this.serialList,
  });

  Map<String, dynamic> toMap() {
    return {
      'results': serialList.map((x) => x.toMap()).toList(),
    };
  }

  factory SerialResponse.fromMap(Map<String, dynamic> map) {
    return SerialResponse(
      serialList: List<SerialModel>.from(map['results']
          .map((x) => SerialModel.fromMap(x))
          .where((element) => element.posterPath != null)),
    );
  }

  String toJson() => json.encode(toMap());

  factory SerialResponse.fromJson(String source) =>
      SerialResponse.fromMap(json.decode(source));

  @override
  List<Object> get props => [serialList];
}

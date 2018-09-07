library example.json_to_object;

import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class DoodleResponse {
  /// The Doodle poll ID
  String id;

  /// JS timestamp
  int initiated;
  int latestChange;

  /// The participants count. Same as parcipants.length
  int participantsCount;

  String title;
  String description;

  /// Game's list
  List<Option> options;

  List<Participant> participants;

  DoodleResponse();

  factory DoodleResponse.fromJson(Map<String, dynamic> json) => _$DoodleResponseFromJson(json);
}

@JsonSerializable()
class Option {
  String text;

  Option();

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}

@JsonSerializable()
class Participant {
  int id;
  String name;
  List<int> preferences;

  Participant();

  factory Participant.fromJson(Map<String, dynamic> json) => _$ParticipantFromJson(json);
}

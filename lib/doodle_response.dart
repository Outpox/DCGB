library example.json_to_object;

import 'package:dson/dson.dart';

part 'doodle_response.g.dart';

@serializable
class DoodleResponse extends _$DoodleResponseSerializable {
  /// The Doodle poll ID
  String id;

  /// JS timestamp
  int initiated;
  int latestChange;

  /// The participants count
  int participantsCount;

  String title;
  String description;

  /// Game's list
  List<Option> options;

  List<Participant> participants;

  DoodleResponse();
}

@serializable
class Option extends _$OptionSerializable {
  String text;
}

@serializable
class Participant extends _$ParticipantSerializable {
  int id;
  String name;
  List<int> preferences;
}
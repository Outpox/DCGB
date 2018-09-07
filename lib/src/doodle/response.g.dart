// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.json_to_object;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoodleResponse _$DoodleResponseFromJson(Map<String, dynamic> json) {
  return DoodleResponse()
    ..id = json['id'] as String
    ..initiated = json['initiated'] as int
    ..latestChange = json['latestChange'] as int
    ..participantsCount = json['participantsCount'] as int
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..options = (json['options'] as List)
        ?.map((e) =>
            e == null ? null : Option.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..participants = (json['participants'] as List)
        ?.map((e) =>
            e == null ? null : Participant.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$DoodleResponseToJson(DoodleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'initiated': instance.initiated,
      'latestChange': instance.latestChange,
      'participantsCount': instance.participantsCount,
      'title': instance.title,
      'description': instance.description,
      'options': instance.options,
      'participants': instance.participants
    };

Option _$OptionFromJson(Map<String, dynamic> json) {
  return Option()..text = json['text'] as String;
}

Map<String, dynamic> _$OptionToJson(Option instance) =>
    <String, dynamic>{'text': instance.text};

Participant _$ParticipantFromJson(Map<String, dynamic> json) {
  return Participant()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..preferences =
        (json['preferences'] as List)?.map((e) => e as int)?.toList();
}

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'preferences': instance.preferences
    };

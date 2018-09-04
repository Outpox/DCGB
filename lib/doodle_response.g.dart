// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.json_to_object;

// **************************************************************************
// DsonGenerator
// **************************************************************************

abstract class _$DoodleResponseSerializable extends SerializableMap {
  String get id;
  int get initiated;
  int get latestChange;
  int get participantsCount;
  String get title;
  String get description;
  List<Option> get options;
  List<Participant> get participants;
  void set id(String v);
  void set initiated(int v);
  void set latestChange(int v);
  void set participantsCount(int v);
  void set title(String v);
  void set description(String v);
  void set options(List<Option> v);
  void set participants(List<Participant> v);

  operator [](Object __key) {
    switch (__key) {
      case 'id':
        return id;
      case 'initiated':
        return initiated;
      case 'latestChange':
        return latestChange;
      case 'participantsCount':
        return participantsCount;
      case 'title':
        return title;
      case 'description':
        return description;
      case 'options':
        return options;
      case 'participants':
        return participants;
    }
    throwFieldNotFoundException(__key, 'DoodleResponse');
  }

  operator []=(Object __key, __value) {
    switch (__key) {
      case 'id':
        id = __value;
        return;
      case 'initiated':
        initiated = __value;
        return;
      case 'latestChange':
        latestChange = __value;
        return;
      case 'participantsCount':
        participantsCount = __value;
        return;
      case 'title':
        title = __value;
        return;
      case 'description':
        description = __value;
        return;
      case 'options':
        options = fromSerialized(
            __value, [() => new List<Option>(), () => new Option()]);
        return;
      case 'participants':
        participants = fromSerialized(
            __value, [() => new List<Participant>(), () => new Participant()]);
        return;
    }
    throwFieldNotFoundException(__key, 'DoodleResponse');
  }

  Iterable<String> get keys => DoodleResponseClassMirror.fields.keys;
}

abstract class _$OptionSerializable extends SerializableMap {
  String get text;
  void set text(String v);

  operator [](Object __key) {
    switch (__key) {
      case 'text':
        return text;
    }
    throwFieldNotFoundException(__key, 'Option');
  }

  operator []=(Object __key, __value) {
    switch (__key) {
      case 'text':
        text = __value;
        return;
    }
    throwFieldNotFoundException(__key, 'Option');
  }

  Iterable<String> get keys => OptionClassMirror.fields.keys;
}

abstract class _$ParticipantSerializable extends SerializableMap {
  int get id;
  String get name;
  List<int> get preferences;
  void set id(int v);
  void set name(String v);
  void set preferences(List<int> v);

  operator [](Object __key) {
    switch (__key) {
      case 'id':
        return id;
      case 'name':
        return name;
      case 'preferences':
        return preferences;
    }
    throwFieldNotFoundException(__key, 'Participant');
  }

  operator []=(Object __key, __value) {
    switch (__key) {
      case 'id':
        id = __value;
        return;
      case 'name':
        name = __value;
        return;
      case 'preferences':
        preferences = fromSerialized(__value, () => new List<int>());
        return;
    }
    throwFieldNotFoundException(__key, 'Participant');
  }

  Iterable<String> get keys => ParticipantClassMirror.fields.keys;
}

// **************************************************************************
// MirrorsGenerator
// **************************************************************************

_DoodleResponse__Constructor([positionalParams, namedParams]) =>
    new DoodleResponse();

const $$DoodleResponse_fields_id =
    const DeclarationMirror(name: 'id', type: String);
const $$DoodleResponse_fields_initiated =
    const DeclarationMirror(name: 'initiated', type: int);
const $$DoodleResponse_fields_latestChange =
    const DeclarationMirror(name: 'latestChange', type: int);
const $$DoodleResponse_fields_participantsCount =
    const DeclarationMirror(name: 'participantsCount', type: int);
const $$DoodleResponse_fields_title =
    const DeclarationMirror(name: 'title', type: String);
const $$DoodleResponse_fields_description =
    const DeclarationMirror(name: 'description', type: String);
const $$DoodleResponse_fields_options =
    const DeclarationMirror(name: 'options', type: const [List, Option]);
const $$DoodleResponse_fields_participants = const DeclarationMirror(
    name: 'participants', type: const [List, Participant]);

const DoodleResponseClassMirror =
    const ClassMirror(name: 'DoodleResponse', constructors: const {
  '': const FunctionMirror(name: '', $call: _DoodleResponse__Constructor)
}, fields: const {
  'id': $$DoodleResponse_fields_id,
  'initiated': $$DoodleResponse_fields_initiated,
  'latestChange': $$DoodleResponse_fields_latestChange,
  'participantsCount': $$DoodleResponse_fields_participantsCount,
  'title': $$DoodleResponse_fields_title,
  'description': $$DoodleResponse_fields_description,
  'options': $$DoodleResponse_fields_options,
  'participants': $$DoodleResponse_fields_participants
}, getters: const [
  'id',
  'initiated',
  'latestChange',
  'participantsCount',
  'title',
  'description',
  'options',
  'participants'
], setters: const [
  'id',
  'initiated',
  'latestChange',
  'participantsCount',
  'title',
  'description',
  'options',
  'participants'
]);

_Option__Constructor([positionalParams, namedParams]) => new Option();

const $$Option_fields_text =
    const DeclarationMirror(name: 'text', type: String);

const OptionClassMirror = const ClassMirror(
    name: 'Option',
    constructors: const {
      '': const FunctionMirror(name: '', $call: _Option__Constructor)
    },
    fields: const {
      'text': $$Option_fields_text
    },
    getters: const [
      'text'
    ],
    setters: const [
      'text'
    ]);

_Participant__Constructor([positionalParams, namedParams]) => new Participant();

const $$Participant_fields_id = const DeclarationMirror(name: 'id', type: int);
const $$Participant_fields_name =
    const DeclarationMirror(name: 'name', type: String);
const $$Participant_fields_preferences =
    const DeclarationMirror(name: 'preferences', type: const [List, int]);

const ParticipantClassMirror =
    const ClassMirror(name: 'Participant', constructors: const {
  '': const FunctionMirror(name: '', $call: _Participant__Constructor)
}, fields: const {
  'id': $$Participant_fields_id,
  'name': $$Participant_fields_name,
  'preferences': $$Participant_fields_preferences
}, getters: const [
  'id',
  'name',
  'preferences'
], setters: const [
  'id',
  'name',
  'preferences'
]);

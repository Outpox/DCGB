import 'package:nyxx/nyxx.dart';
import 'package:edit_distance/edit_distance.dart';
import 'dart:math';

class DiscordUserFromDoodle {
  String doodleName;
  Map<Snowflake, Member> discordMembers;
  List<DiscordGuess> guesses;

  DiscordUserFromDoodle(String doodleName, Map<Snowflake, Member> discordMembers) {
    this.doodleName = doodleName;
    this.discordMembers = discordMembers;
    // this.discordMembers.forEach((id, member) => this.guesses.add(DiscordGuess(id, doodleName, member.user.username)));
    this.discordMembers.forEach((id, member) => print(member));
  }

  DiscordGuess bestGuess() {
    return this.guesses.reduce((acc, val) => min(acc.confidence, val.confidence));
  }
}

class DiscordGuess {
  Snowflake id;
  String doodleName;
  String discordName;
  double confidence;

  DiscordGuess(Snowflake id, String doodleName, String discordName) {
    this.id = id;
    this.doodleName = doodleName;
    this.discordName = discordName;
    print(doodleName);
    print(discordName);
    this.confidence = Levenshtein().normalizedDistance(doodleName, discordName);
  }
}
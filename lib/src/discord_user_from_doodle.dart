import 'package:nyxx/nyxx.dart';
import 'package:edit_distance/edit_distance.dart';

import 'users_for_game.dart';

class DiscordUserFromDoodle {
  UsersForGame doodleUsers;
  Member discordMember;
  List<DiscordGuess> guesses = [];

  DiscordUserFromDoodle(Member discordMember, UsersForGame doodleUsers) {
    this.doodleUsers = doodleUsers;
    this.discordMember = discordMember;
    this.doodleUsers.players.forEach((doodleName) => this.guesses.add(DiscordGuess(discordMember, doodleName)));
    // this.discordMembers.forEach((id, member) => print(member));
  }

  DiscordGuess bestGuess() {
    this.guesses.sort((d1, d2) => d1.confidence.compareTo(d2.confidence));
    return this.guesses.first;
  }
}

class DiscordGuess {
  Member discordUser;
  String discordName;
  String doodleName;
  double confidence;

  DiscordGuess(Member discordUser, String doodleName) {
    this.discordUser = discordUser;
    this.doodleName = doodleName;
    this.discordName = discordUser.nickname != null ? discordUser.nickname : discordUser.user.username;
    this.confidence = Levenshtein().normalizedDistance(doodleName, discordName);
  }

  @override
  String toString() {
    return "${this.doodleName} = ${this.discordName} (${this.confidence.toStringAsFixed(2)})";
  }
}
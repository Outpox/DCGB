import 'package:http/http.dart' as http;
import 'response.dart';
import 'dart:convert';
import 'dart:async';
import 'package:edit_distance/edit_distance.dart';
import 'package:DCGB/guess.dart';
import '../UsersForGame.dart';
import '../DiscordUserFromDoodle.dart';
import 'package:nyxx/nyxx.dart';

var baseUrl = 'https://doodle.com/api/v2.0/polls/';

class DoodleParser {
  String pollId;
  DoodleResponse parsedResponse;

  DoodleParser(String id) {
    this.pollId = id;
  }

  Future<void> loadData() async {
    await http.get(baseUrl + this.pollId).then((response) {
      this.parsedResponse = DoodleResponse.fromJson(json.decode(response.body));
    });
  }

  String getGamesForUser(String username) {
    List<Guess> candidates = [];

    for (var i = 0; i < this.parsedResponse.participantsCount; i++) {
      var user = this.parsedResponse.participants[i];
      var calculatedConfidence = Levenshtein().normalizedDistance(user.name.toLowerCase(), username.toLowerCase());

      if (calculatedConfidence < 0.5) {
        candidates.add(Guess(index: i, text: user.name, confidence: calculatedConfidence));
      }
    }

    if (candidates.length == 0) return 'Aucun résultat';
    
    candidates.sort((u1, u2) => u1.confidence.compareTo(u2.confidence));

    List<String> playingGamesList = [];
    List<String> mayPlayGamesList = [];
    List<String> dontPlayGamesList = [];
    Participant user = this.parsedResponse.participants[candidates[0].index];

    for (var i = 0; i < user.preferences.length; i++) {
      var value = user.preferences[i];
      var game = this.parsedResponse.options[i].text;

      switch (value) {
        case 2:
          playingGamesList.add(game);
          break;
        case 1: 
          mayPlayGamesList.add(game);
          break;
        case 0:
          dontPlayGamesList.add(game);
          break;
      }
    }

    return """
${user.name} joue aux jeux suivants : ${playingGamesList.join(", ")}.
Il est prêt à prendre les jeux suivants pour jouer en multi : ${mayPlayGamesList.join(", ")}
    """;
  }

  UsersForGame getUsersForGame(String game) {
    List<Guess> candidates = [];

    for (var i = 0; i < this.parsedResponse.options.length; i++) {
      var lgame = this.parsedResponse.options[i];
      var calculatedConfidence = Levenshtein().normalizedDistance(game.toLowerCase(), lgame.text.toLowerCase());

      if (calculatedConfidence < 0.5) {
        candidates.add(Guess(index: i, text: lgame.text, confidence: calculatedConfidence));
      }
    }

    if (candidates.length == 0) return UsersForGame.empty(game);

    candidates.sort((g1, g2) => g1.confidence.compareTo(g2.confidence));

    List<String> playersList = [];
    List<String> mightPlayList = [];
    int gameIndex = candidates[0].index;

    for (var user in this.parsedResponse.participants) {
      switch (user.preferences[gameIndex]) {
        case 2: 
          playersList.add(user.name);
          break;
        case 1: 
          mightPlayList.add(user.name);
          break;
      }
    }

    return UsersForGame(game, playersList, mightPlayList);
  }

  String messageUsersOfGame(Map<Snowflake, Member> members, User author, String game, String message) {
    game = game.trim();
    message = message.trim();

    UsersForGame ufg = getUsersForGame(game);

    List<DiscordUserFromDoodle> guesses = List();
    List<DiscordGuess> finalGuesses = List();

    members.forEach((k, member) => guesses.add(DiscordUserFromDoodle(member, ufg)));
    guesses.forEach((f) => finalGuesses.add(f.bestGuess()));

    List<String> foundPlayers = List();
    List<String> notFoundPlayers = List();

    finalGuesses.forEach((f) {
      if (f.confidence < 0.3) {
        f.discordUser.send(content: """
**[Message envoyé par ${author.mentionNickname} concernant le jeu ${game}]**
$message
""");
        foundPlayers.add(f.discordName);
      } else {
        notFoundPlayers.add(f.doodleName);
      }
    });

    return """
Les joueurs suivants (${foundPlayers.length}) ont reçu un message : ${foundPlayers.join(', ')}.
Impossible de trouver une correspondance pour les joueurs suivants (${notFoundPlayers.length}) : ${notFoundPlayers.join(', ')}.
""";
  }
}

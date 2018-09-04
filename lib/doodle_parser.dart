import 'package:http/http.dart' as http;
import 'doodle_response.dart';
import 'dart:convert';
import 'dart:async';

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
    Participant user = this.parsedResponse.participants.firstWhere((user) => user.name.toLowerCase() == username.toLowerCase(), orElse: () => Participant());
    if (user.name == null) return 'Aucun résultat';
    
    List<String> playingGamesList = [];
    List<String> mayPlayGamesList = [];
    List<String> dontPlayGamesList = [];

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

  String getUsersForGame(String game) {
    var gameIndex = this.parsedResponse.options.indexWhere((loop_game) => game.toLowerCase() == loop_game.text.toLowerCase());

    if (gameIndex == -1) {
      return 'Aucun résultat';
    }

    List<String> playersList = [];
    List<String> mightPlayList = [];

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

    return """
Les joueurs suivants (${playersList.length}) ont ${game} : ${playersList.join(", ")}.
Les joueurs suivants (${mightPlayList.length}) sont prêt à acheter le jeu : ${mightPlayList.join(", ")}.
    """;
  }
}

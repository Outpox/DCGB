class UsersForGame {
  String game;
  List<String> players;
  List<String> mightPlay;

  UsersForGame(this.game, this.players, this.mightPlay);
  UsersForGame.empty(this.game) {
    this.players = List();
    this.mightPlay = List();
  }

  bool thereArePlayers() {
    return this.players.length > 0 && this.mightPlay.length > 0;
  }

  @override
  String toString() {
    if (!this.thereArePlayers()) {
      return "Aucun joueur pour ${this.game}";
    }
    
    return """
Les joueurs suivants (${this.players.length}) ont ${this.game} : ${this.players.join(", ")}.
Les joueurs suivants (${this.mightPlay.length}) sont prêts à acheter le jeu : ${this.mightPlay.join(", ")}.
""";
  }
}

import 'package:nyxx/nyxx.dart' as discord;
import 'package:DCGB/src/doodle/parser.dart';
import 'package:dotenv/dotenv.dart';

main(List<String> arguments) async {
  // Load dotenv
  load();

  DoodleParser dp = DoodleParser("c6a4bi6inz4dmypa");
  await dp.loadData();

  discord.Nyxx bot = new discord.Nyxx(env["DISCORD_KEY"]);
  bot.onReady.listen((discord.ReadyEvent e) {
    print('Ready!');
  });

  bot.onMessage.listen((discord.MessageEvent e) {
    if (e.message.content.startsWith("!gb_game")) {
      var game = e.message.content.replaceAll("!gb_game", "").trim();
      if (game == "") {
        e.message.channel.send(content: 'Merci de préciser un jeu');
      } else {
        e.message.channel.send(content: dp.getUsersForGame(game));
      }
    }
    if (e.message.content.startsWith("!gb_player")) {
      var player = e.message.content.replaceAll("!gb_player", "").trim();
      if (player == "") {
        e.message.channel.send(content: 'Merci de préciser un joueur');
      } else {
        e.message.channel.send(content: dp.getGamesForUser(player));
      }
    }
  });
}

import 'package:nyxx/nyxx.dart' as discord;
import 'package:nyxx/commands.dart' as command;

import 'package:DCGB/src/doodle/parser.dart';
import 'package:DCGB/src/UsersForGame.dart';
import 'package:dotenv/dotenv.dart';
import 'dart:async';

const String DOODLE_URL = "https://doodle.com/poll/";
DoodleParser gdp;

main(List<String> arguments) async {
  // Load dotenv
  load();

  DoodleParser dp = DoodleParser(env["DOODLE_ID"]);
  await dp.loadData();
  gdp = dp;
  discord.Nyxx bot = new discord.Nyxx(env["DISCORD_KEY"]);
  bot.onReady.listen((discord.ReadyEvent e) {
    print('Ready!');
  });

  command.CommandsFramework('!gb_', bot)
    ..registerLibraryCommands();
}

@command.Module("player")
class PlayerCommand extends command.CommandContext {
  @command.Command(main: true)
  @command.Help("player", usage: "!gb_player playerName")
  Future run(@command.Remainder() String argument) async {
    if (argument == "") {
      return await reply(content: "Merci de préciser un joueur");
    }
    await reply(content: gdp.getGamesForUser(argument));
  }
}

@command.Module("game")
class GameCommand extends command.CommandContext {
  @command.Command(main: true)
  @command.Help("game", usage: "!gb_game gameName")
  Future run(@command.Remainder() String argument) async {
    if (argument == "") {
      return await reply(content: "Merci de préciser un jeu");
    }

    UsersForGame ufg = gdp.getUsersForGame(argument);
    await reply(content: ufg.toString());
  }
}

@command.Module("update")
class UpdateCommand extends command.CommandContext {
  @command.Command(main: true)
  @command.Help("update", usage: "!gb_update")
  Future run() async {
    await gdp.loadData();
    await reply(content: "Données mises à jour");
  }
}

@command.Module("mp")
class MpCommand extends command.CommandContext {
  @command.Command(main: true)
  @command.Help("mp", usage: "!gb_mp game, message")
  Future run(@command.Remainder() String arguments) async {
    var splitedArguments = arguments.split("|");
    if (splitedArguments.length != 2) return await reply(content: "Format attendu (| = alt gr + 6) : !gb_mp nomDuJeu | message");
    String response = gdp.messageUsersOfGame(this.guild.members, this.author, splitedArguments[0], splitedArguments[1]);
    await reply(content: response);
  }
}

@command.Module("doodle")
class DoodleCommand extends command.CommandContext {
  @command.Command(main: true)
  @command.Help("doodle", usage: "!gb_doodle")
  Future run(@command.Remainder() String arguments) async {
    await reply(content: "Le doodle est accessible à l'adresse suivante : ${DOODLE_URL + env["DOODLE_ID"]}");
  }
}

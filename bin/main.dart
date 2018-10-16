import 'dart:async';
import 'package:dotenv/dotenv.dart';
import 'package:nyxx/nyxx.dart' as discord;
import 'package:nyxx/commands.dart' as command;
import 'package:DCGB/src/doodle/parser.dart';
import 'package:DCGB/src/users_for_game.dart';

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

  command.CommandsFramework('!gb_')
    ..registerLibraryCommands();
}

@command.Command(name: "player")
@command.Help("player", usage: "!gb_player playerName")
Future player(command.CommandContext ctx, @command.Remainder() String argument) async {
  if (argument == "") {
    return await ctx.reply(content: "Merci de préciser un joueur");
  }
  await ctx.reply(content: gdp.getGamesForUser(argument));
}

@command.Command(name: "game")
@command.Help("game", usage: "!gb_game gameName")
Future game(command.CommandContext ctx, @command.Remainder() String argument) async {
  if (argument == "") {
    return await ctx.reply(content: "Merci de préciser un jeu");
  }

  UsersForGame ufg = gdp.getUsersForGame(argument);
  await ctx.reply(content: ufg.toString());
}

@command.Command(name: "update")
@command.Help("update", usage: "!gb_update")
Future update(command.CommandContext ctx) async {
  await gdp.loadData();
  await ctx.reply(content: "Données mises à jour");
}

@command.Command(name: "mp")
@command.Help("mp", usage: "!gb_mp game, message")
Future mp(command.CommandContext ctx, @command.Remainder() String arguments) async {
  var splitedArguments = arguments.split("|");
  if (splitedArguments.length != 2) return await ctx.reply(content: "Format attendu (| = alt gr + 6) : !gb_mp nomDuJeu | message");
  String response = gdp.messageUsersOfGame(ctx.guild.members, ctx.author, splitedArguments[0], splitedArguments[1]);
  await ctx.reply(content: response);
}

@command.Command(name: "doodle")
@command.Help("doodle", usage: "!gb_doodle")
Future run(command.CommandContext ctx, @command.Remainder() String arguments) async {
  await ctx.reply(content: "Le doodle est accessible à l'adresse suivante : ${DOODLE_URL + env["DOODLE_ID"]}");
}

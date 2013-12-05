#!/usr/bin/env dart

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:bot_io/completion.dart';
import 'package:bot_io/bot_io.dart';

final _log = new Logger('whats_up');

void main(List<String> args) {
  enableScriptLogListener();
  _log.info('app starting');

  final parser = _getParser();

  final results = tryArgsCompletion(args, parser);

  if(results.command != null && results.command.name == 'help') {
    _log.info('help requested');
    print("how to use what's up dart");
    print(parser.getUsage());
    return;
  }

  final names = results.rest.toList();

  if(names.isEmpty) {
    _log.info('no name provided');
    names.add('World');
  }

  final bool isYelling = results['yell'];

  final String greeting = results['greeting'];

  for(final name in names) {
    var msg = "$greeting, $name?";

    if(isYelling) {
      msg = msg.toUpperCase();
    }

    print(msg);
  }

  _log.info('app finished');
}

ArgParser _getParser() =>
  new ArgParser()
    ..addFlag('yell', abbr: 'y', help: 'Do you want me to yell?', defaultsTo: false, negatable: true)
    ..addOption('greeting', abbr: 'g', help: 'Define a custom greeting', defaultsTo: "What's up")
    ..addCommand('help');


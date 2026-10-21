import 'dart:io';

/// Gets a player's name from keyboard input.
/// Returns the entered name or a default name if no name is provided.
String getPlayerName(String defaultName) {
  stdout.write('Enter player name: ');
  String? input = stdin.readLineSync();

  String name = input?.trim() ?? '';

  if (name.isEmpty) {
    print('(No name entered. Using "$defaultName".)');
    return defaultName;
  }

  return name;
}

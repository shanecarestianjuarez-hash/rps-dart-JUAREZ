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
/// Checks whether the entered move is valid.
/// Returns the lowercase move if valid, otherwise returns null.
String? validateMove(String input) {
  List<String> validMoves = ['rock', 'paper', 'scissors'];
  String move = input.trim().toLowerCase();

  if (validMoves.contains(move)) {
    return move;
  }

  return null;
}

/// Gets a valid move from a player.
/// Keeps asking until the player enters rock, paper, or scissors.
String getMove(String playerName) {
  while (true) {
    stdout.write(
        '$playerName, enter your move (rock/paper/scissors): ');

    String? input = stdin.readLineSync();

    String safeInput = input ?? '';
    String? validMove = validateMove(safeInput);

    if (validMove != null) {
      return validMove;
    }

    print('Invalid move. Please type rock, paper, or scissors.');
  }
}


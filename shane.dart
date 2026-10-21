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


/// Decides the winner of the round.
/// Returns the winning player's name, or null if the round is a draw.
String? decideWinner(
    String playerOneMove, String playerTwoMove, String playerOneName,
    String playerTwoName) {
  if (playerOneMove == playerTwoMove) {
    return null;
  }

  switch (playerOneMove) {
    case 'rock':
      return playerTwoMove == 'scissors'
          ? playerOneName
          : playerTwoName;

    case 'paper':
      return playerTwoMove == 'rock'
          ? playerOneName
          : playerTwoName;

    case 'scissors':
      return playerTwoMove == 'paper'
          ? playerOneName
          : playerTwoName;

    default:
      return null;
  }
}

/// Prints blank lines to hide Player 1's move from Player 2.
void hidePlayerOneMove() {
  for (int i = 0; i < 30; i++) {
    print('');
  }
}

/// Gets the player's answer about whether to play another round.
/// Returns true for yes and false for no.
bool playAgain() {
  while (true) {
    stdout.write('Play again? (y/n): ');

    String? input = stdin.readLineSync();
    String answer = input?.trim().toLowerCase() ?? '';

    if (answer == 'y') {
      return true;
    }

    if (answer == 'n') {
      return false;
    }

    print('Please enter y or n.');
  }
}

/// Runs the Rock, Paper, Scissors game.
void main() {
  print('===== ROCK, PAPER, SCISSORS =====');

  String playerOneName = getPlayerName('Player 1');
  String playerTwoName = getPlayerName('Player 2');

  int playerOneScore = 0;
  int playerTwoScore = 0;
  int roundNumber = 1;

  bool continuePlaying;

  do {
    print('\n--- Round $roundNumber ---');

    String playerOneMove = getMove(playerOneName);

    hidePlayerOneMove();

    String playerTwoMove = getMove(playerTwoName);

    print(
        '$playerOneName chose $playerOneMove. '
        '$playerTwoName chose $playerTwoMove.');

    String? winner = decideWinner(
      playerOneMove,
      playerTwoMove,
      playerOneName,
      playerTwoName,
    );

    print('Result: ${winner ?? "It\'s a draw!"}');

    if (winner == playerOneName) {
      print('$playerOneName wins the round!');
      playerOneScore++;
    } else if (winner == playerTwoName) {
      print('$playerTwoName wins the round!');
      playerTwoScore++;
    }

    print(
        'Score -> $playerOneName: $playerOneScore | '
        '$playerTwoName: $playerTwoScore');

    continuePlaying = playAgain();
    roundNumber++;
  } while (continuePlaying);

  print('\n===== FINAL SCORE =====');
  print('$playerOneName: $playerOneScore | $playerTwoName: $playerTwoScore');

  if (playerOneScore > playerTwoScore) {
    print('Overall winner: $playerOneName');
  } else if (playerTwoScore > playerOneScore) {
    print('Overall winner: $playerTwoName');
  } else {
    print('Overall winner: It\'s a draw!');
  }
}

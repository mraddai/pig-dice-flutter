import 'dart:math';

/// Pure Dart implementation of the Pig dice game.
/// No Flutter imports here.
class PigGameState {
  final int targetScore;

  int player1Score;
  int player2Score;
  int turnTotal;
  int currentPlayer; // 1 or 2
  int? lastRoll;
  bool gameOver;
  int? winner; // 1 or 2 when game is over

  final Random _random = Random();

  PigGameState({this.targetScore = 50})
      : player1Score = 0,
        player2Score = 0,
        turnTotal = 0,
        currentPlayer = 1,
        lastRoll = null,
        gameOver = false,
        winner = null;

  /// Reset everything but keep the same targetScore.
  void newGame() {
    player1Score = 0;
    player2Score = 0;
    turnTotal = 0;
    currentPlayer = 1;
    lastRoll = null;
    gameOver = false;
    winner = null;
  }

  /// Roll the die with a random value 1–6.
  void roll() {
    if (gameOver) return;
    final value = _random.nextInt(6) + 1;
    _applyRoll(value);
  }

  /// Deterministic roll for tests (you can call this from unit tests).
  void debugRoll(int value) {
    if (gameOver) return;
    assert(value >= 1 && value <= 6);
    _applyRoll(value);
  }

  void _applyRoll(int value) {
    lastRoll = value;
    if (value == 1) {
      // Bust: lose turn total and switch player.
      turnTotal = 0;
      _switchPlayer();
    } else {
      // Add to turn total.
      turnTotal += value;
    }
  }

  /// Hold: bank the turnTotal for the current player.
  void hold() {
    if (gameOver) return;

    if (currentPlayer == 1) {
      player1Score += turnTotal;
    } else {
      player2Score += turnTotal;
    }

    turnTotal = 0;

    // Check for winner.
    if (player1Score >= targetScore || player2Score >= targetScore) {
      gameOver = true;
      winner = currentPlayer;
      return;
    }

    _switchPlayer();
  }

  void _switchPlayer() {
    currentPlayer = (currentPlayer == 1) ? 2 : 1;
  }

  int getScore(int player) {
    if (player == 1) return player1Score;
    if (player == 2) return player2Score;
    throw ArgumentError('Player must be 1 or 2');
  }
}

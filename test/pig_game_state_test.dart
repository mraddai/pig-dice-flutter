import 'package:flutter_test/flutter_test.dart';
import 'package:fourth_hour_project/pig_game_state.dart';


void main() {
  test('new game starts at 0-0 and player 1 turn', () {
    final game = PigGameState();
    game.newGame();

    expect(game.player1Score, 0);
    expect(game.player2Score, 0);
    expect(game.turnTotal, 0);
    expect(game.currentPlayer, 1);
    expect(game.gameOver, false);
  });

  test('holding adds turn total to current player score', () {
    final game = PigGameState();
    game.newGame();
    game.turnTotal = 12;
    game.currentPlayer = 1;

    game.hold();

    expect(game.player1Score, 12);
    expect(game.turnTotal, 0);
    expect(game.currentPlayer, 2);
  });
}

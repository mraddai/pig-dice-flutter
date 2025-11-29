import 'package:flutter/material.dart';
import 'pig_game_state.dart';

void main() {
  runApp(const PigGameApp());
}

class PigGameApp extends StatelessWidget {
  const PigGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pig Dice Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PigGameScreen(),
    );
  }
}

class PigGameScreen extends StatefulWidget {
  const PigGameScreen({super.key});

  @override
  State<PigGameScreen> createState() => _PigGameScreenState();
}

class _PigGameScreenState extends State<PigGameScreen> {
  final PigGameState _game = PigGameState();

  @override
  void initState() {
    super.initState();
    _game.newGame(); // make sure everything is reset
  }

  void _onRoll() {
    if (_game.gameOver) return;
    setState(() {
      _game.roll();
    });
  }

  void _onHold() {
    if (_game.gameOver) return;
    setState(() {
      _game.hold();
    });
  }

  void _onNewGame() {
    setState(() {
      _game.newGame();
    });
  }

  String _statusMessage() {
    if (_game.gameOver) {
      return 'Player ${_game.winner} wins!';
    } else {
      return 'Player ${_game.currentPlayer}\'s turn';
    }
  }

  @override
  Widget build(BuildContext context) {
    final lastRollText = _game.lastRoll?.toString() ?? '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pig Dice Game'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Scores row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPlayerPanel(
                  playerNumber: 1,
                  score: _game.player1Score,
                  isCurrent: _game.currentPlayer == 1,
                ),
                _buildPlayerPanel(
                  playerNumber: 2,
                  score: _game.player2Score,
                  isCurrent: _game.currentPlayer == 2,
                ),
              ],
            ),

            // Turn info: last roll + turn total
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Current Turn',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Last Roll: $lastRollText',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('Turn Total: ${_game.turnTotal}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _game.gameOver ? null : _onRoll,
                  child: const Text('Roll'),
                ),
                ElevatedButton(
                  onPressed: _game.gameOver ? null : _onHold,
                  child: const Text('Hold'),
                ),
              ],
            ),

            // New game + status
            // New game + status
Column(
  children: [
    OutlinedButton(
      onPressed: _onNewGame,
      child: const Text('New Game'),
    ),
    const SizedBox(height: 12),
    Text(
      _statusMessage(),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  ],
),

          ],
        ),
      ),
    );
  }

  Widget _buildPlayerPanel({
    required int playerNumber,
    required int score,
    required bool isCurrent,
  }) {
    return Card(
      elevation: isCurrent ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isCurrent
            ? const BorderSide(width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          children: [
            Text(
              'Player $playerNumber',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: isCurrent ? TextDecoration.underline : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 16),
            ),
            if (isCurrent) ...[
              const SizedBox(height: 4),
              const Text(
                '● Your turn',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

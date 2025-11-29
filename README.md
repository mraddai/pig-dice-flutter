

# Pig Dice Game (Flutter)

A simple implementation of the classic **Pig** dice game built with Flutter.

## 🎮 Rules

- Two players take turns.
- On your turn, you can **Roll** or **Hold**:
  - **Roll**:  
    - If you roll a **1**, your turn ends and you gain **0** points this turn.  
    - If you roll **2–6**, that value is added to your **turn total**, and you may roll again or hold.
  - **Hold**:  
    - Your **turn total** is added to your overall score.  
    - Your turn ends and the other player starts.
- First player to reach or exceed the target score (default: 50) wins.

## 🧱 Structure

- `lib/pig_game_state.dart` – pure Dart game logic (scores, roll/hold, winner).
- `lib/main.dart` – Flutter UI (buttons, score display, status text).

## 🚀 Run it

```bash
flutter pub get
flutter run -d chrome   # or: flutter run

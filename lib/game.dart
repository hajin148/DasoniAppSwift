import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'endgame.dart'; // Import the EndGame file

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int score = 0;
  int _questionTimer = 10; // Timer for each question
  bool _isCountdownComplete = false;
  bool _keysEnabled = true; // Controls whether piano keys are clickable
  String _countdownText = "3"; // Countdown text for 3 -> 2 -> 1 -> Start!
  late Timer _countdownTimer;
  late Timer _questionTimerTicker;
  String? _previousNote; // Tracks the last generated note to avoid repetition

  final AudioPlayer _audioPlayer = AudioPlayer();

  // List of notes
  final List<String> _notes = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  // Map notes to their positions on the staff
  final Map<String, double> _notePositions = {
    'C': 70.0,
    'D': 61.0,
    'E': 52.0,
    'F': 44.0,
    'G': 36.0,
    'A': 29.0,
    'B': 21.0,
  };

  // Map notes to their Korean names
  final Map<String, String> _noteKoreanNames = {
    'C': '도',
    'D': '레',
    'E': '미',
    'F': '파',
    'G': '솔',
    'A': '라',
    'B': '시',
  };

  // Map notes to their audio files
  final Map<String, String> _noteAudioFiles = {
    'C': 'ptdo.mp3',
    'D': 'ptre.mp3',
    'E': 'ptmi.mp3',
    'F': 'ptfa.mp3',
    'G': 'ptsol.mp3',
    'A': 'ptla.mp3',
    'B': 'ptsi.mp3',
  };

  // Map notes to piano keys
  final Map<String, String> _noteToKey = {
    'C': 'assets/key_c.png',
    'D': 'assets/key_d.png',
    'E': 'assets/key_e.png',
    'F': 'assets/key_f.png',
    'G': 'assets/key_g.png',
    'A': 'assets/key_a.png',
    'B': 'assets/key_b.png',
  };

  // Currently displayed note
  String _currentNote = '';

  // Message to display feedback
  String _message = "";

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    _questionTimerTicker.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  // Start the countdown
  void _startCountdown() {
    int countdownValue = 3;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownValue > 0) {
          _countdownText = countdownValue.toString();
          countdownValue--;
        } else if (countdownValue == 0) {
          _countdownText = "시작!";
          countdownValue--;
        } else {
          _countdownTimer.cancel();
          _isCountdownComplete = true;
          _startGame();
        }
      });
    });
  }

  // Start the game
  void _startGame() {
    _generateRandomNote();
    _startQuestionTimer();
  }

  // Start the question timer
  void _startQuestionTimer() {
    _questionTimerTicker = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_questionTimer > 0) {
          _questionTimer--;
        } else {
          _questionTimerTicker.cancel();
          _navigateToEndGame();
        }
      });
    });
  }

  // Navigate to EndGame screen
  void _navigateToEndGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EndGame(score: score), // Pass the final score
      ),
    );
  }

  // Generate a random note and play its sound
  void _generateRandomNote() {
    final random = Random();
    String newNote;

    // Ensure the new note is not the same as the previous one
    do {
      newNote = _notes[random.nextInt(_notes.length)];
    } while (newNote == _previousNote);

    setState(() {
      _currentNote = newNote;
      _previousNote = newNote; // Update the previous note
      _resetQuestionTimer();
      _keysEnabled = false; // Disable keys while the note sound plays
    });

    // Play the audio for the generated note
    _playNoteSound(_currentNote).then((_) {
      // Enable keys after 1 second
      Timer(const Duration(seconds: 1), () {
        setState(() {
          _keysEnabled = true;
        });
      });
    });
  }

  // Play the audio for a given note
  Future<void> _playNoteSound(String note) async {
    final filePath = _noteAudioFiles[note];
    if (filePath != null) {
      await _audioPlayer.play(AssetSource(filePath));
    }
  }

  // Reset the question timer to 10 seconds
  void _resetQuestionTimer() {
    setState(() {
      _questionTimer = 10;
    });
  }

  // Validate the user's key press
  void _validateKeyPress(String keyPressed) {
    if (!_keysEnabled) return; // Ignore clicks if keys are disabled

    String userTypedNote = _noteKoreanNames.entries
        .firstWhere((entry) => _noteToKey[entry.key] == keyPressed,
        orElse: () => MapEntry('', '')) // Handle invalid keys gracefully
        .value;

    if (_noteToKey[_currentNote] == keyPressed) {
      setState(() {
        score++;
        _message = '${_noteKoreanNames[_currentNote]}, 정답입니다!';
      });
      _generateRandomNote(); // Generate a new note
    } else {
      setState(() {
        _message = '$userTypedNote, 다시 시도해보세요';
      });
    }

    // Clear the message after 1 second
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _message = "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0,
        actions: [
          // Display the score
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '점수: $score',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png', // Path to your background image
              fit: BoxFit.cover,
            ),
          ),
          // Game Content
          Center(
            child: _isCountdownComplete
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Timer display
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '남은 시간',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$_questionTimer',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // Staff with a note
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Display the staff
                      Image.asset(
                        'assets/score.png',
                        width: 250,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      // Display the note
                      Positioned(
                        top: _notePositions[_currentNote] ?? 0.0,
                        child: Image.asset(
                          'assets/note.png',
                          width: 30,
                          height: 25,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                // Display feedback message below staff
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    _message,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Piano keyboard
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPianoKey('assets/key_c.png', 'C'),
                          _buildPianoKeyWithOverlay(
                            'assets/key_d.png',
                            'assets/key_cdb.png',
                            'D',
                          ),
                          _buildPianoKeyWithOverlay(
                            'assets/key_e.png',
                            'assets/key_deb.png',
                            'E',
                          ),
                          const SizedBox(width: 10),
                          _buildPianoKey('assets/key_f.png', 'F'),
                          _buildPianoKeyWithOverlay(
                            'assets/key_g.png',
                            'assets/key_fgb.png',
                            'G',
                          ),
                          _buildPianoKeyWithOverlay(
                            'assets/key_a.png',
                            'assets/key_gab.png',
                            'A',
                          ),
                          _buildPianoKeyWithOverlay(
                            'assets/key_b.png',
                            'assets/key_abb.png',
                            'B',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
                : Text(
              _countdownText,
              style: const TextStyle(
                  fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a piano key and validates when tapped
  Widget _buildPianoKey(String assetPath, String note) {
    return GestureDetector(
      onTap: _keysEnabled ? () => _validateKeyPress(assetPath) : null,
      child: Image.asset(
        assetPath,
        height: 100,
        fit: BoxFit.contain,
      ),
    );
  }

  /// Builds a piano key with an optional overlay (minor key)
  Widget _buildPianoKeyWithOverlay(
      String keyAsset, String overlayAsset, String note) {
    const overlayWidth = 50.0;
    return Stack(
      clipBehavior: Clip.none, // Ensures overlay is not clipped
      children: [
        _buildPianoKey(keyAsset, note), // White key
        Positioned(
          top: 0,
          left: -overlayWidth / 2, // Position black key overlay
          child: Image.asset(
            overlayAsset,
            height: overlayWidth,
            width: overlayWidth,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

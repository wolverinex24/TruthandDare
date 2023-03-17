import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Task Generator',
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en'),
        const Locale('es'),
        const Locale('fr'),
        const Locale('zh'),
      ],
      home: RandomTaskGenerator(),
    );
  }
}

class RandomTaskGenerator extends StatefulWidget {
  @override
  _RandomTaskGeneratorState createState() => _RandomTaskGeneratorState();
}

class _RandomTaskGeneratorState extends State<RandomTaskGenerator> {
  final Random _random = Random();
  final List<String> _tasks = [
    'Do 10 jumping jacks',
    'Sing a song in a funny voice',
    'Text your crush and say hello',
    'Speak with a foreign accent for the next 5 minutes',
    'Eat a tablespoon of hot sauce',
    'Do a silly dance',
    'Make a prank call to a friend',
    'Do a handstand',
    'Wear your shirt inside out',
    'Try to balance a spoon on your nose for 10 seconds',
    'Go outside and shout "I love ice cream" at the top of your lungs',
    'Do a cartwheel',
    'Tell a joke',
    'Take a selfie with a funny face',
    'Do the robot dance',
    'Put on a blindfold and draw a picture',
    'Sing a nursery rhyme in a deep voice',
    'Speak in slow motion for the next 5 minutes',
    'Stand on one foot for as long as you can',
    'Go to the nearest store and buy a candy bar using only pennies',
    'Do 5 push-ups',
    'Do a plank for 30 seconds',
    'Do a roundoff',
    'Wear your clothes backwards for the rest of the day',
    'Tell a funny story about yourself',
  ];
  Color _generatedColor = Colors.black;
  String? _generatedTask;
  bool _coinResult = false;
  bool _showTask = false;

  @override
  void initState() {
    super.initState();
    _generateTaskAndColor();
  }

  void _generateTaskAndColor() {
    String task = _tasks[_random.nextInt(_tasks.length)];
    Color color = Color.fromRGBO(
        _random.nextInt(256), _random.nextInt(256), _random.nextInt(256), 1);
    setState(() {
      _generatedTask = task;
      _generatedColor = color;
      _coinResult = _random.nextBool();
    });
  }

  void _toggleShowTask() {
    setState(() {
      _showTask = !_showTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Task Generator',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Task Generator'),
          backgroundColor: _generatedColor,
        ),
        body: Container(
          color: _generatedColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedButton(
                  text: 'How To Play?',
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      headerAnimationLoop: true,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'GUIDE',
                      desc:
                          "Toss a coin to determine if you'll receive a truth or dare task. Click 'Generate' to get a random task. If you choose truth, answer the question honestly. If you choose dare, perform the task.",
                    ).show();
                  },
                ),
                const SizedBox(
                  width: 10,
                  height: 16,
                ),
                if (_showTask)
                  Text(
                    _generatedTask!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _generateTaskAndColor();
                      _showTask = false;
                    });
                  },
                  child: Text('Generate'),
                ),
                SizedBox(height: 20),
                Text(
                  'Coin flip result: ${_coinResult ? "Heads" : "Tails"}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _generateTaskAndColor();
                      _showTask = true;
                    });
                  },
                  child: Text('Show Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

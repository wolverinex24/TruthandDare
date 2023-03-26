import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:test_myapp/customUserGame/customUsergame.dart';
import 'package:flutter/services.dart';
import 'customTruthDare/customtruthDareAdd.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
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
      routes: {
        '/': (context) => RandomTaskGenerator(),
        '/customAddDare': (context) => userAddedtruthDare(),
        '/Randi': (context) => UserRandomGame(),
      },
    );
  }
}

class RandomTaskGenerator extends StatefulWidget {
  @override
  _RandomTaskGeneratorState createState() => _RandomTaskGeneratorState();
}

class _RandomTaskGeneratorState extends State<RandomTaskGenerator>
    with TickerProviderStateMixin {
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
  bool _displayResult = true;
  bool _anim = true;
  TextEditingController _dareController = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _generateTaskAndColor();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
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
          title: Text('Truth And Dare'),
          backgroundColor: _generatedColor,
        ),
        body: Container(
          color: _generatedColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
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
                AnimatedButton(
                  width: 150,
                  pressEvent: () {
                    setState(() {
                      _generateTaskAndColor();
                      _showTask = false;
                      _displayResult = true;
                      _animationController.forward();
                      _animationController.repeat();
                    });
                  },
                  text: 'Flip The Coin',
                ),
                SizedBox(height: 20),
                Text(
                  _displayResult
                      ? 'Coin flip result: ${_coinResult ? "Heads" : "Tails"}'
                      : "",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 20),
                AnimatedButton(
                  width: 150,
                  pressEvent: () {
                    setState(() {
                      _animationController.stop();
                      _generateTaskAndColor();
                      _showTask = true;
                      _displayResult = false;
                    });
                  },
                  text: 'Show Task',
                ),
                SizedBox(
                  child: Lottie.asset(
                    'assets/23227-coin-flip-rupee.json',
                    controller: _animationController,
                    repeat: true,
                    reverse: true,
                  ),
                  height: 200,
                ),
                AnimatedButton(
                  width: 100,
                  text: 'How To Play?',
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      headerAnimationLoop: true,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'GUIDE',
                      desc:
                          "Toss a coin to determine if you'll receive a truth or dare task you win the toss choice is your if not your friends will decide . Click 'Show Task' to get a random task. If you choose truth, answer the question honestly. If you choose dare, perform the task.",
                    ).show();
                  },
                ),
                SizedBox(height: 5),
                AnimatedButton(
                  width: 200,
                  pressEvent: () {
                    setState(() {
                      Navigator.pushNamed(context, '/customAddDare');
                    });
                  },
                  text: 'Add custom Dare',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

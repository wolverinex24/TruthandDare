import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:test_myapp/customUserGame/CustomListDare.dart';

import 'package:test_myapp/customTruthDare/customtruthDareAdd.dart';

class UserRandomGame extends StatefulWidget {
  @override
  _UserRandomGame createState() => _UserRandomGame();
}

class _UserRandomGame extends State<UserRandomGame>
    with TickerProviderStateMixin {
  final Random _random = Random();
  final _tasks = userAddedtruthDare.textList;
  Color _generatedColor = Colors.black;
  String? _generatedTask;
  bool _coinResult = false;
  bool _showTask = false;
  bool _displayResult = true;
  String task = "";
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
    if (_tasks.isNotEmpty) {
      task = _tasks[_random.nextInt(_tasks.length)];
    } else {
      print("error");
    }
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
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              setState(() {
                Navigator.pushNamed(context, '/');
              });
            },
          ),
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
                          "Toss a coin to determine if you'll receive a truth or dare task. Click 'Generate' to get a random task. If you choose truth, answer the question honestly. If you choose dare, perform the task.",
                    ).show();
                  },
                ),
                SizedBox(height: 5),
                AnimatedButton(
                  width: 200,
                  pressEvent: () {
                    setState(() {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/customAddDare', (route) => false);
                    });
                  },
                  text: 'Edit custom Dare',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

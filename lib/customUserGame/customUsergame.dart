import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:test_myapp/customUserGame/CustomListDare.dart';

import '../customTruthDare/customtruthDareAdd.dart';

class UserRandomGame extends StatefulWidget {
  @override
  _UserRandomGame createState() => _UserRandomGame();
}

class _UserRandomGame extends State<UserRandomGame> {
  final Random _random = Random();
  List<String> _tasks = ["hdahdkjad"];

  Color _generatedColor = Colors.black;
  String? _generatedTask;
  bool _coinResult = false;
  bool _showTask = false;
  bool _displayResult = true;
  TextEditingController _dareController = TextEditingController();

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
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _generateTaskAndColor();
                      _showTask = false;
                      _displayResult = true;
                    });
                  },
                  child: Text('Flip The Coin'),
                ),
                SizedBox(height: 20),
                Text(
                  _displayResult
                      ? 'Coin flip result: ${_coinResult ? "Heads" : "Tails"}'
                      : "",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _generateTaskAndColor();
                      _showTask = true;
                      _displayResult = false;
                    });
                  },
                  child: Text('Show Task'),
                ),
                SizedBox(
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
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, '/customAddDare');
                    });
                  },
                  child: Text('Add custom Dare'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
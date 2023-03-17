import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(RandomNameGenerator());
}

class RandomNameGenerator extends StatefulWidget {
  @override
  _RandomNameGeneratorState createState() => _RandomNameGeneratorState();
}

class _RandomNameGeneratorState extends State<RandomNameGenerator> {
  final Random _random = Random();
  final List<String> _adjectives = [
    'Adventurous',
    'Brave',
    'Clever',
    'Energetic',
    'Friendly',
    'Happy',
    'Intelligent',
    'Joyful',
    'Kind',
    'Lively',
    'Nimble',
    'Optimistic',
    'Pleasant',
    'Quick',
    'Reliable',
    'Strong',
    'Trustworthy',
    'Vibrant',
    'Witty',
    'Zealous',
  ];
  final List<String> _nouns = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Emily',
    'Frank',
    'Grace',
    'Henry',
    'Isabel',
    'Jack',
    'Katherine',
    'Liam',
    'Maggie',
    'Nathan',
    'Olivia',
    'Peter',
    'Quinn',
    'Rachel',
    'Sarah',
    'Thomas',
    'Uma',
    'Victoria',
    'William',
    'Xander',
    'Yasmine',
    'Zoe',
  ];
  Color _generatedColor = Colors.black;
  String _generatedName = '';
  String _coinFlipResult = '';

  @override
  void initState() {
    super.initState();
    _generateNameAndColor();
  }

  void _generateNameAndColor() {
    String adjective = _adjectives[_random.nextInt(_adjectives.length)];
    String noun = _nouns[_random.nextInt(_nouns.length)];
    Color color = Color.fromRGBO(
        _random.nextInt(256), _random.nextInt(256), _random.nextInt(256), 1);
    String coinFlipResult = _random.nextBool() ? 'Heads' : 'Tails';
    setState(() {
      _generatedName = '$adjective $noun';
      _generatedColor = color;
      _coinFlipResult = coinFlipResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Name Generator',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Name Generator'),
          backgroundColor: _generatedColor,
        ),
        body: Container(
          color: _generatedColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _generatedName,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _generateNameAndColor,
                  child: Text('Generate'),
                ),
                SizedBox(height: 40),
                Text(
                  'Coin flip result: $_coinFlipResult',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

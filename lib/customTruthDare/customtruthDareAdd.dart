import 'dart:math';

import 'package:flutter/material.dart';

class userAddedtruthDare extends StatefulWidget {
  @override
  _userAddedtruthDare createState() => _userAddedtruthDare();
}

class _userAddedtruthDare extends State<userAddedtruthDare> {
  static List<String> _textList = [];

  final TextEditingController _textController = TextEditingController();

  void _addTextToList() {
    setState(() {
      _textList.add(_textController.text);
      _textController.clear();
    });
  }

  Color _generatedColor = Colors.black;
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Add Custom Dare '),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter some text',
            ),
          ),
          ElevatedButton(
            onPressed: _addTextToList,
            child: Text('Add Dare'),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                Navigator.pushNamed(context, '/Randi');
              });
            },
            child: Text('Start custom dare game'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _textList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _textList[index],
                    style: TextStyle(
                      color: _generateColor(),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _generateColor() {
    Color color = Color.fromRGBO(
        _random.nextInt(256), _random.nextInt(256), _random.nextInt(256), 1);

    _generatedColor = color;
    return _generatedColor;
  }
}

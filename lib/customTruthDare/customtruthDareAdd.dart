import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class userAddedtruthDare extends StatefulWidget {
  static List<String> textList = [];
  @override
  _userAddedtruthDare createState() => _userAddedtruthDare();
}

class _userAddedtruthDare extends State<userAddedtruthDare> {
  final TextEditingController _textController = TextEditingController();

  void _addTextToList() {
    setState(() {
      userAddedtruthDare.textList.add(_textController.text);
      _textController.clear();
    });
  }

  Color _generatedColor = Colors.black;
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Add Custom Dare '),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              controller: _textController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter some text',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AnimatedButton(
            width: 100,
            pressEvent: _addTextToList,
            text: 'Add Dare',
          ),
          SizedBox(
            height: 10,
          ),
          AnimatedButton(
            width: 200,
            pressEvent: () {
              setState(() {
                Navigator.pushNamed(context, '/Randi');
              });
            },
            text: 'Start custom dare game',
          ),
          SizedBox(
            height: 10,
          ),
          AnimatedButton(
            width: 150,
            pressEvent: () {
              userAddedtruthDare.textList = [];
              setState(() {
                Navigator.pushNamed(context, '/customAddDare');
              });
            },
            text: 'DELETE ALL DARES',
          ),
          SizedBox(
            height: 10,
          ),
          AnimatedButton(
            width: 150,
            pressEvent: () {
              userAddedtruthDare.textList = [];
              setState(() {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              });
            },
            text: 'Cancel',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userAddedtruthDare.textList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    userAddedtruthDare.textList[index],
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

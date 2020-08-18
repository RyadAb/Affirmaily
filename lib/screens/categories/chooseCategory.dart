import 'package:Affirmation/screens/categories/categories.dart';
import 'package:flutter/material.dart';

class ChooseCategory extends StatefulWidget {
  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/home');
          },
        ),
        title: Text('Categories'),
        centerTitle: true,
        backgroundColor: Colors.redAccent[700],
      ),
      body: Categories(),
    );
  }
}

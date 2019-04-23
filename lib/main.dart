import 'package:flutter/material.dart';
import 'package:test_app/checklist.dart';
import 'package:test_app/utils/dummyData.dart';

void main() => {
  // debugPaintSizeEnabled = true,
  runApp(MyApp()),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHECKLIST',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: CheckList(dummyTaskList),
    );
  }
}

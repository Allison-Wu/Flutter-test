import 'package:flutter/material.dart';
import 'package:test_app/Login/login.dart';
import 'package:test_app/checklist.dart';
import 'package:test_app/new-task.dart';
import 'package:test_app/utils/dummyData.dart';

class Routes {
  static const String checkListRoute = '/checklist';
  static const String newTaskRoute = '/newTask';
  static const String loginRoute = '/login';

  Routes() {
    runApp(
      new MaterialApp(
        // debugShowCheckedModeBanner: false,
        // debugPaintSizeEnabled = true,
        title: 'CHECKLIST',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Login(),
        routes: {
          checkListRoute: (context) => CheckList(dummyTaskList),
          newTaskRoute: (context) => AddTaskPage(),
        },
      ),
    );
  }
}

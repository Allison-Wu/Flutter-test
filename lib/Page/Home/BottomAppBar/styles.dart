import 'package:flutter/material.dart';
import 'package:test_app/Page/Home/Account/account.dart';
import 'package:test_app/Page/Home/BottomAppBar/type.dart';
import 'package:test_app/new-task.dart';

final Color tabColor = Colors.grey;
final Color selectedTabColor = Color.fromRGBO(173, 216, 230, 1);
final Color bottomBarColor = Colors.grey[100];
final double iconSize = 30;
final double textSize = 15;

final List<BottomAppBarItem> bottomTabList = [
  BottomAppBarItem(iconData: Icons.home, text: 'aaaa', page: AddTaskPage()),
  BottomAppBarItem(iconData: Icons.access_alarm, text: 'bbb', page: AddTaskPage()),
  BottomAppBarItem(iconData: Icons.fast_rewind, text: 'ccc', page: AddTaskPage()),
  BottomAppBarItem(iconData: Icons.supervised_user_circle, text: 'Account', page: Account()),
];

final List<BottomNavigationBarItem> tabItems =
  List.generate(bottomTabList.length, (int index) {
    BottomAppBarItem item = bottomTabList[index];
    return BottomNavigationBarItem(
      icon: Icon(item.iconData, color: tabColor),
      title: Text(item.text, style: TextStyle(color: tabColor, fontSize: textSize)),
      activeIcon: Icon(item.iconData, color: selectedTabColor),
    );
  });

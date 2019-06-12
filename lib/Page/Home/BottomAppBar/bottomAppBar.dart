import 'package:flutter/material.dart';
import 'package:test_app/Page/Home/BottomAppBar/styles.dart';

class Home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<Home>{
  int _selectedIndex = 0;

  void _updateIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomTabList[_selectedIndex].page,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Container(
      //   width: 70.0,
      //   height: 70.0,
      //   child: FloatingActionButton(
      //     onPressed: () { },
      //     tooltip: 'Increment',
      //     child: Icon(Icons.add, size: iconSize,),
      //   ),
      // ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: bottomBarColor),
        child: BottomNavigationBar(
          fixedColor: selectedTabColor,
          type: BottomNavigationBarType.fixed,
          items: tabItems,
          currentIndex: _selectedIndex,
          onTap: _updateIndex,
          iconSize: iconSize,
        ),
      ),
    );
  }

}

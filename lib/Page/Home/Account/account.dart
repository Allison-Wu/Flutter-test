import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<Account>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          _accountInfo(),
        ],
      ),
    );
  }

  Widget _accountInfo() => Container(
    height: 200,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: FractionalOffset(0.0, 0.0),
        end:  FractionalOffset(0.0, 1.0),
        colors: [
          Color.fromRGBO(0, 38, 230, 0.5),
          Color.fromRGBO(173, 216, 230, 0.5),
        ],
        stops: [0.7, 1.0],
      ),
    ),
    child: Row(
      children: <Widget>[
        _avatar()
      ],
    ),
  );

  Widget _avatar() => Stack(
    alignment: const Alignment(0.6, 0.6),
    children: [
      CircleAvatar(
        backgroundImage: AssetImage('images/login.jpg'),
        radius: 50,
      ),
    ],
  );

}

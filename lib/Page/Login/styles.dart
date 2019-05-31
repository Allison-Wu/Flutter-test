import 'package:flutter/material.dart';

DecorationImage backgroundImage = new DecorationImage(
  image: new ExactAssetImage('images/login.jpg'),
  fit: BoxFit.cover,
);

DecorationImage signIcon = new DecorationImage(
  image: new ExactAssetImage('images/sign-icon.png'),
  fit: BoxFit.cover,
);

Widget backgroundPage(Widget child) {
  return Container(
      decoration: new BoxDecoration(
        image: backgroundImage,
      ),
      child: new Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.0),
            end:  FractionalOffset(0.0, 1.0),
            colors: [
              Color.fromRGBO(202, 225, 255, 0.6),
              Color.fromRGBO(150, 205, 205, 0.4),
            ],
            stops: [0.4, 1.0],
          ),
        ),
        child: child,
      ),
    );
}

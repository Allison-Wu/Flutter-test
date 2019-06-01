import 'package:flutter/material.dart';

Widget loadingPage() {
  return Stack(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(bottom: 35),
        child: Center(
          child: CircularProgressIndicator(
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 70),
        child: Center(
          child: Text('Please wait. Lodaing...'),
        ),
      ),
    ],
  );
}

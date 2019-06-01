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

Widget bannerIcon() {
  return Container(
    width: 150.0,
    height: 150.0,
    alignment: Alignment.center,
    decoration: new BoxDecoration(
      image: signIcon,
    ),
  );
}

Widget inputText({IconData icon, String hint, bool boscure = false, ValueChanged<String> onChange, TextInputAction textInputAction}) {
  return Container(
    decoration: new BoxDecoration(
      border: new Border(
        bottom: new BorderSide(
          width: 0.5,
          color: Colors.white70,
        ),
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 30,),
    child: TextField(
      onChanged: onChange,
      onSubmitted: onChange,
      obscureText: boscure,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.only(
            top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
      ),
    ),
  );
}

Widget radiusButton({VoidCallback onPressed, String text}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    width: 300,
    child: RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      color: Color.fromRGBO(173, 216, 230, 1),
      textColor: Colors.white,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
      onPressed: onPressed,
    ),
  );
}

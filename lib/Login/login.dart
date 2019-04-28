import 'package:flutter/material.dart';
import 'package:test_app/Login/styles.dart';
import 'package:test_app/Routes.dart';

class Login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login>{

  void _toggleLogin() {
    Navigator.of(context).pushNamed(Routes.checkListRoute);
  }

  Widget _loginButton() {
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
          'Sign in',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          ),
        ),
        onPressed: _toggleLogin,
      ),
    );
  }

  Widget _signIcon() {
    return Container(
      width: 150.0,
      height: 150.0,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        image: signIcon,
      ),
    );
  }

  Widget _buildInputText(IconData icon, String hint, bool boscure) {
    return Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            width: 0.5,
            color: Colors.white70,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        obscureText: boscure,
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

  Widget _formContainer() {
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInputText(Icons.person_outline, 'User', false),
          _buildInputText(Icons.lock_outline, 'Password', true)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: new ListView(
          padding: const EdgeInsets.symmetric(vertical: 130),
          children: <Widget>[
            new Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _signIcon(),
                    _formContainer(),
                    _loginButton(),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

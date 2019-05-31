import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Page/Login/styles.dart';
import 'package:test_app/Page/Utils/lodaing.dart';
import 'package:test_app/Routes.dart';
import 'package:test_app/State/login.dart';

class Login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login>{

  void _toggleLogin() async {
    LoginState state = Provider.of<LoginState>(context);
    print(state.username);
    print(state.password);
    await state.fetchToken();
    if (state.errorMessage.isEmpty && state.token.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed(Routes.checkListRoute);
    }
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

  Widget _buildInputText({IconData icon, String hint, bool boscure = false, ValueChanged<String> onChange, TextInputAction textInputAction}) {
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

  Widget _formContainer(){
    LoginState state = Provider.of<LoginState>(context);
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInputText(
            icon: Icons.person_outline,
            onChange: state.setUsername,
            hint: 'Username',
            boscure: false,
            textInputAction: TextInputAction.next,
          ),
          _buildInputText(
            icon: Icons.lock_outline,
            onChange: state.setPassword,
            hint: 'Password',
            boscure: true,
            textInputAction: TextInputAction.done,
          ),
          Text(state.errorMessage.isEmpty ? '' : state.errorMessage, style: TextStyle(color: Colors.red, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _loginContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 130),
      children: <Widget>[
        new Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _signIcon(),
                _formContainer(),
                _loginButton(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundPage(
        Provider.of<LoginState>(context).isFetching ? loadingPage() : this._loginContent()
        ),
    );
  }
}

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
    await state.fetchToken();
    if (state.errorMessage.isEmpty && state.token.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed(Routes.checkListRoute);
    }
  }

  Widget _formContainer(){
    LoginState state = Provider.of<LoginState>(context);
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          inputText(
            icon: Icons.person_outline,
            onChange: state.setUsername,
            hint: 'Username',
            boscure: false,
            textInputAction: TextInputAction.next,
          ),
          inputText(
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
                bannerIcon(),
                _formContainer(),
                radiusButton(onPressed: _toggleLogin, text: 'Sign in'),
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

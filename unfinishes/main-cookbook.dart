import 'package:flutter/material.dart';
// import './cookBook.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final Map<String, MaterialPageRoute> _titleMap = {
  //   'cookBook': new cookBook(),
  // };

  // cookBook UI
  Widget _textColumn(text) {
    return new Container(
      child: new Text(
        text,
        softWrap: true,
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: Colors.black54,
          fontSize: 20.0,
        ),
      ),
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.blue[200],
      ),
    );
  }
  // cookBook UI

  void _navigator() {
    Navigator.of(context).push(
      new MaterialPageRoute(
      // *************cookbook
      builder: (BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: Text('cookBook'),
        ),
        body:  new Row(
          children: <Widget>[
            new Row(
              // one column
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    _textColumn('Strawberry Pavlova'),
                    _textColumn(
                      'I don\' want to type. I don\' want to type. I don\' want to type. '
                      'I don\' want to type. I don\' want to type. I don\' want to type. '
                      'I don\' want to type. I don\' want to type. I don\' want to type. '
                      'I don\' want to type. I don\' want to type. I don\' want to type. '
                      'I don\' want to type. I don\' want to type. I don\' want to type. '),
                  ],
                )
              ],
              // one column
            ),
          ],
        ),
      );
      }
      // *************cookbook
      )
    );
  }

  Widget _buildRow(String title) {
    // var route = _titleMap[title];
    return ListTile(
      title:Text(
        title,
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: _navigator,
    );
  }

  List<Widget> _buildRowList(List<String> titles) {
    List<Widget> _rowList = [];
    titles.forEach((title) => {
      _rowList.addAll([_buildRow(title), new Divider()]),
    });
    return _rowList;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titles = ['cookBook'];
    return Scaffold(
    appBar: new AppBar(
      title: Text('My Home Page'),
    ),
    body: ListView(
      padding: const EdgeInsets.all(16.0),
      children: _buildRowList(titles),
    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import './cookBook.dart';

void main() => {
  debugPaintSizeEnabled = true,
  runApp(MyApp()),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    Column _buildIconItem(Color itemColor, IconData icon, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: itemColor,
          ),
          Container(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                color: itemColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );
    }

    Widget _iconSection = Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildIconItem(color, Icons.call, 'CALL'),
            _buildIconItem(color, Icons.near_me, 'ROUTE'),
            _buildIconItem(color, Icons.share, 'SHARE'),
          ],
      ),
    );

    Widget _titleSection = Container(
    padding: EdgeInsets.all(32),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                  'Kandersteg, Switzweland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
            ],
          ),
        ),
        Icon(Icons.star, color:Colors.red[500]),
        Text('41'),
      ],
    ),
    );

    Widget _textSection = Container(
      padding: EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    // material App
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: new AppBar(
          title: Text('traveral description'),
        ),
        body: ListView(
          children: <Widget>[
            Image.asset(
              'images/dog.jpg',
              fit: BoxFit.fitWidth,
            ),
            _titleSection,
            _iconSection,
            _textSection,
          ],
        ),
      ),
    );
  }
}

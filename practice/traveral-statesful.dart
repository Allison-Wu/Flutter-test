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
            FavoriteWidget(),
            _iconSection,
            _textSection,
          ],
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _favoriteWidget createState() => _favoriteWidget();
}

class _favoriteWidget extends State<FavoriteWidget> {
  bool _isFavorite = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      _favoriteCount =_favoriteCount + (_isFavorite ? -1 : 1);
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          IconButton(
            icon: _isFavorite ? Icon(Icons.star) :Icon(Icons.star_border),
            color:Colors.red[500],
            onPressed: _toggleFavorite,
          ),
          Text('$_favoriteCount'),
        ],
      ),
    );
  }

}

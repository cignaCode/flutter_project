import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
        accentColor: Colors.orange
      ),
      home: new LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget{
  const LandingPage({ Key key }) : super(key: key);

  @override
  _LandingPageState createState() => new _LandingPageState();

}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin{
  int _currentIndex = 0;

  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.favorite),
        title: 'Favorites',
        color: Colors.orange,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.train),
        title: 'Rail',
        color: Colors.blue,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.directions_bus),
        title: 'Bus',
        color: Colors.green,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.subway),
        title: 'Subway',
        color: Colors.lightBlue,
        vsync: this,
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews)
      view.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("MySepta"),
      ),
      drawer: new Drawer(
        child: new Column(
          // This makes each child fill the full width of the screen
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              child: new Image.network(
                'http://img.grouponcdn.com/deal/0be87e56d76b4fc78fe627b7fce14c29/29/v1/c700x420.jpg',
                fit: BoxFit.fill,
              ),
              height: 170.0,
            ),
            new Expanded(
                child: new ListView(
                  children: <Widget>[
                    new ListTile(
                      leading: new Icon(Icons.home),
                      title: new Text("Home"),
                    ),
                    new ListTile(
                      leading: new Icon(Icons.add_alert),
                      title: new Text("Alerts & Detours"),
                    ),
                    new ListTile(
                      leading: new Icon(Icons.message),
                      title: new Text("Talk to the Developer"),
                    ),new ListTile(
                      leading: new Icon(Icons.dashboard),
                      title: new Text("Septa's Twitter"),
                    ),
                    new ListTile(
                      leading: new Icon(Icons.settings),
                      title: new Text("Settings"),
                    )
                  ],
                )
            ),
            new Material(
              child: new Container (
                  padding: new EdgeInsets.all(0.0),
                  height: 90.0,
                  child: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Container(
                              child: new Icon(Icons.share),
                              padding: new EdgeInsets.all(15.0),
                            ),
                            new Container(
                              child: new Text("Share"),
                              padding: new EdgeInsets.symmetric(horizontal: 20.0),
                            )

                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Container(
                              child: new Icon(Icons.book),
                              padding: new EdgeInsets.symmetric(horizontal: 15.0),
                            ),
                            new Container(
                              child: new Text("About"),
                              padding: new EdgeInsets.symmetric(horizontal: 20.0),
                            )

                          ],
                        )
                      ]
                  )
              ),
              elevation: 20.0,
            )
          ],
        )
      ),
      body: new Column(
        // This makes each child fill the full width of the screen
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container (
              padding: new EdgeInsets.all(8.0),
              color: new Color(0X33000000),
              child: new Text('Subtitle')
          ),
          new Expanded(
            child: new Container(
              padding: new EdgeInsets.all(0.0),
              color: new Color(0X9900CC00),
              child: new Column(
                children: <Widget>[
                  new Text("data here"),
                  new Text("more data|")
                ],
              ),
            ),
          ),
          new Container (
            padding: new EdgeInsets.all(8.0),
            color: new Color(0X99CC0000),
            height: 48.0,
            child: new Center(
              child: new Text('Bottom Banner'),
            ),
          )
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: _navigationViews
            .map((NavigationIconView navigationView) => navigationView.item)
            .toList(),
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _navigationViews[_currentIndex].controller.reverse();
            _currentIndex = index;
            _navigationViews[_currentIndex].controller.forward();
          });
        },
      )
    );
  }
}


/*
* Implementation provided by Flutter examples
* */
class NavigationIconView {
  NavigationIconView({
    Widget icon,
    String title,
    Color color,
    TickerProvider vsync,
  }) : _icon = icon,
        _color = color,
        _title = title,
        item = new BottomNavigationBarItem(
          icon: icon,
          title: new Text(title),
          backgroundColor: color,
        ),
        controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.bounceIn),
    );
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate(_animation),
        child: new IconTheme(
          data: new IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: new Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}

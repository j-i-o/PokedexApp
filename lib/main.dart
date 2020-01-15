import 'package:flutter/material.dart';
import 'package:pokedex_app/UI/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            textTheme: TextTheme(
              title: TextStyle(color: Color(0xFFf5eaea), fontSize: 20),
            ),
            actionsIconTheme: IconThemeData(
              color: Color(0xFFf5eaea),
            ),
            iconTheme: IconThemeData(
              color: Color(0xFFf5eaea),
            ),
          ),
          canvasColor: Color(0xFF4d4646),
          accentColor: Color(0xFF7fcd91),
          textTheme: TextTheme(
            subhead: TextStyle(color: Color(0xFFf5eaea)),
            caption: TextStyle(color: Color(0xFFf5eaea)),
          )),
      home: HomePage(),
    );
  }
}

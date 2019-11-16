import 'package:flutter/material.dart';
import 'ThemeData.dart';

//import 'old_register.dart';
//import 'new_register.dart';

class SA extends StatefulWidget {
  const SA({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SAState();
}

class _SAState extends State<SA> {

  bool darkThemeEnabled = false;

  String newValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkThemeEnabled ? ThemeData.dark() : buildThemeData(),
        home: home());
  }

  Widget home() {
    Widget child;
     {
      child = SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            Align(
              child:  Text ("Contact to SA for more information."
              ),
            )
          ],
        ),
      );
    }
    return new Container(child: child);
  }

}

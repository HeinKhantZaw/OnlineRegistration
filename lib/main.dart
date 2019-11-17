import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter_app/model/old_register.dart';
import 'package:flutter_app/model/raised_button.dart';
import 'SA.dart';
import 'ThemeData.dart';
import 'package:flutter/material.dart';
import 'model/Form1.dart';
import 'model/new_register.dart';
void main() => runApp(new MyApp());

String username = '';
String time = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildThemeData(),
      debugShowCheckedModeBanner: false,
      title: 'UIT Registration',
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/AdminPage': (BuildContext context) => new Form1(
            time: time
        ),
        '/MemberPage': (BuildContext context) =>
        new Form1(username: username, time: time),
        '/MyHomePage': (BuildContext context) => new MyHomePage(),
        '/status': (BuildContext context) => new SA(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Stack(
        children: <Widget>[
          Align(
            child: Scaffold(
              resizeToAvoidBottomPadding: false,
              appBar: AppBar(
                title: Text("Login"),
              ),
              body: Container(
                decoration: new BoxDecoration(color: Colors.white),
//        margin: EdgeInsets.all(30),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      KRaisedButton(
                        radius: 30.0,
                        color: Colors.teal,
                        text: 'Old Student',
                        textColor: Colors.white,
                        textFontWeight: FontWeight.bold,
                        onPressed: _loginOld,
                      ),
                      const SizedBox(height: 16.0),
                      KRaisedButton(
                        radius: 30.0,
                        color: Colors.teal,
                        text: 'New Student',
                        textColor: Colors.white,
                        textFontWeight: FontWeight.bold,
                        onPressed: _loginNew,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConnectionStatusBar(),
          ),
        ],
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  void _loginNew() async {

    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new new_register();
    }));

  }

  void _loginOld() async {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new old_register();
    }));
  }
}

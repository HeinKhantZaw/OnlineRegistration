import 'package:flutter_app/SA.dart';
import 'ErrorInfo.dart';
import 'background.dart';
import 'ThemeData.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'model/Form1.dart';
import 'model/new_register.dart';
import 'model/old_register.dart';

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
        '/AdminPage': (BuildContext context) => new Form1(time: time),
        '/MemberPage': (BuildContext context) =>
            new Form1(username: username, time: time),
        '/MyHomePage': (BuildContext context) => new MyHomePage(),
        '/status': (BuildContext context) => new SA(),
        '/login': (BuildContext context) => new LoginPage(),
        '/error': (BuildContext context) => new ErrorInfo(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void loginNew() async {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new new_register();
    }));
  }

  void loginOld() async {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return new old_register();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Background(),
        
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.3),
          ),
          Column(
            children: <Widget>[
              ///holds email header and inputField
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 10),
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 50),
                          child: Row(
                            children: <Widget>[],
                          ))
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 350),
              ),

              CustomButton(onPressed: () {
                loginNew();
              }),

              Padding(
                padding: EdgeInsets.only(bottom: 30),
              ),
              CustomButton1(onPressed: () {
                loginOld();
              }),
            ],
          )
        ],
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({@required this.onPressed});

  List<Color> gradient = [
    Color(0xFF0EDED2),
    Color(0xFF03A0FE),
  ];
  String title = 'New Student';
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext mContext) {
    return RawMaterialButton(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Stack(
          alignment: Alignment(0.0, 0.0),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(mContext).size.width / 1.7,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}

class CustomButton1 extends StatelessWidget {
  CustomButton1({@required this.onPressed});

  List<Color> gradient = [
    Color(0xFFFF80AB),
    Color(0xFFFF4081),
  ];
  String title = 'Old Student';
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext mContext) {
    return RawMaterialButton(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Stack(
          alignment: Alignment(0.0, 0.0),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(mContext).size.width / 1.7,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter_app/SA.dart';
import 'package:flutter_app/model/raised_button.dart';
import 'ThemeData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/Form1.dart';
import 'package:flutter_app/main.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildThemeData(),
      debugShowCheckedModeBanner: false,
      title: 'UIT Registration',
      home: new LoginPage(),
      routes: <String, WidgetBuilder>{
        '/AdminPage': (BuildContext context) => new Form1(time: time),
        '/MemberPage': (BuildContext context) => new Form1(username: username, time: time),
        '/LoginPage': (BuildContext context) => new LoginPage(),
        '/status': (BuildContext context) => new SA(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  Future<List> _login() async {
    final response = await http.post("https://unireg.000webhostapp.com//Get.php", body: {
      "Name": user.text,
      "uno": pass.text,
    });
    final duration = await http.post("https://unireg.000webhostapp.com//getTime.php");
    var getTime = json.decode(duration.body);
    var dataUser = json.decode(response.body);
    time = getTime[0]['end_date'];

    if (dataUser.length == 0) {
      Navigator.pushReplacementNamed(context, '/AdminPage');
    } else {
      if (dataUser[0]['status'] == '0') {
        username = dataUser[0]['Name'];
        Navigator.pushReplacementNamed(context, '/MemberPage');
      } else{
//        Container(
//          decoration: new BoxDecoration(color: Colors.white),
//        margin: EdgeInsets.all(30),
//          padding: const EdgeInsets.all(8.0),
//          child: Center(
//            child: Column(children: <Widget>[
//              new Padding(padding: EdgeInsets.only(top: 20.0)),
//              new Text("Contact to Student Affairs"),
//            ]),
//          ),
//        );
        Navigator.pushReplacementNamed(context, '/status');
      }
    }
    return dataUser;
  }

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
                      new Padding(padding: EdgeInsets.only(top: 20.0)),
                      new TextFormField(
                        controller: user,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.black)),

                          labelText: "Username",
                          prefixIcon: const Icon(
                            Icons.person,
                          ),
                          fillColor: Colors.black,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
//                child: Text('Hello World!'),
                      ),
                      new TextFormField(
                        controller: pass,
                        obscureText: true,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: "Uni ID",
                          prefixIcon: const Icon(
                            Icons.remove_red_eye,
                          ),
                          fillColor: Colors.black,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
//                child: Text('Hello World!'),
                      ),
                      KRaisedButton(
                        radius: 30.0,
                        color: Colors.teal,
                        text: 'Login',
                        textColor: Colors.white,
                        textFontWeight: FontWeight.bold,
                        onPressed: _login,
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
}
import 'dart:async';
import 'dart:convert';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter_app/model/raised_button.dart';

import 'ThemeData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AdminPage.dart';
import 'MemberPage.dart';
import 'model/Form1.dart';

void main() => runApp(new MyApp());

String username = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildThemeData(),
      debugShowCheckedModeBanner: false,
      title: 'Login Localhost',
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/AdminPage': (BuildContext context) => new MemberPage(
          username: username,
        ),
        '/MemberPage': (BuildContext context) => new Form1(username: username),
        '/MyHomePage': (BuildContext context) => new MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response =
    await http.post("https://unireg.000webhostapp.com//get.php", body: {
      "Name": user.text,
      "NRC": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['Name'] == 'Zaw') {
        Navigator.pushReplacementNamed(context, '/AdminPage');
      } else if (datauser[0]['Name'] == 'ZawZaw') {
        Navigator.pushReplacementNamed(context, '/MemberPage');
      }

      setState(() {
        username = datauser[0]['Name'];
      });
    }

    return datauser;
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
//
//              new InkWell(
//                  onTap: () {},
//                  child: new Theme(
//                      data: new ThemeData(
//                          primaryColor: Colors.yellow,
//                          primaryColorDark: Colors.red,
//                          hintColor: Colors.yellow
//
//                      ),
//
//                      child: new TextField(
//                        decoration: new InputDecoration(
//
//                            border: new OutlineInputBorder(),
//                            hintText: 'Tell us about yourself',
//                            helperText: 'Keep it short, this is just a demo.',
//                            labelText: 'Life story',
//                            prefixIcon: const Icon(Icons.person, color: Colors.green,),
//                            prefixText: ' ',
//                            suffixText: 'USD',
//                            suffixStyle: const TextStyle(color: Colors.green)),
//                      )
//                  )
//              ),

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
                          labelText: "Password",
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

                      Text(
                        msg,
                        style: TextStyle(fontSize: 20.0, color: Colors.red),
                      )
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
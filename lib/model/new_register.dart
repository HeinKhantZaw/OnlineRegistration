import 'dart:convert';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/validation/burmeseRegEx.dart';
import 'CustomDialog.dart';
import '../ThemeData.dart';
import '../widgets/widgets.dart';
import '../NRC_db/getNRC.dart';
import 'package:http/http.dart' as http;

class new_register extends StatefulWidget {
  const new_register({Key key, String username, String time}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<new_register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userName = '';
  String password = '';
  getNRC nrc = getNRC();
  bool darkThemeEnabled = false;
  burmeseRegEx regEx = new burmeseRegEx();

  TextEditingController name = new TextEditingController();
  TextEditingController fatherName = new TextEditingController();

  Future<List> _login() async {
    final response =
        await http.post("https://unireg.000webhostapp.com//GetNew.php", body: {
      "Name": name.text,
      "uno": fatherName.text,
    });
    final duration =
        await http.post("https://unireg.000webhostapp.com//getTime.php");

    var getTime = json.decode(duration.body);
    time = getTime[0]['end_date'];
    var dataUser = json.decode(response.body);
    if (dataUser.length == 0) {
      Navigator.pushReplacementNamed(context, '/error');
    } else {
      if (dataUser[0]['status'] == '0') {
        userName = dataUser[0]['username'];
        password = dataUser[0]['password'];
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            title: "Success",
            description: "Username :" + userName + "\nPassword :" + password, buttonText: "OK",
          ),
        );
      } else {
        Navigator.pushReplacementNamed(context, '/status');
      }
    }
    return dataUser;
  }

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
      home: home(),
    );
  }

  Widget home() {
    Widget child;
    child = SafeArea(
      top: false,
      child: Stack(
        children: <Widget>[
          Align(
            child: Scaffold(
                appBar: AppBar(title: Text('New Student Registration')),
                body: SingleChildScrollView(
                  child: new Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                              labelText: 'နာမည်',
                              hintText: 'မောင်/မ',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'နာမည်ထည့်ရန်လိုသည်';
                              } else if (regEx.validateMmInput(value)) {
                                return 'မြန်မာလိုထည့်ရန်လိုသည်';
                              } else if (regEx.validateMmBoyName(value) &&
                                  regEx.validateMmGirlName(value)) {
                                return 'Format အမှန်ထည့်ရန်လိုသည်';
                              } else
                                return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: fatherName,
                            decoration: InputDecoration(
                              labelText: 'အဖေနာမည်',
                              prefixIcon: Icon(Icons.account_circle),
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'ထည့်ရန်လိုသည်';
                              } else
                                return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    RaisedButton(
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () {
                                        if (_validateForm()) {
                                          _login();
                                        }
                                      },
                                      textColor: Colors.white,
                                      color: Colors.teal,
                                      child: Text('Register'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConnectionStatusBar(),
          ),
        ],
      ),
    );
    return new Container(child: child);
  }

  bool _validateForm() {
    bool _isValid = _formKey.currentState.validate();
    return _isValid;
  }
}

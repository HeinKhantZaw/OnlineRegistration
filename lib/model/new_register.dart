import 'dart:convert';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import '../login.dart';
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

  getNRC nrc = getNRC();
  bool darkThemeEnabled = false;
  burmeseRegEx regEx = new burmeseRegEx();

  TextEditingController name = new TextEditingController();
  TextEditingController fatherName = new TextEditingController();
  TextEditingController nrcNum = new TextEditingController();

  Future<List> _login() async {
    final response =
    await http.post("https://unireg.000webhostapp.com//GetNew.php", body: {
      "Name": name.text,
      "NRC": nrcNum.text,
      "uno": fatherName.text,
    });
    final duration =
    await http.post("https://unireg.000webhostapp.com//getTime.php");

    var getTime = json.decode(duration.body);
    time = getTime[0]['end_date'];
    var dataUser = json.decode(response.body);

    if (dataUser.length == 0) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      if (dataUser[0]['status'] == '0') {
        username = dataUser[0]['Name'];
        Navigator.pushReplacementNamed(context, '/login');
      } else{
        Navigator.pushReplacementNamed(context, '/status');
      }
    }
    return dataUser;
  }



  List<String> _codes = [".."];
  List<String> _codeNames = [".."];
  String _selectedCode;
  String _selectedCodeName;
  String newValue;


  String _NRC;

  @override
  void initState() {
    _codes = List.from(_codes)..addAll(nrc.getCodes());
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
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
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
                            Text('မှတ်ပုံတင်အမှတ်'),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    // use this to match the Flex size..., is like using Expanded.
                                    width: double.infinity,
                                    // container defines the BoxConstrains of the children
                                    child: DropdownButtonFormField<String>(
                                      hint: Text('၁၂/'),
                                      items: _codes
                                          .map((String dropDownStringItem) {
                                        return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      validator: (String value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'ထည့်ပါ';
                                        } else if (_selectedCode
                                            .contains('..')) {
                                          return 'ထည့်ပါ';
                                        } else
                                          return null;
                                      },
                                      onChanged: (value) =>
                                          _onSelectedCode(value),
                                      value: _selectedCode,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    // use this to match the Flex size..., is like using Expanded.
                                    width: double.infinity,

                                    // container defines the BoxConstrains of the children
                                    child: DropdownButtonFormField<String>(
                                      hint: Text('မဂတ'),
                                      items: _codeNames
                                          .map((String dropDownStringItem) {
                                        return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      validator: (String value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'ထည့်ပါ';
                                        } else if (_selectedCodeName
                                            .contains('..')) {
                                          return 'ထည့်ပါ';
                                        } else
                                          return null;
                                      },
                                      // onChanged: (value) => print(value),
                                      onChanged: (value) =>
                                          _onSelectedCodeName(value),
                                      value: _selectedCodeName,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    // use this to match the Flex size..., is like using Expanded.
                                    width: double.infinity,
                                    // container defines the BoxConstrains of the children
                                    child: DropdownButtonFormField<String>(
                                      hint: Text('(နိုင်)'),
                                      value: newValue,
                                      items: <String>[
                                        '(နိုင်)',
                                        '(ဧည့်)',
                                        '(ပြု)'
                                      ].map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      validator: (String value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'ထည့်ပါ';
                                        } else
                                          return null;
                                      },
                                      onChanged: (String changedValue) {
                                        newValue = changedValue;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    // use this to match the Flex size..., is like using Expanded.
                                    width: double.infinity,
                                    // container defines the BoxConstrains of the children

                                    child: TextFormField(
                                      controller: nrcNum,
                                      decoration: InputDecoration(
                                        hintText: '၁၁၀၂၀၃',
                                      ),
                                      validator: (String value) {
                                        if (value.trim().isEmpty) {
                                          return 'မှတ်ပုံတင်အမှတ်ထည့်ရန်လိုသည်';
                                        } else if (regEx
                                            .validateMmNumberInput(value)) {
                                          return 'မြန်မာလိုရေးရန်လိုသည်';
                                        } else
                                          return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      RaisedButton(
                                        padding: EdgeInsets.all(0.0),
                                        onPressed: () {
                                          if(_validateForm()) {
                                            _login();
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => CustomDialog(
                                                title: "Success",
                                                description:
                                                "Username : $username \n Password :  ",
                                                buttonText: "Login",
                                              ),
                                            );
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

    if (_selectedCodeName == null || _selectedCode == null) {
      _isValid = false;
    }
    return _isValid;
  }

  void _onSelectedCode(String value) {
    setState(() {
      _selectedCodeName = "..";
      _codeNames = [".."];
      _selectedCode = value;
      _codeNames = List.from(_codeNames)..addAll(nrc.getNameByCode(value));
    });
  }

  void _onSelectedCodeName(String value) {
    setState(() {
      _selectedCodeName = value;
    });
  }

}

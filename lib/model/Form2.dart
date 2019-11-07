import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import '../widgets/widgets.dart';
import '../NRC_db/getNRC.dart';
import 'package:flutter_app/model/Form1.dart';
import 'package:flutter_app/model/Form3.dart';
import 'qr.dart';
import 'package:flutter_app/model/raised_button.dart';

class Form2 extends StatefulWidget {
  const Form2({Key key, String username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Form2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  getNRC nrc = getNRC();

  List<String> _codes = [".."];
  List<String> _codeNames = [".."];
  String _selectedCode ;
  String _selectedCodeName;
  String newValue ;

  @override
  void initState() {
    _codes = List.from(_codes)..addAll(nrc.getCodes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Student Registration')),
        endDrawer: new Drawer(
            child: ListView(
              children: <Widget>[
                new Column(children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: new Text(
                        "$username",
                        style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0)
                    ),
                    accountEmail: new Text(
                      "firstname@lastname.com",
                      style: new TextStyle(color: Colors.blueGrey[50]),
                    ),
                    currentAccountPicture: new CircleAvatar(
                        backgroundColor: Colors.brown, child: new Text("FL")),
                  ),
                  new ListTile(
                    leading: Icon(Icons.account_circle),
                    title: new Text('My Profiles'),
                    onTap: () {
                      this.setState(() {
                        var screen = 1;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  new ListTile(
                    leading: Icon(Icons.center_focus_strong),
                    title: new Text('KBZpay QR Code'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: ( BuildContext context ) => new qr()));
                    },
                  ),
                  new ListTile(
                    leading: Icon(Icons.error_outline),
                    title: new Text('Terms & Regulations'),
                    onTap: () {
                      this.setState(() {
                        var screen = 0;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  new Divider(),
                  new ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: new Text('Logout'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ]
                ),
              ],
            )
        ),
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: new Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'လူမျိုး',
                      prefixIcon: Icon(Icons.info),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'လူမျိုးထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ကိုးကွယ်သည့်ဘာသာ',
                      prefixIcon: Icon(Icons.info),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ဘာသာထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'မွေးဖွားရာဇာတိ',
                      prefixIcon: Icon(Icons.info),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ဇာတိထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'မြို့နယ်',
                      prefixIcon: Icon(Icons.info),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'မြို့နယ်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'ပြည်နယ်/တိုင်းဒေသကြီး',
                      prefixIcon: Icon(Icons.info),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ပြည်နယ်/တိုင်းဒေသကြီးထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text('မှတ်ပုံတင်အမှတ်'),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          // use this to match the Flex size..., is like using Expanded.
                          width: double.infinity,
                          // container defines the BoxConstrains of the children
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            border: Border.all(color: Colors.white, width: 1),
                          ),

                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text('၁၂/'),
                            items: _codes.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (value) => _onSelectedCode(value),
                            value: _selectedCode,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          // use this to match the Flex size..., is like using Expanded.
                          width: double.infinity,
                          // container defines the BoxConstrains of the children
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text('မဂတ'),
                            items: _codeNames.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            // onChanged: (value) => print(value),
                            onChanged: (value) => _onSelectedCodeName(value),
                            value: _selectedCodeName,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          // use this to match the Flex size..., is like using Expanded.
                          width: double.infinity,
                          // container defines the BoxConstrains of the children
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child:DropdownButton<String>(
                              hint: Text('(နိုင်)'),
                              onChanged: (String changedValue) {
                                newValue=changedValue;
                                setState(() {
                                  newValue;
                                  print(newValue);
                                });
                              },
                              value: newValue,
                              items: <String>['(နိုင်)', '(ဧည့်)', '(ပြု)']
                                  .map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList()),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          // use this to match the Flex size..., is like using Expanded.
                          width: double.infinity,
                          // container defines the BoxConstrains of the children

                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: '၁၁၀၂၀၃',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'မှတ်ပုံတင်အမှတ်ထည့်ရန်လိုသည်';
                              }
                            },
                          ),

                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'အဘအုပ်ထိန်းသူ၏နေရပ်လိပ်စာ',
                      prefixIcon: Icon(Icons.add_location),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'လိပ်စာထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'အမိအုပ်ထိန်းသူ၏နေရပ်လိပ်စာ',
                      prefixIcon: Icon(Icons.add_location),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'လိပ်စာထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            KRaisedButton(
                              radius: 30.0,
                              color: Colors.teal,
                              text: 'Back',
                              textColor: Colors.white,
                              textFontWeight: FontWeight.bold,
                              onPressed: _back,

                            ),
                            KRaisedButton(
                              radius: 30.0,
                              color: Colors.teal,
                              text: 'Next',
                              textColor: Colors.white,
                              textFontWeight: FontWeight.bold,
                              onPressed: _submit,

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
        ));
  }


  void _back() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Form1();
      }));
    }
  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Form3();
      }));
    }
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
    setState(() => _selectedCodeName = value);
  }

}

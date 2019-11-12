import 'package:flutter/material.dart';
import 'package:flutter_app/ThemeData.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/Form1.dart';
import '../setting/shared_preferences_settings.dart';
import '../widgets/widgets.dart';
import 'qr.dart';
import 'package:flutter_app/model/raised_button.dart';
import 'package:http/http.dart' as http;

class Form4 extends StatefulWidget {
  const Form4({Key key, String username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Form4> {
  bool darkThemeEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController providerName = new TextEditingController();
  TextEditingController relationship = new TextEditingController();
  TextEditingController providerJob = new TextEditingController();
  TextEditingController providerAddress = new TextEditingController();
  TextEditingController providerPhoneNum = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkThemeEnabled ? ThemeData.dark() : buildThemeData(),
        home: home());
  }

  @override
  Widget home() {
    return Scaffold(
        appBar: AppBar(title: Text('Student Registration')),
        endDrawer: new Drawer(
            child: ListView(
          children: <Widget>[
            new Column(children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("$username",
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0)),
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
                          builder: (BuildContext context) => new qr()));
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
              new SwitchSettingsTile(
                settingKey: 'ThemeKey',
                title: 'Dark Mode',
                subtitle: 'Dark Mode On',
                subtitleIfOff: 'Dark Mode Off',
              ),
              new Divider(),
              new ListTile(
                leading: Icon(Icons.power_settings_new),
                title: new Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ]),
          ],
        )),
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: new Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: providerName,
                    decoration: InputDecoration(
                      labelText: 'အထောက်အပံ့ပေးမည့်ပုဂ္ဂိုလ်အမည်',
                      prefixIcon: Icon(Icons.account_circle),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'အမည်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: relationship,
                    decoration: InputDecoration(
                      labelText: 'ဆွေမျိုးတော်စပ်ပုံ',
                      prefixIcon: Icon(Icons.people),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: providerJob,
                    decoration: InputDecoration(
                      labelText: 'အလုပ်အကိုင်',
                      prefixIcon: Icon(Icons.business_center),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: providerAddress,
                    decoration: InputDecoration(
                      labelText: 'ဆက်သွယ်ရန်လိပ်စာ',
                      prefixIcon: Icon(Icons.add_location),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'လိပ်စာထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: providerPhoneNum,
                    decoration: InputDecoration(
                      labelText: 'ဖုန်းနံပါတ်',
                      prefixIcon: Icon(Icons.call),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ဖုန်းနံပါတ်ထည့်ရန်လိုသည်';
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
                              text: 'Submit',
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

  void _submit() async {
    if (_formKey.currentState.validate()) {
      await http.post("https://unireg.000webhostapp.com//insert.php", body: {
        "providerName": providerName.text,
        "relationship": relationship.text,
        "providerJob": providerJob.text,
        "providerAddress": providerAddress.text,
        "providerPhoneNum": providerPhoneNum.text,
      });
    }
  }
}

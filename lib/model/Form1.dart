import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/qr.dart';
import '../ThemeData.dart';
import '../widgets/widgets.dart';
import 'Form2.dart';
import 'qr.dart';
import 'package:flutter_app/model/raised_button.dart';
import '../setting/shared_preferences_settings.dart';
import '../setting/settings.dart';
import 'package:http/http.dart' as http;

class Form1 extends StatefulWidget {
  const Form1({Key key, String username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Form1> {
  TextEditingController mmName = new TextEditingController();
  TextEditingController engName = new TextEditingController();
  TextEditingController roll = new TextEditingController();
  TextEditingController uniID = new TextEditingController();
  TextEditingController uniStart = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<bool> darkThemeEnabled = Settings().getBool("ThemeKey", false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkThemeEnabled != null ? ThemeData.dark() : buildThemeData(),
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
                defaultValue: false,
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
                  TextFormField(
                    controller: engName,
                    decoration: InputDecoration(
                      labelText: 'အမည်(English လို)',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'အမည်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: mmName,
                    decoration: InputDecoration(
                      labelText: 'အမည်(Myanmar လို)',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'အမည်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: roll,
                    decoration: InputDecoration(
                      labelText: 'ခုံနံပါတ်',
                      prefixIcon: Icon(Icons.info),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ခုံနံပါတ်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: uniID,
                    decoration: InputDecoration(
                      labelText: 'တက္ကသိုလ်မှတ်ပုံတင်အမှတ်',
                      prefixIcon: Icon(Icons.info),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'တက္ကသိုလ်မှတ်ပုံတင်အမှတ်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: uniStart,
                    decoration: InputDecoration(
                      labelText: 'တက္ကသိုလ်ဝင်ရောက်သည့်ခုနှစ်',
                      prefixIcon: Icon(Icons.info),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'တက္ကသိုလ်ဝင်ရောက်သည့်ခုနှစ်ထည့်ရန်လိုသည်';
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

  Future _submit() async {
    if (_formKey.currentState.validate()) {
      await http.post("https://unireg.000webhostapp.com//insert.php", body: {
        "mmName": mmName.text,
        "engName": engName.text,
        "roll": roll.text,
        "uniID": uniID.text,
        "uniStart": uniStart.text,
      });

      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Form2();
      }));
    }
  }
}

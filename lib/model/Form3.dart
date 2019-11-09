import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/Form4.dart';
import '../ThemeData.dart';
import '../widgets/widgets.dart';
import 'Form2.dart';
import 'qr.dart';
import 'package:flutter_app/model/raised_button.dart';
import 'package:http/http.dart' as http;

class Form3 extends StatefulWidget {
  const Form3({Key key, String username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Form3> {
  TextEditingController birthday = new TextEditingController();
  TextEditingController livingAddress = new TextEditingController();
  TextEditingController fatherJob = new TextEditingController();
  TextEditingController motherJob = new TextEditingController();
  TextEditingController metriRoll = new TextEditingController();
  TextEditingController metriYear = new TextEditingController();
  TextEditingController metriDept = new TextEditingController();

  final formKey = new GlobalKey<FormState>();

  bool darkThemeEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new qr()));
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
                title: Text("Dark Theme"),
                trailing: Switch(
                  value: darkThemeEnabled,
                  onChanged: (changedTheme) {
                    setState(() {
                      darkThemeEnabled = changedTheme;
                    });
                  },
                ),
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
                    controller: birthday,
                    decoration: InputDecoration(
                      labelText: 'မွေးသက္ကရာဇ်',
                      prefixIcon: Icon(Icons.add_location),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: livingAddress,
                    decoration: InputDecoration(
                      labelText: 'သင်အမြဲတမ်းနေထိုင်သည့်လိပ်စာ',
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
                    controller: fatherJob,
                    decoration: InputDecoration(
                      labelText: 'အဘအုပ်ထိန်းသူ၏အလုပ်အကိုင်ရာထူး၊ဌာန',
                      prefixIcon: Icon(Icons.business_center),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: motherJob,
                    decoration: InputDecoration(
                      labelText: 'အမိအုပ်ထိန်းသူ၏အလုပ်အကိုင်ရာထူး၊ဌာန',
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
                    controller: metriRoll,
                    decoration: InputDecoration(
                      labelText: 'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်ခုံအမှတ်',
                      prefixIcon: Icon(Icons.book),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ခုံအမှတ်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: metriYear,
                    decoration: InputDecoration(
                      labelText: 'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်ခုနှစ်',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ခုနှစ်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: metriDept,
                    decoration: InputDecoration(
                      labelText: 'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်စာစစ်ဌာန',
                      prefixIcon: Icon(Icons.business),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'စာစစ်ဌာနထည့်ရန်လိုသည်';
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
        return new Form2();
      }));
    }
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      await http.post("https://unireg.000webhostapp.com//insert.php", body: {
        "birthday": birthday.text,
        "livingAddress": livingAddress.text,
        "fatherJob": fatherJob.text,
        "motherJob": motherJob.text,
        "metriRoll": metriRoll.text,
        "metriYear": metriYear.text,
        "metriDept": metriDept.text,
      });
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Form4();
      }));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/qr.dart';
import '../widgets/widgets.dart';
import 'Form2.dart';
import 'qr.dart';
import 'package:flutter_app/model/raised_button.dart';

class Form1 extends StatefulWidget {
  const Form1({Key key, String username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Form1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    decoration: InputDecoration(
                      labelText: 'တက္ကသိုလ်မှတ်ပုံတင်အမှတ်',
                      prefixIcon: Icon(Icons.info),
                    ),
                    keyboardType:TextInputType.number,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'တက္ကသိုလ်မှတ်ပုံတင်အမှတ်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'တက္ကသိုလ်ဝင်ရောက်သည့်ခုနှစ်',
                      prefixIcon: Icon(Icons.info),
                    ),
                    keyboardType:TextInputType.number,
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

  void _submit() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context)
          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Form2();
      }));
    }
  }
}

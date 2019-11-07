import 'package:flutter/material.dart';
import 'package:flutter_app/MemberPage.dart';
import 'package:flutter_app/main.dart';
import '../widgets/widgets.dart';



class qr extends StatefulWidget {
  const qr({Key key, String username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<qr> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('KBZPay QR Code')),
        endDrawer: new Drawer(
            child: new Column(children: <Widget>[
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
                  Navigator.of(context).pop();
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
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: ( BuildContext context ) => new MyHomePage()));
                },
              ),
            ]
            )
        ),
        resizeToAvoidBottomPadding: false,
      body: Center(


          child: Image.asset(
            'assets/QR-code.png',
          ),


      ),


//               child: Text('အကြောင်းအရာ။ ။သတင်းအချက်အလက်နည်းပညာတက္ကသိုလ်တွင် ပထမနှစ်သင်တန်း တက်ရောက်ခွင့် လျှောက်ထားခြင်း။'),



    );
  }
}



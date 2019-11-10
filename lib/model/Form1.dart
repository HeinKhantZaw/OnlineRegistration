import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/Form3.dart';
import 'package:flutter_app/model/qr.dart';
import '../ThemeData.dart';
import '../widgets/widgets.dart';
import 'qr.dart';
import 'Form3.dart';
import 'package:flutter_app/model/raised_button.dart';
import '../NRC_db/getNRC.dart';
import 'package:http/http.dart' as http;

//import 'old_register.dart';
//import 'new_register.dart';

class Form1 extends StatefulWidget {
  const Form1({Key key, String username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Form1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  getNRC nrc = getNRC();
  bool darkThemeEnabled = false;

  TextEditingController mmName = new TextEditingController();
  TextEditingController engName = new TextEditingController();
  TextEditingController roll = new TextEditingController();
  TextEditingController uniID = new TextEditingController();
  TextEditingController uniStart = new TextEditingController();
  TextEditingController ethnic = new TextEditingController();
  TextEditingController religion = new TextEditingController();
  TextEditingController birthPlace = new TextEditingController();
  TextEditingController township = new TextEditingController();
  TextEditingController division = new TextEditingController();
  TextEditingController fatherName = new TextEditingController();
  TextEditingController fatherAddress = new TextEditingController();
  TextEditingController motherName = new TextEditingController();
  TextEditingController motherAddress = new TextEditingController();
  TextEditingController birthday = new TextEditingController();
  TextEditingController livingAddress = new TextEditingController();
  TextEditingController fatherJob = new TextEditingController();
  TextEditingController motherJob = new TextEditingController();
  TextEditingController metriRoll = new TextEditingController();
  TextEditingController metriYear = new TextEditingController();
  TextEditingController metriDept = new TextEditingController();
  TextEditingController providerName = new TextEditingController();
  TextEditingController relationship = new TextEditingController();
  TextEditingController providerJob = new TextEditingController();
  TextEditingController providerAddress = new TextEditingController();
  TextEditingController providerPhoneNum = new TextEditingController();

  List<String> _codes = [".."];
  List<String> _codeNames = [".."];
  String _selectedCode;

  String _selectedCodeName;
  String newValue;

  @override
  void initState() {
    _codes = List.from(_codes)..addAll(nrc.getCodes());
    super.initState();
  }
  @override
  Widget build(BuildContext context){
  return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: darkThemeEnabled ? ThemeData.dark() : buildThemeData(),
        home: home());
}
  @override
  Widget home()  {
    return Scaffold(
        appBar: AppBar(title: Text('Student Registration')),
        endDrawer: new Drawer(
            child: new Column(children: <Widget>[
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
        ])),
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
                      prefixIcon: Icon(Icons.book),
                    ),
                    keyboardType: TextInputType.text,
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
                      prefixIcon: Icon(Icons.today),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'တက္ကသိုလ်ဝင်ရောက်သည့်ခုနှစ်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: ethnic,
                    decoration: InputDecoration(
                      labelText: 'လူမျိုး',
                      prefixIcon: Icon(Icons.sentiment_very_satisfied),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'လူမျိုးထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: religion,
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
                    controller: birthPlace,
                    decoration: InputDecoration(
                      labelText: 'မွေးဖွားရာဇာတိ',
                      prefixIcon: Icon(Icons.room),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'ဇာတိထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: township,
                    decoration: InputDecoration(
                      labelText: 'မြို့နယ်',
                      prefixIcon: Icon(Icons.room),
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'မြို့နယ်ထည့်ရန်လိုသည်';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: division,
                    decoration: InputDecoration(
                      labelText: 'ပြည်နယ်/တိုင်းဒေသကြီး',
                      prefixIcon: Icon(Icons.room),
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
                          child: DropdownButton<String>(
                              hint: Text('(နိုင်)'),
                              onChanged: (String changedValue) {
                                newValue = changedValue;
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
                    controller: birthday,
                    decoration: InputDecoration(
                      labelText: 'မွေးသက္ကရာဇ်',
                      prefixIcon: Icon(Icons.event),
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
                    controller: fatherName,
                    decoration: InputDecoration(
                      labelText: 'အဘအုပ်ထိန်းသူ၏မြန်မာနာမည်',
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
                    controller: fatherJob,
                    decoration: InputDecoration(
                      labelText: 'အဘအုပ်ထိန်းသူ၏အလုပ်အကိုင်၊ရာထူး၊ဌာန',
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
                    controller: fatherAddress,
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
                    controller: motherName,
                    decoration: InputDecoration(
                      labelText: 'အမိအုပ်ထိန်းသူ၏မြန်မာနာမည်',
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
                    controller: motherAddress,
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

  void _submit() async {
    if (_formKey.currentState.validate()) {
      await http.post("https://unireg.000webhostapp.com//insert.php", body: {
        "mmName": mmName.text,
        "engName": engName.text,
        "roll": roll.text,
        "uniID": uniID.text,
        "uniStart": uniStart.text,
        "ethnic": ethnic.text,
        "religion": religion.text,
        "birthPlace": birthPlace.text,
        "township": township.text,
        "division": division.text,
        "fatherName": fatherName.text,
        "fatherAddress": fatherAddress.text,
        "motherName": motherName.text,
        "motherAddress": motherAddress.text,
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

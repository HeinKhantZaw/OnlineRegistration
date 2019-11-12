import 'dart:convert';

import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/Form4.dart';
import 'package:flutter_app/model/qr.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../ThemeData.dart';
import '../widgets/widgets.dart';
import 'qr.dart';
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
  var date1 = DateTime.parse("2019-11-30 23:59:59");
  DateTime date2 = new DateTime.now();
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
  String _date = "မွေးသက္ကရာဇ်";
  List _bloods = ["အိုသွေး", "အေသွေး", "ဘီသွေး", "အေဘီသွေး"];
  final List<String> _dropdownValues = [ "အိုသွေး", "အေသွေး", "ဘီသွေး", "အေဘီသွေး" ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedBlood;

  @override
  void initState() {
    _codes = List.from(_codes)..addAll(nrc.getCodes());
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_bloods);
    _selectedBlood = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkThemeEnabled ? buildThemeDataDark() : buildThemeData(),
        home: home());
  }

  Widget home() {
    Widget child;
    if (date1.isAfter(date2)) {
      child = SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            Align(
              child: Scaffold(
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
                                prefixIcon:
                                    Icon(Icons.sentiment_very_satisfied),
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
                                  flex: 2,
                                  child: Container(
                                    // use this to match the Flex size..., is like using Expanded.
                                    width: double.infinity,
                                    // container defines the BoxConstrains of the children

                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Text('၁၂/'),
                                      items: _codes
                                          .map((String dropDownStringItem) {
                                        return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
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
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Text('မဂတ'),
                                      items: _codeNames
                                          .map((String dropDownStringItem) {
                                        return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
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
                                    child: DropdownButton<String>(
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
                                      onChanged: (String changedValue) {
                                        newValue = changedValue;
                                        setState(() {
                                          newValue;
                                          print(newValue);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
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
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 1.0,
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true,
                                minTime: DateTime(1997, 1, 1),
                                maxTime: DateTime(2022, 12, 31),
                                onConfirm: (date) {
                                  print('confirm $date');
                                  _date = '${date.year} - ${date.month} - ${date.day}';
                                  setState(() {});
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            size: 18.0,

                                          ),

                                          Text(
                                            " $_date",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),

                        const SizedBox(height: 16.0),
                            Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(left: 12.5),
                                    child: Icon(Icons.favorite)
                                ),
                                Padding(padding: EdgeInsets.only(left: 15.0),
                                    child: Text("သွေးအမျိုးအစား",  style: new TextStyle( fontSize: 16.5, color: Colors.black))
                                ),

                                Padding(
                                    padding: EdgeInsets.only(left: 50.0),

                                    child: DropdownButton(
                                      items: _dropDownMenuItems,
                                      value: _selectedBlood,
                                      onChanged: changedDropDownItem,
                                      isExpanded: false,
                                      hint: Text("အိုသွေး"),

                                    )
                                ),
                              ],
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
                                labelText:
                                    'အဘအုပ်ထိန်းသူ၏အလုပ်အကိုင်၊ရာထူး၊ဌာန',
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
                                labelText:
                                    'အမိအုပ်ထိန်းသူ၏အလုပ်အကိုင်ရာထူး၊ဌာန',
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
                                labelText:
                                    'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်ခုံအမှတ်',
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
                                labelText:
                                    'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်ခုနှစ်',
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
                                labelText:
                                    'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်စာစစ်ဌာန',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                  )),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConnectionStatusBar(),
            ),
          ],
        ),
      );
    } else {
      child = Text(date2.toString());
    }
    return new Container(child: child);
  }

  bool _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    if (_selectedCodeName == null || _selectedCode == null) {
      _isValid = false;
    }
    return _isValid;
  }

  void _submit() async {
    if (_validateForm()) {
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
        "birthday": _date,
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
  void changedDropDownItem(String selectedBlood) {
    setState(() {
      _selectedBlood = selectedBlood;
    });
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List bloods) {
    List<DropdownMenuItem<String>> items = List();
    for (String blood in bloods) {
      items.add(DropdownMenuItem(value: blood, child: Text(blood)));
    }
    return items;
  }
}

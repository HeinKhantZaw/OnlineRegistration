import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
//import 'package:flutter_app/model/ProfilePage.dart';

import 'package:flutter_app/validation/burmeseRegEx.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

//import 'package:fluttertoast/fluttertoast.dart';
import '../SA.dart';
import '../ThemeData.dart';
import '../widgets/widgets.dart';
import 'CustomDialog.dart';

import '../NRC_db/getNRC.dart';
import 'package:http/http.dart' as http;

class Form1 extends StatefulWidget {
  const Form1({Key key, String username, String time}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Form1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  getNRC nrc = getNRC();
  bool darkThemeEnabled = false;
  var date1 = DateTime.parse(time);
  DateTime date2 = new DateTime.now();
  burmeseRegEx regEx = new burmeseRegEx();

  TextEditingController uno = new TextEditingController();
  TextEditingController startingyear = new TextEditingController();
  TextEditingController mmSName = new TextEditingController();
  TextEditingController enSName = new TextEditingController();
  TextEditingController nationality = new TextEditingController();
  TextEditingController religion = new TextEditingController();
  TextEditingController hometown = new TextEditingController();
  TextEditingController township = new TextEditingController();
  TextEditingController division = new TextEditingController();
  TextEditingController nrcNum = new TextEditingController();
  TextEditingController dateOfBirth = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController matriculationRoll = new TextEditingController();
  TextEditingController matriculationYear = new TextEditingController();
  TextEditingController matriculationDept = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController roll = new TextEditingController();
  TextEditingController mmfatherName = new TextEditingController();
  TextEditingController enfatherName = new TextEditingController();
  TextEditingController f_nationality = new TextEditingController();
  TextEditingController fatherReligion = new TextEditingController();
  TextEditingController fatherHometown = new TextEditingController();
  TextEditingController fatherTownship = new TextEditingController();
  TextEditingController fatherDivision = new TextEditingController();
  TextEditingController fatherJob = new TextEditingController();
  TextEditingController fatherPosition = new TextEditingController();
  TextEditingController fatherDept = new TextEditingController();
  TextEditingController fatherBirthPlace = new TextEditingController();
  TextEditingController fatherAddress = new TextEditingController();
  TextEditingController fatherPhone = new TextEditingController();

  TextEditingController mmmotherName = new TextEditingController();
  TextEditingController enmotherName = new TextEditingController();
  TextEditingController m_nationality = new TextEditingController();
  TextEditingController motherReligion = new TextEditingController();
  TextEditingController motherHometown = new TextEditingController();
  TextEditingController motherTownship = new TextEditingController();
  TextEditingController motherDivision = new TextEditingController();
  TextEditingController motherJob = new TextEditingController();
  TextEditingController motherPosition = new TextEditingController();
  TextEditingController motherDept = new TextEditingController();
  TextEditingController motherBirthPlace = new TextEditingController();
  TextEditingController motherAddress = new TextEditingController();
  TextEditingController motherPhone = new TextEditingController();

  TextEditingController proName = new TextEditingController();
  TextEditingController relationship = new TextEditingController();
  TextEditingController proJob = new TextEditingController();
  TextEditingController proAddress = new TextEditingController();
  TextEditingController proPhoneNum = new TextEditingController();

  List<String> _codes = [".."];
  List<String> _codeNames = [".."];
  String _selectedCode;
  String _selectedCodeName;
  String newValue;
  String _date = "မွေးသက္ကရာဇ်";
  List _majors = [
    "First Year",
    "Second Year",
    "Third Year CS",
    "Third Year CT",
    "Fourth Year SE",
    "Fourth Year KE",
    "Fourth Year BIS",
    "Fourth Year HPC",
    "Fourth Year ES",
    "Fourth Year CN",
    "Final Year SE",
    "Final Year KE",
    "Final Year BIS",
    "Final Year HPC",
    "Final Year ES",
    "Final Year CN"
  ];
  List _nationalities = ["တိုင်းရင်းသား", "နိုင်ငံခြားသား"];
  List _bloods = ["အိုသွေး", "အေသွေး", "ဘီသွေး", "အေဘီသွေး"];

//  final List<String> _dropdownValues = [
//    "အိုသွေး",
//    "အေသွေး",
//    "ဘီသွေး",
//    "အေဘီသွေး"
//  ];
  List<DropdownMenuItem<String>> _dropDownMenuMajors;
  List<DropdownMenuItem<String>> _dropDownMenuCitizenships;
  List<DropdownMenuItem<String>> _dropDownMenuBloods;
  String _selectedMajor = "First Year";
  String _selectedCitizenship = "တိုင်းရင်းသား";
  String _selectedBlood = "အိုသွေး";
  String _NRC;

  int _radioValue1 = -1;
  int correctScore = 0;

  @override
  void initState() {
    _codes = List.from(_codes)..addAll(nrc.getCodes());
    _dropDownMenuMajors = buildAndGetDropDownMenuMajors(_majors);
    _selectedMajor = _dropDownMenuMajors[0].value;
    _dropDownMenuCitizenships =
        buildAndGetDropDownMenuNationalities(_nationalities);
    _selectedCitizenship = _dropDownMenuCitizenships[0].value;
    _dropDownMenuBloods = buildAndGetDropDownMenuBloods(_bloods);
    _selectedBlood = _dropDownMenuBloods[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/status': (BuildContext context) => new SA(),
        },
        theme: darkThemeEnabled ? ThemeData.dark() : buildThemeData(),
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
                      accountEmail: new Text("firstname@lastname.com",
                          style: new TextStyle(color: Colors.blueGrey[50])),
                      currentAccountPicture: new CircleAvatar(
                          backgroundColor: Colors.brown, child: new Text("FL")),
                    ),
                    new ListTile(
                      leading: Icon(Icons.account_circle),
                      title: new Text('My Profile'),
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()),);
                      },
                    ),
                    new ListTile(
                      leading: Icon(Icons.error_outline),
                      title: new Text('Terms & Regulations'),
                      onTap: () {
                        this.setState(() {});
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
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
                            Row(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 12.5),
                                    child: Icon(Icons.list)),
                                Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "မေဂျာ",
                                      style: new TextStyle(
                                          fontSize: 16.5, color: Colors.black),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(left: 75.0),
                                    child: DropdownButton(
                                      items: _dropDownMenuMajors,
                                      value: _selectedMajor,
                                      onChanged: changedDropDownMajor,
                                      hint: Text(_selectedMajor),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: roll,
                              decoration: InputDecoration(
                                labelText: 'ခုံအမှတ်',
                                prefixIcon: Icon(Icons.info),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ခုံအမှတ်ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: uno,
                              decoration: InputDecoration(
                                labelText: 'တက္ကသိုလ်မှတ်ပုံတင်အမှတ်',
                                prefixIcon: Icon(Icons.book),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'တက္ကသိုလ်မှတ်ပုံတင်အမှတ်ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: startingyear,
                              decoration: InputDecoration(
                                labelText: 'တက္ကသိုလ်ဝင်ရောက်သည့်ခုနှစ်',
                                prefixIcon: Icon(Icons.today),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'တက္ကသိုလ်ဝင်ရောက်သည့်ခုနှစ်ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.center,
                              child: Text('ကျောင်းသား/သူ',
                                  style: TextStyle(
                                      fontSize: 16.5,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic)),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: mmSName,
                              decoration: InputDecoration(
                                labelText: 'အမည် (မြန်မာလို)',
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty ||
                                    regEx.validateMmInput(value)) {
                                  return 'Myanmar လိုထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: enSName,
                              decoration: InputDecoration(
                                labelText: 'အမည် (အင်္ဂလိပ်လို)',
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'English လိုထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: nationality,
                              decoration: InputDecoration(
                                labelText: 'လူမျိုး',
                                prefixIcon:
                                    Icon(Icons.sentiment_very_satisfied),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'လူမျိုးထည့်ရန်လိုသည်';
                                } else if (regEx.validateMmInput(value)) {
                                  return 'မြန်မာလိုရေးရန်လိုသည်';
                                } else
                                  return null;
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
                                } else if (regEx.validateMmInput(value)) {
                                  return 'မြန်မာလိုရေးရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: hometown,
                              decoration: InputDecoration(
                                labelText: 'မွေးဖွားရာဇာတိ',
                                prefixIcon: Icon(Icons.room),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ဇာတိထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: township,
                              decoration: InputDecoration(
                                labelText: 'မြို့နယ်',
                                prefixIcon: Icon(Icons.edit_location),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'မြို့နယ်/ပြည်နယ်/တိုင်းထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: division,
                              decoration: InputDecoration(
                                labelText: 'ပြည်နယ်/တိုင်း',
                                prefixIcon: Icon(Icons.edit_location),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'မြို့နယ်/ပြည်နယ်/တိုင်းထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Text('မှတ်ပုံတင်အမှတ်',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                )),
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
                                      hint: Text('.../'),
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
                                      hint: Text('...'),
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
                                      hint: Text('(...)'),
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
                            const SizedBox(height: 16.0),
                            Row(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 12.5),
                                    child: Icon(Icons.flag)),
                                Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text("နိုင်ငံခြားသား",
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black))),
                                Padding(
                                    padding: EdgeInsets.only(left: 85.0),
                                    child: DropdownButton(
                                      items: _dropDownMenuCitizenships,
                                      value: _selectedCitizenship,
                                      onChanged: changedDropDownCitizenship,
                                      hint: Text(_selectedCitizenship),
                                    )),
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
                                  _date =
                                      '${date.year} - ${date.month} - ${date.day}';
                                  setState(() {});
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 12.5),
                                    child: Icon(Icons.favorite)),
                                Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text("သွေးအုပ်စု",
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black))),
                                Padding(
                                    padding: EdgeInsets.only(left: 85.0),
                                    child: DropdownButton(
                                      items: _dropDownMenuBloods,
                                      value: _selectedBlood,
                                      onChanged: changedDropDownBlood,
                                      hint: Text(_selectedBlood),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: phone,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'ဖုန်းနံပါတ်',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ဖုန်းနံပါတ် ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: matriculationRoll,
                              decoration: InputDecoration(
                                labelText:
                                    'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်ခုံအမှတ်',
                                prefixIcon: Icon(Icons.book),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ခုံအမှတ်ထည့်ရန်လိုသည်';
                                } else if (regEx.validateMmInput(value)) {
                                  return 'မြန်မာလိုရေးရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: matriculationYear,
                              decoration: InputDecoration(
                                labelText:
                                    'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်ခုနှစ်',
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ခုနှစ်ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: matriculationDept,
                              decoration: InputDecoration(
                                labelText:
                                    'တက္ကသိုလ်ဝင်တန်းအောင်မြင်သည့်စာစစ်ဌာန',
                                prefixIcon: Icon(Icons.business),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'စာစစ်ဌာနထည့်ရန်လိုသည်';
                                } else if (regEx.validateMmInput(value)) {
                                  return 'မြန်မာလိုရေးရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: address,
                              decoration: InputDecoration(
                                labelText: 'အမြဲတမ်းနေထိုင်သည့်လိပ်စာ',
                                //(အပြည့်အစုံ)
                                prefixIcon: Icon(Icons.add_location),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'လိပ်စာထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.center,
                              child: Text('အဘ',
                                  style: TextStyle(
                                      fontSize: 16.5,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic)),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: mmfatherName,
                              decoration: InputDecoration(
                                labelText: 'အမည် (မြန်မာ)',
                                prefixIcon: Icon(Icons.business_center),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
                                } else if (regEx.validateMmInput(value)) {
                                  return 'မြန်မာလိုရေးရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: enfatherName,
                              decoration: InputDecoration(
                                labelText: 'အမည် (English)',
                                prefixIcon: Icon(Icons.business_center),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: f_nationality,
                              decoration: InputDecoration(
                                labelText: 'လူမျိုး',
                                prefixIcon:
                                    Icon(Icons.sentiment_very_satisfied),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'လူမျိုးထည့်ရန်လိုသည်';
                                } else if (regEx.validateMmInput(value)) {
                                  return 'မြန်မာလိုရေးရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: fatherHometown,
                              decoration: InputDecoration(
                                labelText: 'ကိုးကွယ်သည့်ဘာသာ',
                                prefixIcon: Icon(Icons.info),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ဘာသာထည့်ရန်လိုသည်';
                                } else if (regEx.validateMmInput(value)) {
                                  return 'မြန်မာလိုရေးရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: fatherBirthPlace,
                              decoration: InputDecoration(
                                labelText: 'မွေးဖွားရာဇာတိ',
                                prefixIcon: Icon(Icons.room),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ဇာတိထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: fatherTownship,
                              decoration: InputDecoration(
                                labelText: 'မြို့နယ်',
                                prefixIcon: Icon(Icons.edit_location),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'မြို့နယ်ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: fatherDivision,
                              decoration: InputDecoration(
                                labelText: 'တိုင်း',
                                prefixIcon: Icon(Icons.edit_location),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'တိုင်းဒေသကြီးထည့်ရန်လိုသည်';
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
                                    // container defines the BoxConstraints of the children
                                    child: DropdownButtonFormField<String>(
                                      hint: Text('.../'),
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

                                    // container defines the BoxConstraints of the children
                                    child: DropdownButtonFormField<String>(
                                      hint: Text('...'),
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
                                    // container defines the BoxConstraints of the children
                                    child: DropdownButtonFormField<String>(
                                      hint: Text('(...)'),
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
                            const SizedBox(height: 16.0),
                            Row(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 12.5),
                                    child: Icon(Icons.flag)),
                                Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text("နိုင်ငံခြားသား",
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black))),
                                Padding(
                                    padding: EdgeInsets.only(left: 85.0),
                                    child: DropdownButton(
                                      items: _dropDownMenuCitizenships,
                                      value: _selectedCitizenship,
                                      onChanged: changedDropDownCitizenship,
                                      hint: Text(_selectedCitizenship),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: fatherJob,
                              decoration: InputDecoration(
                                labelText: 'အဘအုပ်ထိန်းသူ၏အလုပ်အကိုင်',
                                prefixIcon: Icon(Icons.business_center),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: fatherPosition,
                              decoration: InputDecoration(
                                labelText: 'အဘအုပ်ထိန်းသူ၏ရာထူး',
                                prefixIcon: Icon(Icons.business_center),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: fatherDept,
                              decoration: InputDecoration(
                                labelText: 'အဘအုပ်ထိန်းသူ၏အလုပ်ဌာန',
                                prefixIcon: Icon(Icons.business_center),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: fatherAddress,
                              decoration: InputDecoration(
                                labelText: 'အဘအုပ်ထိန်းသူ၏လိပ်စာအပြည့်အစုံ',
                                prefixIcon: Icon(Icons.add_location),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'လိပ်စာထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: fatherPhone,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'ဖုန်းနံပါတ်',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ဖုန်းနံပါတ် ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.center,
                              child: Text('အမိ',
                                  style: TextStyle(
                                      fontSize: 16.5,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic)),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: mmmotherName,
                              decoration: InputDecoration(
                                labelText: 'အမည် (မြန်မာလို)',
                                prefixIcon: Icon(Icons.business_center),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
                                } else if (regEx.validateMmInput(value)) {
                                  return 'မြန်မာလိုရေးရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: enmotherName,
                              decoration: InputDecoration(
                                labelText: 'အမည် (English)',
                                prefixIcon: Icon(Icons.business_center),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: m_nationality,
                              decoration: InputDecoration(
                                labelText: 'လူမျိုး',
                                prefixIcon:
                                    Icon(Icons.sentiment_very_satisfied),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'လူမျိုးထည့်ရန်လိုသည်';
                                } else if (regEx.validateMmInput(value)) {
                                  return 'မြန်မာလိုရေးရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: motherReligion,
                              decoration: InputDecoration(
                                labelText: 'ကိုးကွယ်သည့်ဘာသာ',
                                prefixIcon: Icon(Icons.info),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ဘာသာထည့်ရန်လိုသည်';
                                } else if (regEx.validateMmInput(value)) {
                                  return 'မြန်မာလိုရေးရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: motherBirthPlace,
                              decoration: InputDecoration(
                                labelText: 'မွေးဖွားရာဇာတိ',
                                prefixIcon: Icon(Icons.room),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ဇာတိထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: motherTownship,
                              decoration: InputDecoration(
                                labelText: 'မြို့နယ်/ပြည်နယ်/တိုင်း',
                                prefixIcon: Icon(Icons.edit_location),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ပြည်နယ်/တိုင်းဒေသကြီးထည့်ရန်လိုသည်';
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
                                      hint: Text('.../'),
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
                                      hint: Text('...'),
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
                                      hint: Text('(...)'),
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
                            const SizedBox(height: 16.0),
                            Row(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 12.5),
                                    child: Icon(Icons.flag)),
                                Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Text("နိုင်ငံခြားသား",
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black))),
                                Padding(
                                    padding: EdgeInsets.only(left: 85.0),
                                    child: DropdownButton(
                                      items: _dropDownMenuCitizenships,
                                      value: _selectedCitizenship,
                                      onChanged: changedDropDownCitizenship,
                                      hint: Text(_selectedCitizenship),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: motherJob,
                              decoration: InputDecoration(
                                labelText: 'အမိအုပ်ထိန်းသူ၏အလုပ်အကိုင်',
                                prefixIcon: Icon(Icons.business_center),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: motherPosition,
                              decoration: InputDecoration(
                                labelText: 'အမိအုပ်ထိန်းသူ၏ရာထူး',
                                prefixIcon: Icon(Icons.business_center),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: motherDept,
                              decoration: InputDecoration(
                                labelText: 'အမိအုပ်ထိန်းသူ၏အလုပ်ဌာန',
                                prefixIcon: Icon(Icons.business_center),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: motherAddress,
                              decoration: InputDecoration(
                                labelText: 'အမိအုပ်ထိန်းသူ၏လိပ်စာအပြည့်အစုံ',
                                prefixIcon: Icon(Icons.add_location),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'လိပ်စာထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: motherPhone,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'ဖုန်းနံပါတ်',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'ဖုန်းနံပါတ် ထည့်ရန်လိုသည်';
                                } else
                                  return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                  'ပညာသင်ထောက်ပံ့‌ကြေးပေးရန်မေတ္တာရပ်ခံခြင်းပြု/မပြု',
                                  style: TextStyle(
                                      fontSize: 16.5,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic)),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 0,
                                  groupValue: _radioValue1,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                new Text('ပြု',
                                    style: new TextStyle(fontSize: 16.0)),
                                new Radio(
                                  value: 1,
                                  groupValue: _radioValue1,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                new Text('မပြု',
                                    style: new TextStyle(fontSize: 16.0)),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                  'ကျောင်းနေရန်အထောက်အပံ့ပေးမည့်ပုဂ္ဂိုလ်',
                                  style: TextStyle(
                                      fontSize: 16.5,
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic)),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new InkWell(
                                    onTap: () {
                                      visibilityDad
                                          ? null
                                          : _changed(true, "dad");
                                    },
                                    child: new Container(
                                      margin: new EdgeInsets.only(top: 16.0),
                                      child: new Column(
                                        children: <Widget>[
                                          new Icon(Icons.person,
                                              color: visibilityDad
                                                  ? Colors.grey[400]
                                                  : Colors.grey[600]),
                                          new Container(
                                            margin:
                                                const EdgeInsets.only(top: 8.0),
                                            child: new Text(
                                              "အဖေ",
                                              style: new TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400,
                                                color: visibilityDad
                                                    ? Colors.grey[400]
                                                    : Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                new SizedBox(width: 24.0),
                                new InkWell(
                                    onTap: () {
                                      visibilityMom
                                          ? null
                                          : _changed(true, "mom");
                                    },
                                    child: new Container(
                                      margin: new EdgeInsets.only(top: 16.0),
                                      child: new Column(
                                        children: <Widget>[
                                          new Icon(Icons.person,
                                              color: visibilityMom
                                                  ? Colors.grey[400]
                                                  : Colors.grey[600]),
                                          new Container(
                                            margin:
                                                const EdgeInsets.only(top: 8.0),
                                            child: new Text(
                                              "အမေ",
                                              style: new TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: visibilityMom
                                                    ? Colors.grey[400]
                                                    : Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                new SizedBox(width: 24.0),
                                new InkWell(
                                    onTap: () {
                                      visibilityOther
                                          ? null
                                          : _changed(true, "other");
                                    },
                                    child: new Container(
                                      margin: new EdgeInsets.only(top: 16.0),
                                      child: new Column(
                                        children: <Widget>[
                                          new Icon(Icons.person,
                                              color: visibilityOther
                                                  ? Colors.grey[400]
                                                  : Colors.grey[600]),
                                          new Container(
                                            margin:
                                                const EdgeInsets.only(top: 8.0),
                                            child: new Text(
                                              "အခြား",
                                              style: new TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: visibilityOther
                                                    ? Colors.grey[400]
                                                    : Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: Column(
                                  children: <Widget>[
                                    visibilityOther
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              new Expanded(
                                                flex: 11,
                                                child: new TextFormField(
                                                  controller: proName,
//                                            style: Theme.of(context).textTheme.title,
                                                  decoration:
                                                      new InputDecoration(
                                                          labelText: "အမည်",
                                                          prefixIcon: Icon(Icons
                                                              .account_circle),
                                                          isDense: true),
                                                  validator: (String value) {
                                                    if (value.trim().isEmpty) {
                                                      return 'အမည်ထည့်ရန်လိုသည်';
                                                    }
                                                  },
                                                ),
                                              ),
                                              new Expanded(
                                                flex: 1,
                                                child: new IconButton(
                                                  color: Colors.grey[400],
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                    size: 22.0,
                                                  ),
                                                  onPressed: () {
                                                    _changed(false, "other");
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : new Container(),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: Column(
                                  children: <Widget>[
                                    visibilityOther
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              new Expanded(
                                                flex: 11,
                                                child: new TextFormField(
                                                  controller: relationship,
                                                  decoration: new InputDecoration(
                                                      labelText:
                                                          "ဆွေမျိုးတော်စပ်ပုံ",
                                                      prefixIcon:
                                                          Icon(Icons.people),
                                                      isDense: true),
                                                  validator: (String value) {
                                                    if (value.trim().isEmpty) {
                                                      return 'ထည့်ရန်လိုသည်';
                                                    }
                                                  },
                                                ),
                                              ),
                                              new Expanded(
                                                flex: 1,
                                                child: new IconButton(
                                                  color: Colors.grey[400],
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                    size: 22.0,
                                                  ),
                                                  onPressed: () {
                                                    _changed(false, "other");
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : new Container(),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: Column(
                                  children: <Widget>[
                                    visibilityOther
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              new Expanded(
                                                flex: 11,
                                                child: new TextFormField(
                                                  controller: proJob,
                                                  decoration:
                                                      new InputDecoration(
                                                          labelText:
                                                              'အလုပ်အကိုင်',
                                                          prefixIcon: Icon(Icons
                                                              .business_center),
                                                          isDense: true),
                                                  validator: (String value) {
                                                    if (value.trim().isEmpty) {
                                                      return 'ထည့်ရန်လိုသည်';
                                                    }
                                                  },
                                                ),
                                              ),
                                              new Expanded(
                                                flex: 1,
                                                child: new IconButton(
                                                  color: Colors.grey[400],
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                    size: 22.0,
                                                  ),
                                                  onPressed: () {
                                                    _changed(false, "other");
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : new Container(),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: Column(
                                  children: <Widget>[
                                    visibilityOther
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              new Expanded(
                                                flex: 11,
                                                child: new TextFormField(
                                                  controller: proAddress,
                                                  decoration:
                                                      new InputDecoration(
                                                          labelText:
                                                              'ဆက်သွယ်ရန်လိပ်စာ',
                                                          prefixIcon: Icon(Icons
                                                              .add_location),
                                                          isDense: true),
                                                  validator: (String value) {
                                                    if (value.trim().isEmpty) {
                                                      return 'လိပ်စာထည့်ရန်လိုသည်';
                                                    }
                                                  },
                                                ),
                                              ),
                                              new Expanded(
                                                flex: 1,
                                                child: new IconButton(
                                                  color: Colors.grey[400],
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                    size: 22.0,
                                                  ),
                                                  onPressed: () {
                                                    _changed(false, "other");
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : new Container(),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: Column(
                                  children: <Widget>[
                                    visibilityOther
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              new Expanded(
                                                flex: 11,
                                                child: new TextFormField(
                                                  controller: proPhoneNum,
                                                  decoration:
                                                      new InputDecoration(
                                                          labelText:
                                                              'ဖုန်းနံပါတ်',
                                                          prefixIcon:
                                                              Icon(Icons.call),
                                                          isDense: true),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (String value) {
                                                    if (value.trim().isEmpty) {
                                                      return 'ဖုန်းနံပါတ်ထည့်ရန်လိုသည်';
                                                    }
                                                  },
                                                ),
                                              ),
                                              new Expanded(
                                                flex: 1,
                                                child: new IconButton(
                                                  color: Colors.grey[400],
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                    size: 22.0,
                                                  ),
                                                  onPressed: () {
                                                    _changed(false, "other");
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : new Container(),
                                  ],
                                )),
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
                                      RaisedButton(
                                        padding: EdgeInsets.all(0.0),
                                        onPressed: () {
                                          if (_validateForm()) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomDialog(
                                                title: "Success",
                                                description:
                                                    "Successfully Submitted",
                                                buttonText: "Ok",
                                              ),
                                            );
                                            _submit();
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
    } else {
      child = SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            Align(
              child: Text("Sorry. Cannot register anymore."),
            )
          ],
        ),
      );
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

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
      switch (_radioValue1) {
        case 0:
//          Fluttertoast.showToast(msg: 'Correct !',toastLength: Toast.LENGTH_SHORT);
          correctScore++;
          break;
        case 1:
//          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
//          Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  bool visibilityDad = false;
  bool visibilityMom = false;
  bool visibilityOther = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "dad") {
        visibilityDad = visibility;
      }
      if (field == "mom") {
        visibilityMom = visibility;
      }
      if (field == "other") {
        visibilityOther = visibility;
      }
    });
  }

  void _submit() async {
    if (_validateForm()) {
      _NRC = _selectedCode + _selectedCodeName + newValue + nrcNum.text;
      await http
          .post("https://uitonlinereg.000webhostapp.com//insert.php", body: {
        "uno": uno.text,
        "startingyear": startingyear.text,
        "mmSName": mmSName.text,
        "enSName": enSName.text,
        "nationality": nationality.text,
        "religion": religion.text,
        "hometown": hometown.text,
        "township": township.text,
        "division": division.text,
        "nrc": _NRC,
        "citizenship": _selectedCitizenship,
        "dateOfBirth": _date,
        "bloodtype": _selectedBlood,
        "phoneNo": phone.text,
        "matriRollNo": matriculationRoll.text,
        "matriYear": matriculationYear.text,
        "matriexamdept": matriculationDept.text,
        "address": address.text,
        "major": _selectedMajor,
        "roll": roll.text,
        "mmFName": mmfatherName.text,
        "enFName": enfatherName.text,
        "f_nationality": f_nationality.text,
        "f_religion": fatherReligion.text,
        "f_hometown": fatherBirthPlace.text,
        "f_township": fatherTownship.text,
        "f_division": fatherDivision.text,
        "f_Job": fatherJob.text,
        "f_position": fatherPosition.text,
        "f_department": fatherDept.text,
        "f_address": fatherAddress.text,
        "f_phoneNo": fatherPhone.text,
        "mmMName": mmmotherName.text,
        "enMName": enmotherName.text,
        "m_nationality": m_nationality.text,
        "m_religion": motherReligion.text,
        "m_hometown": motherBirthPlace.text,
        "m_township": fatherTownship.text,
        "m_division": fatherDivision.text,
        "m_Job": motherJob.text,
        "m_position": motherPosition.text,
        "m_department": motherDept.text,
        "m_address": motherAddress.text,
        "m_phoneNo": motherPhone.text,
        "dateOfBirth": _date,
        "bloodtype": _selectedBlood,
        "address": address.text,
        "matriRollNo": matriculationRoll.text,
        "matriYear": matriculationYear.text,
        "matriexamDept": matriculationDept.text,
        "pName": proName.text,
        "relationship": relationship.text,
        "job": proJob.text,
        "p_address": proAddress.text,
        "p_phoneNo": proPhoneNum.text,
      });
      await http
          .post("https://uitonlinereg.000webhostapp.com//setStatus.php", body: {
        "enSName": enSName.text,
        "NRC": _NRC,
        "matriRoll": matriculationRoll.text,
        "uno": uno.text,
        "fatherName": mmfatherName.text,
      });
    }
  }

  void _onSelectedCode(String value) {
    setState(() {
      _selectedCodeName = "...";
      _codeNames = ["..."];
      _selectedCode = value;
      _codeNames = List.from(_codeNames)..addAll(nrc.getNameByCode(value));
    });
  }

  void _onSelectedCodeName(String value) {
    setState(() {
      _selectedCodeName = value;
    });
  }

  void changedDropDownMajor(String selectedMajor) {
    setState(() {
      _selectedMajor = selectedMajor;
    });
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuMajors(List majors) {
    List<DropdownMenuItem<String>> items = List();
    for (String major in majors) {
      items.add(DropdownMenuItem(value: major, child: Text(major)));
    }
    return items;
  }

  void changedDropDownCitizenship(String selectedCitizenship) {
    setState(() {
      _selectedCitizenship = selectedCitizenship;
    });
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuNationalities(
      List nationalities) {
    List<DropdownMenuItem<String>> items = List();
    for (String Citizenship in nationalities) {
      items.add(DropdownMenuItem(value: Citizenship, child: Text(Citizenship)));
    }
    return items;
  }

  void changedDropDownBlood(String selectedBlood) {
    setState(() {
      _selectedBlood = selectedBlood;
    });
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuBloods(List bloods) {
    List<DropdownMenuItem<String>> items = List();
    for (String blood in bloods) {
      items.add(DropdownMenuItem(value: blood, child: Text(blood)));
    }
    return items;
  }
}

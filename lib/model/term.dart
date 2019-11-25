import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Terms & Regulations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Term(title: 'Terms & Regulations'),
    );
  }
}

class Term extends StatefulWidget {
  Term({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _TermState createState() => _TermState();
}

class _TermState extends State<Term> {
  // Scaffold key to locate the widget you need to test
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Terms & Conditions')),
      body: ListView(

        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16.0,top: 23,right: 16.0, bottom: 23),
            child: Center(
            child: Text("သို့    "
                "\n\n ပါမောက္ခချုပ်။     ။ "
                "\n သတင်းအချက်အလက်နည်းပညာတက္ကသိုလ်  \n\n                "

                "အကြောင်းအရာ။         ။ကျွန်တော်/ကျွန်မ သည် ၂၀၁၉-၂၀၂၀ ပညာသင်နှစ်အတွက် သတင်းအချက်အလက်နည်းပညာတက္ကသိုလ်တွင် တက်ရောက်ခွင့်ပြုပါရန် လျှောက်ထားအပ်ပါသည်။"
                "သတင်းအချက်အလက်နည်းပညာတက္ကသိုလ်တွင် ပညာသင်ကြားနေစဉ်ကာလအတွင်း တက္ကသိုလ်မှသတ်မှတ်ထားသည့် အောက်ဖော်ပြပါ အချက်အလက်များကို သိရှိပြီးကြောင်းနှင့် လိုက်နာကျင့်သုံးမည်ဖြစ်ကြောင်းဝန်ခံလက်မှတ် ရေးထိုးပါသည်-"
                "သင်တန်းမှာ(၅)နှစ်သင်တန်းဖြစ်ပါသည်။ သင်တန်းကြေးမှာ တစ်လလျှင်(၅၀၀ဝိ/-)နှုန်ဲးဖြစ်ပါသည်။ မိမိအစီအစဥ်ဖြင့် နေထိုင်စားသောက်ရမည်ဖြစ်ပါသည်။"
                "ကျောင်းဆောင်လျှောက်ထားနေထိုင်ခွင့် ရရှိသူများသည် အဆောင်လခများကို မှန်မှန်ပေးသွင်းရန်နှင့် အဆောင်မှ ချမှတ်ထားသော စည်းကမ်းများကို လိုက်နာရပါမည်။"
                "နေ့စဉ်နံနက် ၈း၃၀ နာရီတွင် ကျောင်းဝင်းတံခါးပိတ်မည်ဖြစ်ပါသည်။ ကျောင်းသား၊ ကျောင်းသူကောင်းတစ်ယောက်ပီသစွာ တက္ကသိုလ်/ကောလိပ်က ချမှတ်မည့် စည်းမျဉ်း၊စည်းကမ်းများနှင့်အညီ လိုက်နာကျင့်သုံးနေထိုင်ပါမည်။"
                "မသမာသောနည်းလမ်းဖြင့် စာမေးပွဲဖြေဆိုခြင်းတွေ့ရှိပါက ကျောင်းမှရာသက်ပန်ထုတ်ပယ်ခြင်းခံရမည်ကို သိရှိပါသည်။ သတင်းအချက်အလက်နည်းပညာတက္ကသိုလ်တွင် ဖွင့်လှစ်သည့် မည်သည့်သင်တန်းမဆို နောက်ဆက်တွဲ စာမေးပွဲကျင်းပပေးမည်မဟုတ်ပါ။"
                "ကျောင်းမှထုတ်ပြန်ထားသော အောက်ဖော်ပြပါ စည်းကမ်းချက်များကို ဖတ်ရှု့ပြီးလိုက်နာမည်ဟုကတိပြုပါသည်။ ကိုယ်တိုင်ဝန်ခံချက အထက်ဖော်ပြပါအချက်အားလုံးမှန်ကန်ပါသည်။"
                "တက္ကသိုလ် ဆက်လက်ပညာသင်ခွင့်တောင်းသည်ကိုမိဘ(သို့မဟုတ်) အုပ်ထိန်းသူက သဘောတူပြီးဖြစ်ပါသည်။ ကျောင်းလခများမှန်မှန်ပေးရန် မိဘ(သို့မဟုတ်) အုပ်ထိန်းသူက သဘောတူပြီးဖြစ်ပါသည်။"
                "တက္ကသိုလ်ကျောင်းသားကောင်းတစ်ယောက်ပီသစွာ တက္ကသိုလ်/ကောလိပ်က ချမှတ်သည့် စည်းမျဉ်း၊စည်းကမ်းများနှင့်အညီ လိုက်နာကျင့်သုံးနေထိုင်ပါမည်။",

              style: new TextStyle(
                  fontSize: 16.5,
                  color: Colors.black87),
            ),
            ),
          )
        ],
      ),
    );
  }
}
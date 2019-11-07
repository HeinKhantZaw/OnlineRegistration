import 'package:flutter/material.dart';
import 'ThemeData.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key key, String username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome Student"),
        ),
        body: new Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Name is required';
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Father name',
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Father name is required';
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Roll number',
                  ),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Roll Nummber is required';
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: _agreedToTOS,
                        onChanged: _setAgreedToTOS,
                      ),
                      GestureDetector(
                        onTap: () => _setAgreedToTOS(!_agreedToTOS),
                        child: const Text(
                          'I agree to the Terms of Services and Privacy Policy',
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    OutlineButton(
                      highlightedBorderColor: Colors.black,
                      onPressed: _submittable() ? _submit : null,
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    _formKey.currentState.validate();
    print('Form submitted');
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}

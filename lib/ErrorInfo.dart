import 'package:flutter/material.dart';

import 'ThemeData.dart';

String username = '';
String time = '';

class ErrorInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildThemeData(),
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return buildError(context, errorDetails);
        };

        return widget;
      },
    );
  }

  Widget buildError(BuildContext context, FlutterErrorDetails errorDetails) {
    return Scaffold(
        body: Center(
      child: Text(
        "Sorry please try again. Your username or password is wrong.",
        style: Theme.of(context).textTheme.title,
      ),
    ));
  }
}

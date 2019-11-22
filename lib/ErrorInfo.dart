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
      title: 'Error',
    );
  }

  Widget buildError(BuildContext context, FlutterErrorDetails errorDetails) {
    return Scaffold(
        body: Center(
      child: Text(
        " Please try again.",
        style: Theme.of(context).textTheme.title,
      ),
    ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

Widget buttonPrimary(BuildContext context,String text,VoidCallback action) {
  return Container(
    width: 300,
    height: 60,
    child: RaisedButton(
      onPressed: () async {
        action();
      },
      color: Style().primaryColor(),
      disabledColor: Style().primaryColor(),
      disabledTextColor: Colors.white,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Text(
        text,
        style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold,fontStyle:FontStyle.italic),
      ),
    ),
  );
}

Widget buttonSeccondary(BuildContext context,String text,VoidCallback action) {
  return Container(
    width: 300,
    height: 60,
    child: RaisedButton(
      onPressed: () async{
        action();
      },
      color: Colors.green,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Text(
        text,
        style: TextStyle(fontSize: 20.0),
      ),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String message,
  required ToastStates state,
  required int duartion
}) =>  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: duartion,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 17.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.blue;
      break;
    case ToastStates.WARNING:
      color = Colors.grey;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
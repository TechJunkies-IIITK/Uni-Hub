
import 'package:flutter/material.dart';

enum SnackBarType{
  success,
  error,
  info
}

Color _getColorByType(dynamic type){

  switch(type){

    case SnackBarType.success: return Colors.lightGreen;

    case SnackBarType.error: return Colors.redAccent;

    case SnackBarType.info: return Colors.tealAccent;

    default: return Colors.white;

  }
}

void showSnackBar(String message , BuildContext context, dynamic messageType){

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(

    content: Text(message , style: const TextStyle( color: Colors.white ),),

    backgroundColor: _getColorByType(messageType),

  ));

}
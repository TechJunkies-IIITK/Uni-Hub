
import 'package:flutter/material.dart';

enum SnackBarType{
  success,
  error,
  info
}

Color _getColorByType(dynamic type){

  switch(type){

    case SnackBarType.success: return Colors.green;

    case SnackBarType.error: return Colors.red;

    case SnackBarType.info: return Colors.teal;

    default: return Colors.blue;

  }
}

void showSnackBar(String message , BuildContext context, dynamic messageType){

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(

    content: Text(message , style: const TextStyle( color: Colors.white ),),

    backgroundColor: _getColorByType(messageType),

  ));

}
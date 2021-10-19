
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackedProfiles extends StatelessWidget{

  static const ringColors = [

    Colors.redAccent, Colors.greenAccent, Colors.blueAccent, Colors.cyanAccent, Colors.orangeAccent,
    Colors.pinkAccent, Colors.tealAccent, Colors.yellowAccent, Colors.amberAccent, Colors.indigoAccent

  ];

  static const padding = 15.0, borderWidth = 5.0, maxLength = 9,boxSize = 40.0;

  final List<String> profileLinks;

  const StackedProfiles({ required this.profileLinks ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int index=0;

    return Stack(

      alignment: Alignment.centerLeft,

      children: profileLinks.sublist(0,min(profileLinks.length, maxLength)).map((url) =>

          Container(

              margin: EdgeInsets.only( left: padding * index),

              decoration: BoxDecoration(

                  shape: BoxShape.circle,

                  border: Border.all( color: ringColors[index++], width: borderWidth )

              ),

              child: SizedBox(

                height: boxSize,

                width: boxSize,

                child: CircleAvatar(

                  backgroundImage: NetworkImage(url),

                ),

              )

          )

      ).toList()..add(Container(

          margin: EdgeInsets.only( left: padding * index),

          decoration: BoxDecoration(

              shape: BoxShape.circle,

              border: Border.all( color: Colors.transparent, width: borderWidth )

          ),

          child: profileLinks.length >= maxLength ? const SizedBox(

            height: boxSize,

            width: boxSize,

            child: CircleAvatar(

              backgroundImage: AssetImage('assets/images/add_icon_circle.png'),

            ),

          ) : const SizedBox(width: 0,height: 0,)

      ))

    );

  }

}
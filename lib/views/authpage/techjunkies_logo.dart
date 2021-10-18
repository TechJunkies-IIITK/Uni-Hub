

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TechJunkiesLogo extends StatelessWidget{

  const TechJunkiesLogo({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return Stack(

      alignment: Alignment.topCenter,

      children: const [

        ClipRRect(

          borderRadius: BorderRadius.all(Radius.circular(15)),

          child: Align(

            alignment: Alignment.centerLeft,

            heightFactor: 0.3,

            widthFactor: 1.0,

            child: Image(image: AssetImage('assets/images/techjunkies_logo.png',),),

          ),

        ),

        Text(
            'Powered By',

          style: TextStyle(

            color: Colors.white,

            shadows: [

              Shadow(color: Colors.white30,offset: Offset(1,1))

            ]

          ),
        ),

      ],
    );
  }

}
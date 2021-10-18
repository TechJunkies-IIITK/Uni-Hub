
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unihub/views/homepage/stacked_profiles.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const  lst = ['https://picsum.photos/300','https://picsum.photos/400','https://picsum.photos/200/300','https://picsum.photos/300/400','https://picsum.photos/250','https://picsum.photos/400','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200'];

    return const Scaffold(

      body: Center(

        child: StackedProfiles(profileLinks: lst),

      ),

    );
  }


}
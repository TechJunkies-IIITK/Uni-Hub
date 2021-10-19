
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:unihub/views/homepage/stacked_profiles.dart';

class RoomCard extends StatelessWidget{

  final String roomName, adminName, roomTopic;

  final int roomUserCount;

  final List<String> profileLinks;

  const RoomCard({

    required this.adminName,

    required this.roomUserCount,

    required this.roomName,

    required this.roomTopic,

    required this.profileLinks, Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    return Card(

      color: Colors.blue,

      elevation: 10.0,

      borderOnForeground: true,

      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),

      margin: const EdgeInsets.all(10.0),

      shadowColor: Colors.deepPurple,

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,

        mainAxisSize: MainAxisSize.min,

        children: [

          Text(roomName ,
            style: const TextStyle( fontSize: 20.0, color: Colors.yellowAccent, fontWeight: FontWeight.bold),
          ),

          Align(

            alignment: Alignment.centerLeft,

            child: Text(roomTopic,
              style: const TextStyle( color: Colors.black, fontWeight: FontWeight.w500,),
            ),

          ),

          Row(

            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              
              StackedProfiles(profileLinks: profileLinks),

              Text( 'Join ' + (roomUserCount == 1 ? adminName : '$adminName & ${roomUserCount-1} others') )

            ],

          ),

          TextButton(

            onPressed: (){/*join room*/},

            child: const Chip(

              backgroundColor: Colors.green,

              avatar: Icon(Icons.add_circle_outline, color: Colors.white,),

              label: Text('Join Room')

            ),

          ),

        ],

      ),

    );

  }



}
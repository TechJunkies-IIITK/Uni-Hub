
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:unihub/controllers/socket_controller.dart';
import 'package:unihub/models/hub_details.dart';
import 'package:unihub/views/homepage/stacked_profiles.dart';

class RoomCard extends StatelessWidget{

  final HubDetails hubDetails;

  const RoomCard({required this.hubDetails, Key? key}) : super(key: key);

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

          Text(hubDetails.name ,

            style: const TextStyle( fontSize: 20.0, color: Colors.yellowAccent, fontWeight: FontWeight.bold),

          ),

          Align(

            alignment: Alignment.centerLeft,

            child: Text(hubDetails.topic,

              style: const TextStyle( color: Colors.black, fontWeight: FontWeight.w500,),

            ),

          ),

          Row(

            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              
              StackedProfiles(profileLinks: hubDetails.users.map((e) => e.profileLink).toList()),

              Flexible(child: Text( 'Join ' + (hubDetails.users.length == 1 ? hubDetails.adminName : '${hubDetails.adminName} & ${hubDetails.users.length-1} others'), overflow: TextOverflow.clip, ))

            ],

          ),

          TextButton(

            onPressed: (){

              SocketController.socket.emit('join',{

                'isPublic': true,

                'hubID': hubDetails.id

              });

            },

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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:unihub/views/homepage/room_card.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const  lst = ['https://picsum.photos/300','https://picsum.photos/400','https://picsum.photos/200/300','https://picsum.photos/300/400','https://picsum.photos/250','https://picsum.photos/400','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200'];

    return Scaffold(

      appBar: AppBar(

        automaticallyImplyLeading: false,

        title: const Text('HomePage'),

      ),

      body: ListView(

        children: const [

          RoomCard(adminName: 'Admin', roomUserCount: 15, roomName: 'DankRoom', roomTopic: 'Dank jokes', profileLinks: lst),

          RoomCard(adminName: 'Admin', roomUserCount: 15, roomName: 'DankRoom', roomTopic: 'Dank jokes', profileLinks: lst)

        ],

      ),

      floatingActionButton: Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          TextButton(

            onPressed: (){},

            child: const Chip(

              backgroundColor: Colors.blue,

              avatar: Icon(Icons.add ,  color:  Colors.white,),

              label: Text('Create New Room',
                style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white),
              ),

            ),

          ),

          TextButton(

            onPressed: (){},

            child: const Chip(

              backgroundColor: Colors.deepPurple,

              avatar: Icon(Icons.double_arrow_outlined ,  color:  Colors.white,),

              label: Text('Join Private Room',
                style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white),
              ),

            ),

          ),

        ],

      )

    );
  }


}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:unihub/controllers/socket_controller.dart';
import 'package:unihub/models/user_details.dart';
import 'package:unihub/views/homepage/create_room_dialog.dart';
import 'package:unihub/views/homepage/mutable_app_bar.dart';
import 'package:unihub/views/homepage/private_room_dialog.dart';
import 'package:unihub/views/homepage/room_bottom_sheet.dart';
import 'package:unihub/views/homepage/room_card.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  String roomName='';

  @override
  Widget build(BuildContext context) {

    SocketController.connect();

    return Scaffold(

      appBar: PreferredSize(

        preferredSize: const Size.fromHeight(60),

        child: MutableAppBar( onSearch: (value){ /*perform search*/ }, ),

      ),

      body: ListView(

        children: SocketController.publicHubs.map(
                (hub) =>
                RoomCard(adminName: hub.adminName, roomUserCount: hub.users.length, roomName: hub.name, roomTopic: hub.topic, profileLinks: hub.users.map((e) => e.profileLink).toList())
        ).toList(),

      ),

      floatingActionButton: Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          TextButton(

            onPressed: ()=>showDialog(context: context, builder: (ctx) => CreateRoomDialog()),

            child: const Chip(

              backgroundColor: Colors.blue,

              avatar: Icon(Icons.add ,  color:  Colors.white,),

              label: Text('Create New Room',

                style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white),

              ),

            ),

          ),

          TextButton(

            onPressed: ()=>showDialog(context: context, builder: (ctx) => PrivateRoomDialog()),

            child: const Chip(

              backgroundColor: Colors.deepPurple,

              avatar: Icon(Icons.double_arrow_outlined ,  color:  Colors.white,),

              label: Text('Join Private Room',
                style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white),
              ),

            ),

          ),

        ],

      ),

      bottomNavigationBar: roomName.isEmpty? const SizedBox(height: 0,width: 0,): BottomAppBar(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              Tooltip(

                message: 'Open Bottom Sheet',

                child: IconButton(

                    icon: const Icon(Icons.remove),

                    onPressed: () => showModalBottomSheet(

                        context: context,

                        builder: (ctx) => Container( padding: const EdgeInsets.all(10.0),child: RoomBottomSheet(roomName: roomName))

                    )

                ),
              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Text(roomName,style: const TextStyle( fontSize: 20.0, color: Colors.blue),),

                  Tooltip(

                    message: 'Leave Room',

                    child: IconButton(

                        onPressed: (){},

                        icon: const Icon(Icons.close)

                    ),
                  )

                ],

              ),
            ],
          )

      ),

    );
  }

}
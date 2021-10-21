
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:unihub/models/user_details.dart';
import 'package:unihub/views/homepage/room_bottom_sheet.dart';
import 'package:unihub/views/homepage/room_card.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const roomName = 'UniHub Developers';

    final profiles = [
      UserDetails('User1', 'https://picsum.photos/300', true),
      UserDetails('User2', 'https://picsum.photos/400', true),
      UserDetails('User3', 'https://picsum.photos/500', true),
      UserDetails('User4', 'https://picsum.photos/200/300', true),
      UserDetails('User5', 'https://picsum.photos/250', true),
      UserDetails('User6', 'https://picsum.photos/350', false),
      UserDetails('User7', 'https://picsum.photos/300/200', false),
      UserDetails('User8', 'https://picsum.photos/500', false),
      UserDetails('User9', 'https://picsum.photos/300', false),
      UserDetails('User10', 'https://picsum.photos/400', false),
    ];

    const  lst = ['https://picsum.photos/300','https://picsum.photos/400','https://picsum.photos/200/300','https://picsum.photos/300/400','https://picsum.photos/250','https://picsum.photos/400','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200'];

    return Scaffold(

      appBar: AppBar(

        automaticallyImplyLeading: false,

        title: const Text('HomePage'),

      ),

      body: ListView(

        children: [

          const RoomCard(adminName: 'Admin', roomUserCount: 15, roomName: 'DankRoom', roomTopic: 'Dank jokes', profileLinks: lst),

          RoomCard(adminName: 'Admin', roomUserCount: 15, roomName: 'DankRoom', roomTopic: 'Dank jokes', profileLinks: profiles.map((e) => e.profileLink).toList())

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

      ),

      bottomNavigationBar: BottomAppBar(

        child: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            Tooltip(

              message: 'Open Bottom Sheet',

              child: IconButton(

                  icon: const Icon(Icons.remove),

                  onPressed: () => showModalBottomSheet(

                      context: context,

                      builder: (ctx) => Container( padding: const EdgeInsets.all(10.0),child: RoomBottomSheet(profiles: profiles, roomName: roomName))

                  )

              ),
            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                const Text(roomName,style: TextStyle( fontSize: 20.0, color: Colors.blue),),

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
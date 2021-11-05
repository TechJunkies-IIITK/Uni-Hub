
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unihub/controllers/socket_controller.dart';

class RoomBottomSheet extends StatefulWidget{
  final String roomName;

  const RoomBottomSheet({required this.roomName, Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _RoomBottomSheetState createState() => _RoomBottomSheetState(roomName: roomName);
}

class _RoomBottomSheetState extends State<RoomBottomSheet>{

  final String roomName;
  
  _RoomBottomSheetState({required this.roomName});

  @override
  void initState() {
    super.initState();
    SocketController.connect();//remove later
    SocketController.onUserJoin = (){
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              const SizedBox( width: 100, height: 5,),

              Tooltip(

                message: 'Close Bottom Sheet',

                child: IconButton(

                  icon: const Icon(Icons.remove),

                  onPressed: () {

                    if(Navigator.canPop(context)) Navigator.pop(context);

                  },

                ),
              ),

              TextButton(

                style: ButtonStyle(

                  backgroundColor: MaterialStateProperty.all( Colors.redAccent )

                ),

                onPressed: (){},

                child: Row(

                  mainAxisSize: MainAxisSize.min,

                  children: const [

                    Text('Leave Room', style: TextStyle( color: Colors.white ),),

                    Icon(Icons.arrow_forward, color: Colors.white,)

                  ],

                )

              )

            ],

          ),

          const Divider( thickness: 1.0, color: Colors.teal,),

          Text(roomName, style: const TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold),),

          const Text('Speakers'),

          Wrap(

            children: SocketController.users.map((e) => Container(

              margin: const EdgeInsets.all(10.0),

              child: Column(

                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  CircleAvatar(backgroundImage: NetworkImage(e.profileLink),),

                  Text(e.name)

                ],

              ),

            )).toList(),

          ),

          /*
          // future use
          const Text('Audience'),

          Wrap(

            children: SocketController.users.where((e) => !e.hasSpeakerRole).map((e) => Container(

              margin: const EdgeInsets.all(5.0),

              child: Column(

                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  CircleAvatar(backgroundImage: NetworkImage(e.profileLink),),

                  Text(e.name)

                ],

              ),

            )).toList(),

          ),*/

        ],

      ),
    );
  }
  
}

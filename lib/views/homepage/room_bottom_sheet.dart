
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unihub/models/user_details.dart';

class RoomBottomSheet extends StatelessWidget{

  final List<UserDetails> profiles;

  final String roomName;
  
  const RoomBottomSheet({required this.profiles, required this.roomName, Key? key}) : super(key: key);

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

            children: profiles.where((e) => e.hasSpeakerRole).map((e) => Container(

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

          const Text('Audience'),

          Wrap(

            children: profiles.where((e) => !e.hasSpeakerRole).map((e) => Container(

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

          ),

        ],

      ),
    );
  }
  
}

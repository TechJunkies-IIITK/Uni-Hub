
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unihub/controllers/shared_preferences_controller.dart';
import 'package:unihub/controllers/socket_controller.dart';
import 'package:unihub/config.dart' as config;
import 'package:unihub/views/snackbar.dart';

class RoomBottomSheet extends StatefulWidget{
  final String roomName;

  const RoomBottomSheet({required this.roomName, Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _RoomBottomSheetState createState() => _RoomBottomSheetState(roomName: roomName);
}

class _RoomBottomSheetState extends State<RoomBottomSheet>{

  late final RtcEngine _engine;

  final String roomName;

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _addListeners();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    _joinChannel();
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        print('joinChannelSuccess $channel $uid $elapsed');
      },
      leaveChannel: (stats) async {
        print('leaveChannel ${stats.toJson()}');
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    await _engine
        .joinChannel(SocketController.agoraToken, SocketController.hubID, null, SharedPrefsController.userID)
        .catchError((onError) {
      print('error ${onError.toString()}');
    });
  }

  _leaveChannel(context) async {
    SocketController.socket.emit('leave',{});
    await _engine.leaveChannel();
    if(Navigator.canPop(context)) Navigator.pop(context);
  }

  _switchMicrophone() {
    _engine.enableLocalAudio(!SocketController.isMicOpen).then((value) {
      setState(() {
        SocketController.isMicOpen = !SocketController.isMicOpen;
      });
    }).catchError((err) {
      print('enableLocalAudio $err');
    });
  }
  
  _RoomBottomSheetState({required this.roomName});

  @override
  void initState() {
    super.initState();
    //SocketController.connect();//remove later
    SocketController.onUserJoin = (){
      setState(() {});
    };
    _initEngine();
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

              Tooltip(

                message: 'Copy Hub Code',

                child: SizedBox(

                    height: 5,

                    width: 100,

                    child: TextButton(

                      child: Text(SocketController.hubCode),

                      onPressed: (){

                        Clipboard.setData( ClipboardData(text: SocketController.hubCode) );

                        showSnackBar("Code copied to clipboard!", context, SnackBarType.info);

                      },

                    )

                ),

              ),

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

                onPressed: ()=>_leaveChannel(context),

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

          Row(

            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [

              IconButton(

                onPressed: _switchMicrophone,

                icon: SocketController.isMicOpen ? const Icon(Icons.mic) : const Icon(Icons.mic_off),

              )

            ],

          )

        ],

      ),
    );
  }
  
}

import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:unihub/config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unihub/controllers/shared_preferences_controller.dart';
import 'package:unihub/controllers/socket_controller.dart';

/// JoinChannelAudio Example
class JoinChannelAudio extends StatefulWidget {
  const JoinChannelAudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelAudio> {
  late final RtcEngine _engine;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  //double _recordingVolume = 0, _playbackVolume = 0;

  @override
  void initState() {
    super.initState();
    _initEngine();
  }

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

  leaveChannel() async {
    await _engine.leaveChannel();
  }

  _switchMicrophone() {
    _engine.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {
      log('enableLocalAudio $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        IconButton(onPressed: _switchMicrophone, icon: openMicrophone? const Icon(Icons.mic): const Icon(Icons.mic_off))

      ],
    );
  }
}
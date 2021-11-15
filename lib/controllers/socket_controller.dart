
import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:unihub/config.dart';
import 'package:unihub/controllers/shared_preferences_controller.dart';
import 'package:unihub/models/hub_details.dart';
import 'package:unihub/models/user_details.dart';

class SocketController {

  static String hubName = '',
      hubTopic = '',
      agoraToken = '',
      hubID = ''
  ;

  //static int adminID = 0;

  static late Function onUserJoin,
      onPublicHubsSearch,
      onDisconnect,
      onCreate
  ;

  static bool isMicOpen = false;

  static List<HubDetails> publicHubs = [];

  static List<UserDetails> users = [];

  static late Socket socket;

  static void connect(){

    socket = io('http://$serverBaseUrl',OptionBuilder().setExtraHeaders({

      'token' : SharedPrefsController.token,

      'userID' : SharedPrefsController.userID

    }).setTransports(['websocket','polling']).build());

    //socket.onConnect((data) => print('hehe'));

    socket.onDisconnect((data) => onDisconnect());

    initListeners();

  }

  static void initListeners(){

    socket.on('public-res', (data) {
      publicHubs.clear();
      for(var obj in data['hubs']){
        publicHubs.add(HubDetails.fromJSON(obj));
        onPublicHubsSearch();
      }
      //print(publicHubs);
    });

    socket.on('create-res',(data){
      //print(data);
      if(data['message'] == 'success') {
        hubName = data['hubName'];
        hubTopic = data['hubTopic'];
        hubID = data['hubID'];
        agoraToken = data['token'];
        //adminID = data['adminID'];
        users.clear();
        for(var obj in data['users']){
          users.add(UserDetails.fromJSON(obj));
        }
        onCreate();
      }
    });

    socket.on('join-res',(data){
      //print('join=>$data');
      if(data['message'] == 'success') {
        hubName = data['hubName'];
        hubTopic = data['hubTopic'];
        hubID = data['hubID'];
        agoraToken = data['token'];
        //adminID = data['adminID'];
        users.clear();
        for(var obj in data['users']){
          users.add(UserDetails.fromJSON(obj));
        }
        onCreate();
      }
    });

    socket.on('join-new',(data){
      users.clear();
      for(var obj in data['users']){
        users.add(UserDetails.fromJSON(obj));
        onUserJoin();
      }
    });

  }

}

import 'package:socket_io_client/socket_io_client.dart';
import 'package:unihub/config.dart';
import 'package:unihub/controllers/shared_preferences_controller.dart';
import 'package:unihub/models/hub_details.dart';
import 'package:unihub/models/user_details.dart';

class SocketController {

  static late List<HubDetails> publicHubs = [];

  static List<UserDetails> users = [];

  static late Socket socket;

  static void connect(){

    socket = io(serverBaseUrl, {
      'auth' : {
        'token' : SharedPrefsController.token,
        'userID' : SharedPrefsController.userID
      }
    });

    socket.connect();

  }

  static late Function onUserJoin, onPublicHubsSearch;

  static void initListeners(){

    socket.on('public-res', (data) {
      publicHubs.clear();
      for(var obj in data['hubs']){
        publicHubs.add(HubDetails.fromJSON(obj));
        onPublicHubsSearch();
      }
    });

    socket.on('join-new',(data){
      users.clear();
      for(var obj in data['hubs']){
        users.add(UserDetails.fromJSON(obj));
        onUserJoin();
      }
    });

  }

}
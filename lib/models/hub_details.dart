
import 'package:unihub/models/user_details.dart';

class HubDetails{

  final String name, id, topic, adminName;

  final List<UserDetails> users;

  final bool isPublic;

  HubDetails.fromJSON(data):
        name = data['hubName'], id = data['hubID'], isPublic = data['isPublic'],
        users=List.from(data['users']).map((e)=>UserDetails.fromJSON(e)).toList(),
        adminName = data['adminName'] ?? '', topic = data['hubTopic'];

  @override
  String toString() {
    return 'HubDetails{name: $name, id: $id, topic: $topic, adminName: $adminName, users: $users, isPublic: $isPublic}';
  }
}
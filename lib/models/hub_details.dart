
class HubDetails{

  final String name, id;

  final bool isPublic;

  HubDetails.fromJSON(data): name = data['hubName'], id = data['hubID'], isPublic = data['isPublic'];

}
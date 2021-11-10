
class UserDetails{

  final String name,profileLink;

  final int userID;

  UserDetails(this.name, this.profileLink, this.userID);

  UserDetails.fromJSON(data) :
        name = data['name'], profileLink = data['profileLink'], userID = data['userID'];

}
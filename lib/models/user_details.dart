
class UserDetails{

  final String _name, _profileLink;

  bool hasSpeakerRole;

  String get name => _name;

  String get profileLink => _profileLink;

  UserDetails(String name, String profileLink, this.hasSpeakerRole) : _name = name, _profileLink = profileLink;

}
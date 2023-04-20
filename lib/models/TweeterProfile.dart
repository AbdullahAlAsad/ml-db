class TweeterProfile {
  final String type;
  final String username;
  final String id;
  final String displayname;
  final String rawDescription;
  final String renderedDescription;
  final String? descriptionLinks;
  final String verified;
  final String created;
  final String followersCount;
  final String friendsCount;
  final String statusesCount;
  final String favouritesCount;
  final String listedCount;
  final String mediaCount;
  final String location;
  final String protected;
  final String? link;
  final String profileImageUrl;
  final String profileBannerUrl;
  final String? label;
  final String description;
  final String? descriptionUrls;
  final String? linkTcourl;
  final String? linkUrl;
  final String url;

  TweeterProfile({
    required this.type,
    required this.username,
    required this.id,
    required this.displayname,
    required this.rawDescription,
    required this.renderedDescription,
    this.descriptionLinks,
    required this.verified,
    required this.created,
    required this.followersCount,
    required this.friendsCount,
    required this.statusesCount,
    required this.favouritesCount,
    required this.listedCount,
    required this.mediaCount,
    required this.location,
    required this.protected,
    this.link,
    required this.profileImageUrl,
    required this.profileBannerUrl,
    this.label,
    required this.description,
    this.descriptionUrls,
    this.linkTcourl,
    this.linkUrl,
    required this.url,
  });

  factory TweeterProfile.fromJson(Map<String, dynamic> json) {
    return TweeterProfile(
      type: json['_type'],
      username: json['username'],
      id: json['id'],
      displayname: json['displayname'],
      rawDescription: json['rawDescription'],
      renderedDescription: json['renderedDescription'],
      descriptionLinks: json['descriptionLinks'],
      verified: json['verified'],
      created: json['created'],
      followersCount: json['followersCount'],
      friendsCount: json['friendsCount'],
      statusesCount: json['statusesCount'],
      favouritesCount: json['favouritesCount'],
      listedCount: json['listedCount'],
      mediaCount: json['mediaCount'],
      location: json['location'],
      protected: json['protected'],
      link: json['link'],
      profileImageUrl: json['profileImageUrl'],
      profileBannerUrl: json['profileBannerUrl'],
      label: json['label'],
      description: json['description'],
      descriptionUrls: json['descriptionUrls'],
      linkTcourl: json['linkTcourl'],
      linkUrl: json['linkUrl'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_type': type,
      'username': username,
      'id': id,
      'displayname': displayname,
      'rawDescription': rawDescription,
      'renderedDescription': renderedDescription,
      'descriptionLinks': descriptionLinks,
      'verified': verified,
      'created': created,
      'followersCount': followersCount,
      'friendsCount': friendsCount,
      'statusesCount': statusesCount,
      'favouritesCount': favouritesCount,
      'listedCount': listedCount,
      'mediaCount': mediaCount,
      'location': location,
      'protected': protected,
      'link': link,
      'profileImageUrl': profileImageUrl,
      'profileBannerUrl': profileBannerUrl,
      'label': label,
      'description': description,
      'descriptionUrls': descriptionUrls,
      'linkTcourl': linkTcourl,
      'linkUrl': linkUrl,
      'url': url
    };
  }
}
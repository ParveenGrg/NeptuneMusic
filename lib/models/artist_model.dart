class ArtistModel {
  String? name;
  String? artistname;
  String? avatar;

  ArtistModel({
    this.name,
    this.artistname,
    this.avatar,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
        name: json['first_name'] + ' ' + json['last_name'] as String?,
        artistname: json['username'] as String?,
        avatar: json['avatar'] as String?,
      );
}

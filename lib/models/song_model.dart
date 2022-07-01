class SongModel {
  String? songid;
  String? songname;
  String? artistid;
  String? trackid;
  String? duration;
  String? coverImageUrl;
  String? name;

  SongModel({
    this.songid,
    this.songname,
    this.artistid,
    this.trackid,
    this.duration,
    this.coverImageUrl,
    this.name,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        songid: json['songid'] as String?,
        songname: json['songname'] as String?,
        artistid: json['userid'] as String?,
        trackid: json['trackid'] as String?,
        duration: json['duration'] as String?,
        coverImageUrl: json['cover_image_url'] as String?,
        name: json['first_name'] + ' ' + json['last_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'songid': songid,
        'songname': songname,
        'userid': artistid,
        'trackid': trackid,
        'duration': duration,
        'cover_image_url': coverImageUrl,
      };
}

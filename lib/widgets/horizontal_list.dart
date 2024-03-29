import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:neptune_music/controller/main_controller.dart';
import 'package:neptune_music/models/artist_model.dart';
import 'package:neptune_music/models/song_model.dart';
import 'package:neptune_music/screens/artist_profile/artist_profile.dart';
import 'package:neptune_music/utils/loading_image.dart';
import 'package:neptune_music/widgets/bottom_sheet.dart';

class HorizontalSongList extends StatelessWidget {
  final List<SongModel> songs;
  final MainController con;
  const HorizontalSongList({Key? key, required this.songs, required this.con})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          ...songs
              .map(
                (song) => InkWell(
                  onTap: () {
                    con.playSong(
                        con.convertToAudio(songs), songs.indexOf(song));
                  },
                  onLongPress: () {
                    showModalBottomSheet(
                        useRootNavigator: true,
                        isScrollControlled: true,
                        elevation: 100,
                        backgroundColor: Colors.black38,
                        context: context,
                        builder: (context) {
                          return BottomSheetWidget(
                            con: con,
                            song: song,
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ),
                    child: SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: song.coverImageUrl!,
                              width: 150,
                              height: 150,
                              progressIndicatorBuilder: (context, url, l) =>
                                  const LoadingImage(size: 80),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            song.songname!,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}

class HorizontalArtistList extends StatelessWidget {
  final List<ArtistModel> artists;
  final MainController con;
  const HorizontalArtistList({
    Key? key,
    required this.artists,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          ...artists
              .map(
                (artist) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArtistProfile(
                                artistname: artist.artistname!, con: con)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: artist.avatar!,
                              width: 150,
                              height: 150,
                              progressIndicatorBuilder: (context, url, l) =>
                                  const LoadingImage(
                                size: 80,
                                icon: Icon(
                                  LineIcons.user,
                                  size: 80,
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            artist.name!,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}

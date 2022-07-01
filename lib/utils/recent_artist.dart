import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:neptune_music/controller/main_controller.dart';
import 'package:neptune_music/methods/get_greeting.dart';
import 'package:neptune_music/models/artist_model.dart';
import 'package:neptune_music/routes/create_route.dart';
import 'package:neptune_music/screens/artist_profile/artist_profile.dart';
import 'package:neptune_music/screens/setting/setting.dart';
import 'package:neptune_music/utils/loading_image.dart';

class RecentArtists extends StatelessWidget {
  final List<ArtistModel> artists;
  final MainController con;
  const RecentArtists({
    Key? key,
    required this.artists,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CachedNetworkImage(
        //   imageUrl: artists[0].avatar!,
        //   fit: BoxFit.cover,
        //   height: MediaQuery.of(context).size.height * .15,
        //   width: MediaQuery.of(context).size.width * .67,
        //   alignment: Alignment.topLeft,
        // ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    ...artists
                        .map((artist) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArtistProfile(
                                              artistname: artist.artistname!,
                                              con: con,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                width:
                                    ((MediaQuery.of(context).size.width * .5) -
                                        21.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        bottomLeft: Radius.circular(3),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: artist.avatar!,
                                        width: 55,
                                        height: 55,
                                        progressIndicatorBuilder:
                                            (context, url, l) =>
                                                const LoadingImage(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          artist.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

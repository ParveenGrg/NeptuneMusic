import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neptune_music/controller/main_controller.dart';
import 'package:neptune_music/methods/get_greeting.dart';
import 'package:neptune_music/models/loading_enum.dart';
import 'package:neptune_music/routes/create_route.dart';
import 'package:neptune_music/screens/home/cubit/home_cubit.dart';
import 'package:neptune_music/screens/setting/setting.dart';
import 'package:neptune_music/utils/recent_artist.dart';
import 'package:neptune_music/widgets/horizontal_list.dart';

class HomeScreen extends StatelessWidget {
  final MainController con;
  const HomeScreen({
    Key? key,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUsers(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == LoadPage.loading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state.status == LoadPage.loaded) {
            return Scaffold(
              body: ListView(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          greeting(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context, createRoute(const Settings()));
                            },
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  RecentArtists(
                    con: con,
                    artists: state.artists.sublist(0, 6),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Text(
                      "Popular Hits",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  HorizontalSongList(
                    songs: state.songs.sublist(0, 10),
                    con: con,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Text(
                      "Best Picks For You",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  HorizontalArtistList(
                    artists: state.artists.sublist(6, 16),
                    con: con,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "New Releases",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  HorizontalSongList(
                    con: con,
                    songs: state.songs.sublist(10, 20),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "You might also like",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  HorizontalArtistList(
                    con: con,
                    artists: state.artists.sublist(16),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          }
          if (state.status == LoadPage.error) {
            return const Scaffold(
              body: Center(
                child: Text(
                  "There is problem with the server. Reload",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

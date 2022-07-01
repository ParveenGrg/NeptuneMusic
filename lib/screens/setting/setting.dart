import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neptune_music/routes/create_route.dart';
import 'package:neptune_music/screens/login/login_page.dart';
import 'package:neptune_music/screens/payment/khalti_payment.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          CupertinoSliverNavigationBar(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade700,
                width: .5,
              ),
            ),
            stretch: true,
            backgroundColor: Colors.black87,
            largeTitle: Text(
              "Setting",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          SliverToBoxAdapter(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap: () {},
                  minLeadingWidth: 20,
                  leading: Icon(
                    CupertinoIcons.person_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text(
                    "Parveen Gurung",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // trailing: Icon(
                  //   Icons.arrow_forward_ios,
                  //   color: Colors.grey.shade800,
                  // ),
                  subtitle: Text(
                    "parveengrg247@gmail.com",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Divider(
                  thickness: .4,
                  color: Colors.grey.shade900,
                ),
                ListTile(
                  onTap: () {
                    launch("https://www.instagram.com/parveengrg/");
                  },
                  minLeadingWidth: 20,
                  leading: Icon(
                    FontAwesomeIcons.instagram,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text(
                    "Follow me on Instagram",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade800,
                  ),
                  subtitle: Text(
                    "Stay on top of latest updates.",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Divider(
                  thickness: .4,
                  color: Colors.grey.shade900,
                ),
                ListTile(
                  onTap: () {
                    launch(
                        'https://www.linkedin.com/in/dhugraj-gurung-3a9451214/');
                  },
                  minLeadingWidth: 20,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade800,
                  ),
                  leading: Icon(
                    FontAwesomeIcons.linkedin,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text(
                    "Connect me on Linkdin",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "To see my previous posts about flutter",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Divider(
                  thickness: .4,
                  color: Colors.grey.shade900,
                ),
                ListTile(
                  onTap: () {
                    launch(
                        'mailto:parveengrg247@gmail.com?subject=Bug report (Photoarc)&body=Hi,i want to report a bug.');
                  },
                  minLeadingWidth: 20,
                  leading: Icon(
                    FontAwesomeIcons.bug,
                    color: Theme.of(context).primaryColor,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade800,
                  ),
                  title: const Text(
                    "Report a Bug",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Help me to imporve the application.",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Divider(
                  thickness: .4,
                  color: Colors.grey.shade900,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context, createRoute(const KhaltiPaymentPage()));
                  },
                  minLeadingWidth: 20,
                  leading: Icon(
                    CupertinoIcons.info,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text(
                    "Upgrade to Premium",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Enjoy Unlimited Content",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () async {
                      var recentSearch = Hive.box('RecentSearch');
                      var liked = Hive.box('liked');
                      var recentlyPlayed = Hive.box('RecentlyPlayed');
                      var playlist = Hive.box('playlists');
                      await recentSearch.clear();
                      await liked.clear();
                      await recentlyPlayed.clear();
                      await playlist.clear();
                      await FirebaseAuth.instance.signOut();
                      Navigator.push(context, createRoute(const AuthPage()));
                      Future.delayed(const Duration(microseconds: 500), () {
                        Phoenix.rebirth(context);
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:neptune_music/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:neptune_music/screens/login/login_page.dart';
import 'package:neptune_music/screens/verify_email/verify_email.dart';
import 'package:neptune_music/utils/palette.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var dir = await getApplicationSupportDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('RecentSearch');
  await Hive.openBox('liked');
  await Hive.openBox('RecentlyPlayed');
  await Hive.openBox('playlists');
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool? isLogin = preferences.getBool('isLogin');
  bool? isVerify = preferences.getBool('verify');
  bool? isCreateUser = preferences.getBool('createUser');
  runApp(
    Phoenix(
      child: MyApp(
        isVerify: isVerify,
        isCreateUser: isCreateUser,
        isLogin: isLogin,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isLogin;
  final bool? isVerify;
  final bool? isCreateUser;

  const MyApp({
    Key? key,
    this.isLogin,
    this.isVerify,
    this.isCreateUser,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_d910b9e7cb354b09b64647615beb5e5d",
        builder: (context, navigatorkey) {
          return MaterialApp(
            navigatorKey: navigatorkey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Neptune Music',
            theme: ThemeData(
              fontFamily: 'Inter',
              canvasColor: Colors.transparent,
              shadowColor: Colors.transparent,
              highlightColor: Colors.transparent,
              scaffoldBackgroundColor: const Color.fromARGB(1, 19, 23, 34),
              splashColor: const Color.fromARGB(100, 41, 98, 255),
              hoverColor: Colors.transparent,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              progressIndicatorTheme: const ProgressIndicatorThemeData(
                color: Color.fromARGB(255, 41, 98, 255),
                circularTrackColor: Color.fromARGB(200, 41, 98, 255),
                linearTrackColor: Color.fromARGB(2, 41, 98, 255),
                refreshBackgroundColor: Colors.black,
                linearMinHeight: .5,
              ),
              textTheme: const TextTheme(
                headline1: TextStyle(
                  fontFamily: 'SFUIDisplay Bold',
                  fontSize: 40,
                  //fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                headline2: TextStyle(
                  fontFamily: 'SFUIDisplay Bold',
                  fontSize: 25,
                  color: Colors.white,
                ),
                headline4: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'SFUIDisplay Medium',
                  fontWeight: FontWeight.bold,
                ),
                bodyText1: TextStyle(
                  fontFamily: 'SFUIDisplay Regular',
                  fontSize: 14,
                  color: Colors.white,
                  //fontWeight: FontWeight.bold,
                ),
                bodyText2: TextStyle(
                  fontFamily: "SFUIDisplay Light",
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              primarySwatch: Palette.kToDark,
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                      color: Colors.grey.shade700,
                      width: 1,
                    ),
                  ),
                ),
              ),
              buttonTheme: const ButtonThemeData(minWidth: double.infinity),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(.7),
                ),
                fillColor: const Color.fromARGB(255, 30, 34, 45),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: .5,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: .5,
                  ),
                ),
              ),
            ),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: child!,
                ),
              );
            },
            home: getHomeScreen(),
          );
        });
  }

  getHomeScreen() {
    if (isLogin != null && isVerify == null) {
      return const VerifyEmail();
      // } else if (isLogin != null && isVerify != null && isCreateUser == null) {
      //   return const CreateUser();
    } else if (isLogin != null && isVerify != null && isCreateUser != null) {
      return const App();
    } else {
      return const AuthPage();
    }
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

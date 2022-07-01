import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:neptune_music/controller/main_controller.dart';
import 'package:neptune_music/screens/home/home_screen.dart';
import 'package:neptune_music/screens/library/library_screen.dart';
import 'package:neptune_music/screens/search/search_screen.dart';
import 'package:neptune_music/widgets/bottom_nav_bar.dart';
import 'package:neptune_music/widgets/bottom_player.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Page1") {
            _selectTab("Page1", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: ChangeNotifierProvider(
        create: (context) => MainController()..init(),
        child: Consumer<MainController>(
          builder: (context, con, child) {
            return Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: <Widget>[
                  _buildOffstageNavigator(con, "Page1"),
                  _buildOffstageNavigator(con, "Page2"),
                  _buildOffstageNavigator(con, "Page3"),
                ],
              ),
              bottomNavigationBar: CustomCupertinoTabBar(
                bottomPlayWidget: PlayWidget(con: con),
                activeColor: Colors.white,
                backgroundColor: Colors.transparent,
                iconSize: 24.0,
                onTap: (int index) {
                  _selectTab(pageKeys[index], index);
                },
                currentIndex: _selectedIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(LineIcons.home),
                    label: 'Home',
                    activeIcon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(CupertinoIcons.search),
                    label: 'Search',
                    icon: Icon(CupertinoIcons.search),
                  ),
                  BottomNavigationBarItem(
                    label: 'Library',
                    activeIcon:
                        Icon(CupertinoIcons.list_bullet_below_rectangle),
                    icon: Icon(CupertinoIcons.list_bullet_below_rectangle),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(MainController con, String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        con: con,
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
    required this.con,
  }) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final MainController con;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    if (tabItem == "Page1") {
      child = HomeScreen(con: con);
    } else if (tabItem == "Page2") {
      child = SearchPage(con: con);
    } else if (tabItem == "Page3") {
      child = LibraryScreen(con: con);
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return CupertinoPageRoute(builder: (context) => child);
      },
    );
  }
}

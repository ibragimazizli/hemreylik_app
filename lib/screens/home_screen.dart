import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemreyliyin_sesi/screens/info_screen.dart';
import 'package:hemreyliyin_sesi/screens/main_page.dart';
import 'package:hemreyliyin_sesi/screens/partnyors.dart';
import 'package:hemreyliyin_sesi/screens/profile.dart';
import 'package:hemreyliyin_sesi/screens/test_rec.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = PersistentTabController(initialIndex: 0);

    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      MainPage(
        onTabChanged: (int index) {
          setState(() {
            _controller.index = index;
          });
        },
      ),
      InfoScreen(
        onTabChanged: (int index) {
          setState(() {
            _controller.index = index;
          });
        },
      ),
      RecordPage(
        onTabChanged: (int index) {
          setState(() {
            _controller.index = index;
          });
        },
      ),
      const Partnyors(),
      const Profile()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.red,
        icon: Image.asset("assets/icons/Home.png"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.red,
        icon: Image.asset("assets/icons/info.png"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.red,
        icon: SizedBox(
          width: 40,
          height: 40,
          child: Image.asset("assets/icons/mic icon.png"),
        ),
        // iconSize: 60,

        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.red,
        icon: Image.asset("assets/icons/partnyor.png"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.red,
        icon: Image.asset("assets/icons/User.png"),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      onItemSelected: (int index) {
        setState(() {
          _controller.index = index;
        });
      },
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_2/data/api/api_service.dart';
import 'package:restaurant_app_2/provider/bottomnav_provider.dart';
import 'package:restaurant_app_2/provider/restaurant_provider.dart';
import 'package:restaurant_app_2/ui/restaurant_list_page.dart';
import 'package:restaurant_app_2/ui/search_restaurant_page.dart';
import 'package:restaurant_app_2/widgets/platform_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: RestaurantListPage(),
    ),
    SearchRestaurantPage()
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.list_bullet : Icons.public),
        label: "List"),
    BottomNavigationBarItem(
        icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
        label: "Search"),
  ];

  Widget _buildAndroid(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);

    return Scaffold(
      body: _listWidget[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        items: _bottomNavBarItems,
        onTap: (index) {
          provider.currentIndex = index;
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: _bottomNavBarItems),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarProvider>(
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
      create: (BuildContext context) => BottomNavigationBarProvider(),
    );
  }
}

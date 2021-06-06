import 'package:flutter/material.dart';
import 'ad_institution.dart';
import 'adminhomepage.dart';
import 'employees.dart';
import 'test.dart';

class TabNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  TabNavigator({this.navigatorKey, this.tabItem});

  @override
  _TabNavigatorState createState() =>
      _TabNavigatorState(this.navigatorKey, this.tabItem);
}

class _TabNavigatorState extends State<TabNavigator> {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  _TabNavigatorState(this.navigatorKey, this.tabItem);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Page1")
      child = AdminHomePage();
    else if (tabItem == "Page2")
      child = AdminInstitutionSc();
    else if (tabItem == "Page3")
      child = TestNav();
    else if (tabItem == "Page4") child = EmployeesSc();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

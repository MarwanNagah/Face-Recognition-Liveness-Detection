import 'package:face_liveness_detection_app/Models/user.dart';
import 'package:face_liveness_detection_app/Providers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'admin_appbar.dart';
import 'tab_navigator.dart';

class Adminpage extends StatefulWidget {
  final User user;

  Adminpage({@required this.user});
  @override
  _AdminpageState createState() => _AdminpageState(this.user);
}

class _AdminpageState extends State<Adminpage> {
  final User user;
  final AuthService _auth = AuthService();
  _AdminpageState(this.user);

  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1)}";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Page1") {
            _selectTab("Page1", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        appBar: AdAppBar(
          titlex: new Text(
            ' Mr. ${capitalize(user.firstName)} ${capitalize(user.lastName)}',
            style: TextStyle(fontSize: 20.0),
          ),
          editProfile: () {},
          settings: () {},
          signout: () async {
            await _auth.signOut();
          },
        ),
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Page1"),
          _buildOffstageNavigator("Page2"),
          _buildOffstageNavigator("Page3"),
          _buildOffstageNavigator("Page4"),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.shifting,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          backgroundColor: Color(0xff30384c),
          selectedItemColor: Colors.greenAccent[400],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              title: Text("Notification"),
              backgroundColor: Color(0xff30384c),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_city),
                title: Text("Institution"),
                backgroundColor: Color(0xff30384c)),
            BottomNavigationBarItem(
              icon: Icon(Icons.recent_actors_sharp),
              title: Text("Report"),
              backgroundColor: Color(0xff30384c),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              title: Text("Employees"),
              backgroundColor: Color(0xff30384c),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.edit),
            //   title: Text("Edit users"),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}

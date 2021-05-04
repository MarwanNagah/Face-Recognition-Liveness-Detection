import 'package:face_liveness_detection_app/Screens/Admin/popupmenupages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget titlex;
  final Function editProfile;
  final Function settings;
  final Function signout;
  AdAppBar(
      {Key key,
      @required this.titlex,
      @required this.editProfile,
      @required this.settings,
      @required this.signout,
      List actions})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<AdAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff30384c),
      title: widget.titlex,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            // do something
          },
        ),
        PopupMenuButton<String>(
          onSelected: choiceaction,
          itemBuilder: (BuildContext context) {
            return Sidemenu.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  void choiceaction(String choice) {
    if (choice == Sidemenu.editProfile) {
      widget.editProfile();
    } else if (choice == Sidemenu.settings) {
      widget.settings();
    } else if (choice == Sidemenu.signout) {
      widget.signout();
    }
  }
}

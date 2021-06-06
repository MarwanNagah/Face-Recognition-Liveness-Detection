import 'dart:async';
import 'package:face_liveness_detection_app/Models/client.dart';
import 'package:face_liveness_detection_app/Screens/Admin/admin.dart';
import 'package:face_liveness_detection_app/Providers/user_types.dart';
import 'package:face_liveness_detection_app/Screens/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:face_liveness_detection_app/Screens/wrapper.dart';
import 'Models/user.dart';
import 'Providers/auth.dart';
import 'Providers/institutionProvider.dart';
import 'Screens/Admin/manage_employees.dart';
import 'Screens/Admin/manage_institution.dart';
import 'package:face_liveness_detection_app/Screens/Client/face_detect.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

class Nav extends StatelessWidget {
  final User loggedUser;

  Nav({@required this.loggedUser});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InstitutionProvider>(
          create: (_) => InstitutionProvider(user: loggedUser),
        ),
        ChangeNotifierProvider<UserTypes>(
          create: (context) => UserTypes(),
        )
      ],
      child: MaterialApp(
        routes: {
          '/': (ctx) => PageNavigator(
                loggedUser: loggedUser,
              ),
          ManageInstitution.routeName: (ctx) => ManageInstitution(),
          ManageEmployees.routeName: (ctx) => ManageEmployees(),
        },
      ),
    );
  }
}

class PageNavigator extends StatefulWidget {
  final User loggedUser;

  PageNavigator({@required this.loggedUser});
  @override
  _PageNavigatorState createState() =>
      _PageNavigatorState(loggedUser: loggedUser);
}

class _PageNavigatorState extends State<PageNavigator> {
  final User loggedUser;
  bool _isLoaded = false;
  dynamic initialPage;
  final AuthService _auth = AuthService();

  _PageNavigatorState({@required this.loggedUser});

  void initState() {
    super.initState();
    asyncMethod();
    // _auth.signOut();
  }

  void asyncMethod() async {
    await loggedUser.readUser();
    Future.delayed(const Duration(seconds: 2), () async {
      if (loggedUser.userType.userTypeName == "Client") {
        //page for client
        await loggedUser.readInstitution();
        Client loggedClient = Client(loggedUser);
        initialPage = FaceDetect(loggedUser: loggedClient);
      } else if (loggedUser.userType.userTypeName == "Manager") {
        //page for manager
        initialPage = Adminpage(user: loggedUser);
      } else {
        //page for admin
        initialPage = Loading();
      }
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoaded ? Loading() : initialPage;
  }
}

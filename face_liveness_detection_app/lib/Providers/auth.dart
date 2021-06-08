import 'package:face_liveness_detection_app/Models/userType.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:face_liveness_detection_app/Models/user.dart' as AppUser;
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebaseUser
  AppUser.User _userFromFirebaseUser(User user) {
    if (user != null) {
      AppUser.User loggedUser = AppUser.User(uid: user.uid, fUser: user);
      return loggedUser;
    } else {
      return null;
    }
  }

  // auth change user stream
  Stream<AppUser.User> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword({
    String email,
    String password,
    String firstName,
    String lastName,
    String institutionID = "",
    int userType,
  }) async {
    UserType newType;
    if (userType == 0) {
      newType = UserType(userTypeID: userType, userTypeName: 'Client');
    } else if (userType == 1) {
      newType = UserType(userTypeID: userType, userTypeName: 'Manager');
    }

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      AppUser.User signedinUser = AppUser.User(
        fUser: user,
        eMail: user.email,
        uid: user.uid,
        firstName: firstName,
        lastName: lastName,
        userType: newType,
        institutionID: institutionID,
      );
      signedinUser.register();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

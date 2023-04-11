import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AgriVisionFirebaseUser {
  AgriVisionFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

AgriVisionFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AgriVisionFirebaseUser> agriVisionFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AgriVisionFirebaseUser>(
      (user) {
        currentUser = AgriVisionFirebaseUser(user);
        return currentUser!;
      },
    );

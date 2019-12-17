import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // get user
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
      (FirebaseUser user)=> user?.uid
  );
  // email and password sign up
  Future<String> createUserWithEmailAndPassword(
      String email,
      String password,
      String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password);
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.user.updateProfile(userUpdateInfo);
    await currentUser.user.reload();
    return currentUser.user.uid;
  }

  // Email and password Sign In
  Future<String> singEmailAndPassword(String email, String password)async{
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user.uid;
  }


  // Sign out
  signOut(){
    return _firebaseAuth.signOut();
  }

}
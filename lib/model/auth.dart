import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  bool get isAuth {
    return _user != null;
  }

  User? get user {
    return _user;
  }

  Future<void> authenticate(String email, String password, bool isLogin) async {
    try {
      if (isLogin) {
        // Login existente
        UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        _user = authResult.user;
      } else {
        // Cadastro de novo usuário
        UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        _user = authResult.user;
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return authenticate(email, password, false);
  }

  Future<void> login(String email, String password) async {
    return authenticate(email, password, true);
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}

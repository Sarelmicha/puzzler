import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:puzzlechat/bloc/login_bloc/login_bloc.dart';
import 'package:puzzlechat/bloc/login_bloc/login_event.dart';
import 'package:puzzlechat/data/user.dart';
import 'package:puzzlechat/util/converter.dart';

class UserRepository {
  FirebaseAuth _firebaseAuth;
  Firestore _firestore;

  UserRepository() {
    this._firebaseAuth = FirebaseAuth.instance;
    this._firestore = Firestore.instance;
  }

  Future<FirebaseUser> createUser(String email, String password) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } on PlatformException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<FirebaseUser> signInUser(String email, String password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<FirebaseUser> signInWithCredential(String verificationId,
      String code) async {
    print('im here in signInWithCredential');

    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: code);

    print(
        'im here after fetching credential signInWithCredential and credinital is $credential');

    print('firebaseauth is $_firebaseAuth');

    AuthResult result = await _firebaseAuth.signInWithCredential(credential);

    print('result is $result');

    return result.user;
  }

  Future<void> loginUser(String phoneNumber, FirebaseUser user,
      String verificationId, LoginBloc loginBloc) async {
    print('start loginUser func');

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 10),
        verificationCompleted: (AuthCredential credential) async {
          print('in verificationCompleted ');

          AuthResult result =
          await _firebaseAuth.signInWithCredential(credential);

          //Insert to the empty user that sent from bloc the current user
          user = result.user;
          print('user is $user');
          print('user phone number is ${user.phoneNumber}');
          print('user name is ${user.displayName}');

          loginBloc.add(VerifyPhoneNumberSuccessEvent(
              user: user, verificationId: verificationId));
        },
        verificationFailed: (AuthException exception) {
          print('in verificationFailed and excepption is ${exception.message}');
          loginBloc
              .add(VerifyPhoneNumberFailureEvent(message: exception.message));
        },
        codeSent: (String verId, [int forceResendingToken]) {
          print('in codeSend');
          verificationId = verId;
        },
        codeAutoRetrievalTimeout: null);
  }

  void saveUser(User user) async {
    print('here in save to firestore DB');
    print('user new games is ${user.games}');

    //Save user to firestore DB.
    await _firestore.collection('users').document(user.phoneNumber).setData({
      'phoneNumber': user.phoneNumber,
      'active': user.active,
      'games': Converter.toSaveableMap(user.games),
    });
  }

  Future<QuerySnapshot> getAllUsers() async {
    return await _firestore.collection('users').getDocuments();
  }

  Future<DocumentSnapshot> getSpecificUser(String phoneNumber) async {
    return await _firestore.collection('users').document(phoneNumber).get();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    var currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }
}


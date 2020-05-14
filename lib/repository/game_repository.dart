import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:puzzlechat/data/user.dart';
import 'package:puzzlechat/repository/user_repository.dart';
import 'package:puzzlechat/util/converter.dart';

class GameRepository {
  FirebaseStorage _fireStorage;
  Firestore _firestore;
  Converter converter;
  UserRepository userRepository;

  GameRepository() {
    this._fireStorage = FirebaseStorage.instance;
    this._firestore = Firestore.instance;
    userRepository = UserRepository();
    this.converter = Converter();
  }

  void sendGame(String receiverPhoneNumber, File imageFile, int totalTime,
      int numOfPieces, String senderPhoneNumber) async {
    var document = await _firestore
        .collection('users')
        .document(receiverPhoneNumber)
        .get();

    User user = User(
        phoneNumber: document.data['phoneNumber'],
        newGames: document.data['newGames'],
        active: true);

    String downloadImageUrl =
        await saveImageFileToStorage(imageFile, senderPhoneNumber);

    user.newGames[senderPhoneNumber] = downloadImageUrl;

    userRepository.saveUser(user);
  }

  Future<String> saveImageFileToStorage(
      File imageFile, String senderPhoneNumber) async {
    //TODO - in futrue need to change the child id

    //Create a reference to the location you want to upload to in firebase
    StorageReference reference = _fireStorage.ref().child(senderPhoneNumber);

    //Upload the file to firebase
    StorageUploadTask uploadTask = reference.putFile(imageFile);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    // Waits till the file is uploaded then stores the download url
    String url = await taskSnapshot.ref.getDownloadURL();

    return url;
  }
}

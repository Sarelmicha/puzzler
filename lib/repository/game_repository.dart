import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/util/converter.dart';
import 'package:uuid/uuid.dart';

class GameRepository {
  FirebaseStorage _fireStorage;
  Firestore _firestore;
  Uuid uuid;

  GameRepository() {
    this._fireStorage = FirebaseStorage.instance;
    this._firestore = Firestore.instance;
    this.uuid = Uuid();
  }

  Future<void> sendPuzzleGame(String receiverPhoneNumber,Uint8List image , int totalTime,
      int numOfRows, String senderPhoneNumber) async {


    //Fetching the image URL from the fireStorage
    String downloadImageUrl =
        await saveImageFileToStorage(image, senderPhoneNumber);

    //Creating new game data.
    GameData gameData = GameData(
        gameId: uuid.v1(),
        sender: senderPhoneNumber,
        totalTime: totalTime.toString(),
        numOfRows: numOfRows.toString(),
        imageUrl: downloadImageUrl);

    //Fetch from DB the document of the current receiver user
    DocumentSnapshot documentSnapshot = await _firestore
        .collection('users')
        .document(receiverPhoneNumber)
        .get();

    print('here before getch');
    //Fetch the games Map from the receiver user
    print('doucument snap shot is ${documentSnapshot.data["games"].runtimeType}');

    Map<String, dynamic> games = documentSnapshot.data['games'];

    print('games is before  add $games');

    print('here after getch');

    //Fetch the List of open games from the receiver user
    List<GameData> openGamesWithSender;
    if(games[senderPhoneNumber] != null) {
       openGamesWithSender = Converter.fromSaveableList(
          games[senderPhoneNumber]);
    } else {
      openGamesWithSender = List();
    }

    print('openGameWithSender is ${openGamesWithSender.runtimeType}');

    //Adding another game to open game of with sender.
    if(openGamesWithSender == null) {
      openGamesWithSender = List();
    }

    print('openGameWithSender is ${openGamesWithSender.runtimeType}');

    openGamesWithSender.add(gameData);

    print('here before update the map');

    //Update the map before update in DB
    games[senderPhoneNumber] = openGamesWithSender;


   print('games now is  ${games}');

    print('here before update the map');

    print('receiver phone number $receiverPhoneNumber');


    print('okay... lets go!');

    print('games issss $games');

    Map<String,dynamic> mapToSave = Converter.toSaveableMap(games);


    print('after conversion!!!!!');
    //Update in database
    await _firestore
        .collection("users")
        .document(receiverPhoneNumber)
        .updateData(
      {
        'games' : mapToSave,
      }
    );

    print('done update.');
  }

  Future<String> saveImageFileToStorage(
      Uint8List image, String senderPhoneNumber) async {
    //TODO - in futrue need to change the child id

    print('senderPhoneNumber bitches $senderPhoneNumber');
    //Create a reference to the location you want to upload to in firebase
    StorageReference reference = _fireStorage.ref().child(senderPhoneNumber);

    //Upload the file to firebase
    StorageUploadTask uploadTask = reference.putData(image);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    // Waits till the file is uploaded then stores the download url
    String url = await taskSnapshot.ref.getDownloadURL();

    return url;
  }

  void deleteGame(String receiverPhoneNumber,String senderPhoneNumber, String gameId) async{

   DocumentSnapshot documentSnapshot = await _firestore.collection('users').document(receiverPhoneNumber).get();

   List<GameData> games = documentSnapshot.data['games'][senderPhoneNumber];

   //Remove the played game
   games.forEach((element) {

     if(element.gameId == gameId){
       games.remove(element);
     }
   });

   //Update in database
   await _firestore
       .collection("users")
       .document(receiverPhoneNumber)
       .updateData(
       {
         'games.$senderPhoneNumber' : games,
       }
   );
  }
}

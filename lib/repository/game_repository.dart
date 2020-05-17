import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:puzzlechat/data/game_data.dart';
import 'package:puzzlechat/util/converter.dart';

class GameRepository {
  FirebaseStorage _fireStorage;
  Firestore _firestore;

  GameRepository() {
    this._fireStorage = FirebaseStorage.instance;
    this._firestore = Firestore.instance;
  }

  Future<void> sendPuzzleGame(String receiverPhoneNumber, File imageFile, int totalTime,
      int numOfPieces, String senderPhoneNumber) async {


    //Fetching the image URL from the fireStorage
    String downloadImageUrl =
        await saveImageFileToStorage(imageFile, senderPhoneNumber);

    //Creating new game data.
    GameData gameData = GameData(
        sender: senderPhoneNumber,
        totalTime: totalTime.toString(),
        numOfRows: numOfPieces.toString(),
        imageUrl: downloadImageUrl);

    //Fetch from DB the document of the current receiver user
    DocumentSnapshot documentSnapshot = await _firestore
        .collection('users')
        .document(receiverPhoneNumber)
        .get();

    print('here before getch');
    //Fetch the games Map from the receiver user
    print('doucument snap shot active  is ${documentSnapshot.data["active"].runtimeType}');
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

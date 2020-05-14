import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:puzzlechat/data/user.dart';
import 'package:puzzlechat/repository/user_repository.dart';
import 'package:puzzlechat/util/converter.dart';

class GameRepository {

  Firestore _firestore;
  Converter converter;
  UserRepository userRepository;

  GameRepository() {
    this._firestore = Firestore.instance;
    userRepository = UserRepository();
    this.converter = Converter();
  }


  void sendGame(String receiverPhoneNumber,List<int> image,int totalTime, int numOfPieces,String senderPhoneNumber) async{

    var document = await  _firestore.collection('users').document(receiverPhoneNumber).get();

    User user = User(phoneNumber: document.data['phoneNumber'],newGames: document.data['newGames'], active: true);

    user.newGames[senderPhoneNumber] = image;

    userRepository.saveUser(user);

  }

}
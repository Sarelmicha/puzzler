import 'dart:collection';

import 'package:puzzlechat/data/game_data.dart';

class Converter {


  static Map<String, dynamic> toMap(GameData gameData) {
    return {
      'sender': gameData.sender,
      'totalTime': gameData.totalTime,
      'numOfRows': gameData.numOfRows,
      'imageUrl': gameData.imageUrl,
    };
  }

  static GameData fromMap(Map<String, dynamic> map){
    return GameData(
        sender: map['sender'],
        totalTime: map['totalTime'],
        numOfRows: map['numOfRows'],
        imageUrl: map['imageUrl'],
    );
  }

   static List<Map<String, dynamic>> toSaveableList(
      {List<GameData> games}) {
    List<Map<String, dynamic>> convertedGames = [];
    games.forEach((GameData gameData) {
      Map<String, dynamic> step = toMap(gameData);
      convertedGames.add(step);
    });
    return convertedGames;
  }

  static List<GameData> fromSaveableList(List <Map<String, dynamic>> games) {
    List <GameData> convertedGames = [];
    games.forEach((element) {
      convertedGames.add(fromMap(element));
    });

    return convertedGames;
  }

   static Map<String,dynamic> toSaveableMap (Map<String,dynamic> gameMap){

    print('hey ho!');

    Map<String,dynamic> convertedMap = HashMap();

    gameMap.forEach((key, value) {
      convertedMap[key] = toSaveableList(games: value);
    });

    print('here in the end of toSavebleMap!');

    return convertedMap;

  }

  static Map<String,List<GameData>> fromSaveableMap (Map<String,dynamic> gameMap) {

    Map<String,List<GameData>> convertedMap = HashMap();

    gameMap.forEach((key, value) {
      convertedMap[key] = fromSaveableList(value);
    });

    return convertedMap;
  }

}
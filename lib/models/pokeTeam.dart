import 'package:cloud_firestore/cloud_firestore.dart';

class PokeTeam {
  String teamId;
  String teamName;
  String regionName;
  String uId;
  List<Poke> pokeMonsters;

  PokeTeam.fromSnapshot(DocumentSnapshot snapshot)
      : teamId = snapshot.documentID,
        teamName = snapshot['teamName'],
        regionName = snapshot['regionName'],
        uId = snapshot['uId'],
        pokeMonsters = snapshot['pokeMonsters'].map<Poke>((item) {
          return Poke.fromMap(item);
        }).toList();
}

class Poke {
  String pokemonId;
  String pokemonName;
  String imageUrl;
  String descriptionText;
  String height;
  String weight;


  Poke(this.pokemonId, this.pokemonName, this.imageUrl, this.descriptionText,
      this.height, this.weight);

  Poke.fromMap(Map<dynamic, dynamic> data)
      : pokemonId = data["pokemonId"],
        pokemonName = data["pokemonName"],
        imageUrl = data["imageUrl"],
        descriptionText = data["descriptionText"],
        height = data["height"],
        weight = data["weight"];
}

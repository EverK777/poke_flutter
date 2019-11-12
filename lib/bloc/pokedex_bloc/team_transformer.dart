import 'dart:async';

import 'package:poke_flutter/models/pokeTeam.dart';

class TeamValidators{

  final validateTeamName = StreamTransformer<String, String>.fromHandlers(
      handleData: (teamName, sink) {
              teamName.isNotEmpty
            ? sink.add(teamName)
            : sink.addError('Team name is requiered');
      });
  final validatePokemonSelection = StreamTransformer<List<Poke>, List<Poke>>.fromHandlers(
    handleData: (pokemons, sink){
        pokemons.length >= 3
            ? sink.add(pokemons)
            : sink.addError('Please select at least 3 pokemons');
    }
  );
}
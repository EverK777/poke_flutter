import 'package:flutter/material.dart';
import 'package:poke_flutter/models/pokedex.dart';

class PokemonListWidget extends StatefulWidget {
  final List<PokemonEntries> pokemonList;

  const PokemonListWidget({this.pokemonList, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PokemonListState(pokemonList);
  }
}

class _PokemonListState extends State<PokemonListWidget> {
  bool _reverseSort = false;
  final List<PokemonEntries> _pokemonList;

  _PokemonListState(
      this._pokemonList); // Handler called by ReorderableListView onReorder after a list child is
  // dropped into a new position.
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final PokemonEntries item = _pokemonList.removeAt(oldIndex);
      _pokemonList.insert(newIndex, item);
    });
  }

  // Handler called when the "sort" button on appbar is clicked.
  void _onSort() {
    setState(() {
      _reverseSort = !_reverseSort;
      _pokemonList.sort((PokemonEntries a, PokemonEntries b) => _reverseSort
          ? b.entryNumber.compareTo(a.entryNumber)
          : a.entryNumber.compareTo(b.entryNumber));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _listTiles = _pokemonList
        .map(
          (item) => ListTile(
            key: Key(item.entryNumber.toString()),
            leading: FadeInImage.assetNetwork(
              height: _screenSize.height * 0.10,
              width: _screenSize.height * 0.10,
              placeholder: 'assets/images/pokeball.png',
              image:
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${item.pokemon_species.url.substring(item.pokemon_species.url.length - 2, item.pokemon_species.url.length - 1)}.png',
            ),
            title: Text(
              item.pokemon_species.name,
              style: TextStyle(
                  color: Colors.black38, fontFamily: 'Pokemon', fontSize: 18),
            ),
          ),
        )
        .toList();
    print(_pokemonList[0].pokemon_species.url.substring(_pokemonList[0].pokemon_species.url.length - 2, _pokemonList[0].pokemon_species.url.length - 1));
    return ReorderableListView(
      onReorder: _onReorder,
      children: _listTiles,
    );
  }
}

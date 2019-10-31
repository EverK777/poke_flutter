import 'package:poke_flutter/models/pokemon_species.dart';

class Region {
  int id;
  List<Locations> locations;
  String name;
  List<Pokedexes> pokedexes;

  Region(
      {this.id,
        this.locations,
        this.name,
        this.pokedexes,});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['locations'] != null) {
      locations = new List<Locations>();
      json['locations'].forEach((v) {
        locations.add(new Locations.fromJson(v));
      });
    }

    name = json['name'];
    if (json['pokedexes'] != null) {
      pokedexes = new List<Pokedexes>();
      json['pokedexes'].forEach((v) {
        pokedexes.add(new Pokedexes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.locations != null) {
      data['locations'] = this.locations.map((v) => v.toJson()).toList();
    }

    data['name'] = this.name;
    if (this.pokedexes != null) {
      data['pokedexes'] = this.pokedexes.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Locations {
  String name;
  String url;

  Locations({this.name, this.url});

  Locations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Names {
  String name;
  Names({ this.name});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }

}

class Pokedexes {
  String name;
  String url;

  Pokedexes({this.name, this.url});

  Pokedexes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

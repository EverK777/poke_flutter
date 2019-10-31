class Pokemon {
  List<Abilities> abilities;
  int baseExperience;
  List<GameIndices> gameIndices;
  int height;
  int id;
  bool isDefault;
  String locationAreaEncounters;
  List<Moves> moves;
  String name;
  int order;
  Sprites sprites;
  List<Stats> stats;
  int weight;

  Pokemon(
      {this.abilities,
      this.baseExperience,
      this.gameIndices,
      this.height,
      this.id,
      this.isDefault,
      this.locationAreaEncounters,
      this.moves,
      this.name,
      this.order,
      this.sprites,
      this.stats,
      this.weight});

  Pokemon.fromJson(Map<String, dynamic> json) {
    if (json['abilities'] != null) {
      abilities = new List<Abilities>();
      json['abilities'].forEach((v) {
        abilities.add(new Abilities.fromJson(v));
      });
    }
    baseExperience = json['base_experience'];
    if (json['game_indices'] != null) {
      gameIndices = new List<GameIndices>();
      json['game_indices'].forEach((v) {
        gameIndices.add(new GameIndices.fromJson(v));
      });
    }
    height = json['height'];
    id = json['id'];
    isDefault = json['is_default'];
    locationAreaEncounters = json['location_area_encounters'];
    if (json['moves'] != null) {
      moves = new List<Moves>();
      json['moves'].forEach((v) {
        moves.add(new Moves.fromJson(v));
      });
    }
    name = json['name'];
    order = json['order'];
    sprites =
        json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null;
    if (json['stats'] != null) {
      stats = new List<Stats>();
      json['stats'].forEach((v) {
        stats.add(new Stats.fromJson(v));
      });
    }

    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.abilities != null) {
      data['abilities'] = this.abilities.map((v) => v.toJson()).toList();
    }
    data['base_experience'] = this.baseExperience;

    if (this.gameIndices != null) {
      data['game_indices'] = this.gameIndices.map((v) => v.toJson()).toList();
    }
    data['height'] = this.height;
    data['id'] = this.id;
    data['is_default'] = this.isDefault;
    data['location_area_encounters'] = this.locationAreaEncounters;
    if (this.moves != null) {
      data['moves'] = this.moves.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['order'] = this.order;
    if (this.sprites != null) {
      data['sprites'] = this.sprites.toJson();
    }
    if (this.stats != null) {
      data['stats'] = this.stats.map((v) => v.toJson()).toList();
    }

    data['weight'] = this.weight;
    return data;
  }
}

class Abilities {
  Ability ability;
  bool isHidden;
  int slot;

  Abilities({this.ability, this.isHidden, this.slot});

  Abilities.fromJson(Map<String, dynamic> json) {
    ability =
        json['ability'] != null ? new Ability.fromJson(json['ability']) : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ability != null) {
      data['ability'] = this.ability.toJson();
    }
    data['is_hidden'] = this.isHidden;
    data['slot'] = this.slot;
    return data;
  }
}

class Ability {
  String name;
  String url;

  Ability({this.name, this.url});

  Ability.fromJson(Map<String, dynamic> json) {
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

class GameIndices {
  int gameIndex;

  GameIndices.fromJson(Map<String, dynamic> json) {
    gameIndex = json['game_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_index'] = this.gameIndex;
    return data;
  }
}

class Moves {
  Move move;

  Moves({this.move});

  Moves.fromJson(Map<String, dynamic> json) {
    move = json['move'] != null ? new Move.fromJson(json['move']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.move != null) {
      data['move'] = this.move.toJson();
    }
    return data;
  }
}

class Sprites {
  String backDefault;
  String backShiny;
  String frontDefault;
  String frontShiny;

  Sprites({
    this.backDefault,
    this.backShiny,
    this.frontDefault,
    this.frontShiny,
  });

  Sprites.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backShiny = json['back_shiny'];
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['back_default'] = this.backDefault;
    data['back_shiny'] = this.backShiny;
    data['front_default'] = this.frontDefault;
    data['front_shiny'] = this.frontShiny;
    return data;
  }
}

class Stats {
  int baseStat;
  int effort;

  Stats({this.baseStat, this.effort});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_stat'] = this.baseStat;
    data['effort'] = this.effort;

    return data;
  }
}

class Move {
  int accuracy;
  ContestEffect contestEffect;
  ContestType contestType;
  List<EffectEntries> effectEntries;
  List<FlavorTextEntries> flavorTextEntries;
  int id;
  Meta meta;
  String name;
  List<Names> names;
  List<PastValues> pastValues;
  int power;
  int pp;
  int priority;
  Type type;

  Move(
      {this.accuracy,
      this.contestEffect,
      this.contestType,
      this.effectEntries,
      this.flavorTextEntries,
      this.id,
      this.meta,
      this.name,
      this.names,
      this.pastValues,
      this.power,
      this.pp,
      this.priority,
      this.type});

  Move.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    contestEffect = json['contest_effect'] != null
        ? new ContestEffect.fromJson(json['contest_effect'])
        : null;
    contestType = json['contest_type'] != null
        ? new ContestType.fromJson(json['contest_type'])
        : null;
    if (json['effect_entries'] != null) {
      effectEntries = new List<EffectEntries>();
      json['effect_entries'].forEach((v) {
        effectEntries.add(new EffectEntries.fromJson(v));
      });
    }
    if (json['flavor_text_entries'] != null) {
      flavorTextEntries = new List<FlavorTextEntries>();
      json['flavor_text_entries'].forEach((v) {
        flavorTextEntries.add(new FlavorTextEntries.fromJson(v));
      });
    }
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    name = json['name'];
    if (json['names'] != null) {
      names = new List<Names>();
      json['names'].forEach((v) {
        names.add(new Names.fromJson(v));
      });
    }
    if (json['past_values'] != null) {
      pastValues = new List<PastValues>();
      json['past_values'].forEach((v) {
        pastValues.add(new PastValues.fromJson(v));
      });
    }
    power = json['power'];
    pp = json['pp'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accuracy'] = this.accuracy;
    if (this.contestEffect != null) {
      data['contest_effect'] = this.contestEffect.toJson();
    }
    if (this.contestType != null) {
      data['contest_type'] = this.contestType.toJson();
    }
    if (this.effectEntries != null) {
      data['effect_entries'] =
          this.effectEntries.map((v) => v.toJson()).toList();
    }
    if (this.flavorTextEntries != null) {
      data['flavor_text_entries'] =
          this.flavorTextEntries.map((v) => v.toJson()).toList();
    }

    data['id'] = this.id;
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['name'] = this.name;
    if (this.names != null) {
      data['names'] = this.names.map((v) => v.toJson()).toList();
    }
    if (this.pastValues != null) {
      data['past_values'] = this.pastValues.map((v) => v.toJson()).toList();
    }
    data['power'] = this.power;
    data['pp'] = this.pp;
    data['priority'] = this.priority;
    return data;
  }
}

class ContestEffect {
  String url;

  ContestEffect({this.url});

  ContestEffect.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class ContestType {
  String name;
  String url;

  ContestType({this.name, this.url});

  ContestType.fromJson(Map<String, dynamic> json) {
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

class EffectEntries {
  String effect;
  String shortEffect;

  EffectEntries({this.effect, this.shortEffect});

  EffectEntries.fromJson(Map<String, dynamic> json) {
    effect = json['effect'];
    shortEffect = json['short_effect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['effect'] = this.effect;
    data['short_effect'] = this.shortEffect;
    return data;
  }
}

class FlavorTextEntries {
  String flavorText;

  FlavorTextEntries({this.flavorText});

  FlavorTextEntries.fromJson(Map<String, dynamic> json) {
    flavorText = json['flavor_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flavor_text'] = this.flavorText;

    return data;
  }
}

class Meta {
  int ailmentChance;
  int critRate;
  int drain;
  int flinchChance;
  int healing;
  int statChance;

  Meta(
      {this.ailmentChance,
      this.critRate,
      this.drain,
      this.flinchChance,
      this.healing,
      this.statChance});

  Meta.fromJson(Map<String, dynamic> json) {
    critRate = json['crit_rate'];
    drain = json['drain'];
    flinchChance = json['flinch_chance'];
    healing = json['healing'];
    statChance = json['stat_chance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crit_rate'] = this.critRate;
    data['drain'] = this.drain;
    data['flinch_chance'] = this.flinchChance;
    data['healing'] = this.healing;
    data['stat_chance'] = this.statChance;
    return data;
  }
}

class Names {
  String name;

  Names({this.name});

  Names.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class PastValues {
  int accuracy;


  PastValues({
    this.accuracy,
  });

  PastValues.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accuracy'] = this.accuracy;
    return data;
  }
}

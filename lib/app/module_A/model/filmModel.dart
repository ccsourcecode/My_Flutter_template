class FilmModel {
  String? _title;
  int? _episodeId;
  String? _openingCrawl;
  String? _director;
  String? _producer;
  String? _releaseDate;
  List<String>? _characters;
  List<String>? _planets;
  List<String>? _starships;
  List<String>? _vehicles;
  List<String>? _species;
  String? _created;
  String? _edited;
  String? _url;
  String? error;

  Film(
      {String? title,
      int? episodeId,
      String? openingCrawl,
      String? director,
      String? producer,
      String? releaseDate,
      List<String>? characters,
      List<String>? planets,
      List<String>? starships,
      List<String>? vehicles,
      List<String>? species,
      String? created,
      String? edited,
      String? url}) {
    if (title != null) {
      this._title = title;
    }
    if (episodeId != null) {
      this._episodeId = episodeId;
    }
    if (openingCrawl != null) {
      this._openingCrawl = openingCrawl;
    }
    if (director != null) {
      this._director = director;
    }
    if (producer != null) {
      this._producer = producer;
    }
    if (releaseDate != null) {
      this._releaseDate = releaseDate;
    }
    if (characters != null) {
      this._characters = characters;
    }
    if (planets != null) {
      this._planets = planets;
    }
    if (starships != null) {
      this._starships = starships;
    }
    if (vehicles != null) {
      this._vehicles = vehicles;
    }
    if (species != null) {
      this._species = species;
    }
    if (created != null) {
      this._created = created;
    }
    if (edited != null) {
      this._edited = edited;
    }
    if (url != null) {
      this._url = url;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  int? get episodeId => _episodeId;
  set episodeId(int? episodeId) => _episodeId = episodeId;
  String? get openingCrawl => _openingCrawl;
  set openingCrawl(String? openingCrawl) => _openingCrawl = openingCrawl;
  String? get director => _director;
  set director(String? director) => _director = director;
  String? get producer => _producer;
  set producer(String? producer) => _producer = producer;
  String? get releaseDate => _releaseDate;
  set releaseDate(String? releaseDate) => _releaseDate = releaseDate;
  List<String>? get characters => _characters;
  set characters(List<String>? characters) => _characters = characters;
  List<String>? get planets => _planets;
  set planets(List<String>? planets) => _planets = planets;
  List<String>? get starships => _starships;
  set starships(List<String>? starships) => _starships = starships;
  List<String>? get vehicles => _vehicles;
  set vehicles(List<String>? vehicles) => _vehicles = vehicles;
  List<String>? get species => _species;
  set species(List<String>? species) => _species = species;
  String? get created => _created;
  set created(String? created) => _created = created;
  String? get edited => _edited;
  set edited(String? edited) => _edited = edited;
  String? get url => _url;
  set url(String? url) => _url = url;

  FilmModel.withError(String errorMessage) {
    error = errorMessage;
  }

  FilmModel.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _episodeId = json['episode_id'];
    _openingCrawl = json['opening_crawl'];
    _director = json['director'];
    _producer = json['producer'];
    _releaseDate = json['release_date'];
    _characters = json['characters'].cast<String>();
    _planets = json['planets'].cast<String>();
    _starships = json['starships'].cast<String>();
    _vehicles = json['vehicles'].cast<String>();
    _species = json['species'].cast<String>();
    _created = json['created'];
    _edited = json['edited'];
    _url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['episode_id'] = this._episodeId;
    data['opening_crawl'] = this._openingCrawl;
    data['director'] = this._director;
    data['producer'] = this._producer;
    data['release_date'] = this._releaseDate;
    data['characters'] = this._characters;
    data['planets'] = this._planets;
    data['starships'] = this._starships;
    data['vehicles'] = this._vehicles;
    data['species'] = this._species;
    data['created'] = this._created;
    data['edited'] = this._edited;
    data['url'] = this._url;
    return data;
  }
}

// To parse this JSON data, do
//
//     final filmModel = filmModelFromJson(jsonString);

import 'dart:convert';

FilmModel filmModelFromJson(String str) => FilmModel.fromJson(json.decode(str));

String filmModelToJson(FilmModel data) => json.encode(data.toJson());

class FilmModel {
  FilmModel({
    this.title,
    this.episodeId,
    this.openingCrawl,
    this.director,
    this.producer,
    this.releaseDate,
    this.characters,
    this.planets,
    this.starships,
    this.vehicles,
    this.species,
    this.created,
    this.edited,
    this.url,
  });

  String? title;
  int? episodeId;
  String? openingCrawl;
  String? director;
  String? producer;
  DateTime? releaseDate;
  List<String>? characters;
  List<String>? planets;
  List<String>? starships;
  List<String>? vehicles;
  List<String>? species;
  DateTime? created;
  DateTime? edited;
  String? url;

  factory FilmModel.fromJson(Map<String, dynamic> json) => FilmModel(
        title: json["title"],
        episodeId: json["episode_id"],
        openingCrawl: json["opening_crawl"],
        director: json["director"],
        producer: json["producer"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        characters: json["characters"] == null
            ? null
            : List<String>.from(json["characters"].map((x) => x)),
        planets: json["planets"] == null
            ? null
            : List<String>.from(json["planets"].map((x) => x)),
        starships: json["starships"] == null
            ? null
            : List<String>.from(json["starships"].map((x) => x)),
        vehicles: json["vehicles"] == null
            ? null
            : List<String>.from(json["vehicles"].map((x) => x)),
        species: json["species"] == null
            ? null
            : List<String>.from(json["species"].map((x) => x)),
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        edited: json["edited"] == null ? null : DateTime.parse(json["edited"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "episode_id": episodeId,
        "opening_crawl": openingCrawl,
        "director": director,
        "producer": producer,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "characters": characters == null
            ? null
            : List<dynamic>.from(characters!.map((x) => x)),
        "planets":
            planets == null ? null : List<dynamic>.from(planets!.map((x) => x)),
        "starships": starships == null
            ? null
            : List<dynamic>.from(starships!.map((x) => x)),
        "vehicles": vehicles == null
            ? null
            : List<dynamic>.from(vehicles!.map((x) => x)),
        "species":
            species == null ? null : List<dynamic>.from(species!.map((x) => x)),
        "created": created == null ? null : created!.toIso8601String(),
        "edited": edited == null ? null : edited!.toIso8601String(),
        "url": url,
      };
}

import 'dart:core';

class Game {
  int id;
  String url;
  String title;
  String description;
  String boxArt;
  String releaseDate;
  List<String> categories;
  String esrb;
  List<String> company;
  List<String> availability;
  double price;
  double salePrice;

  Game({
    this.id,
    this.url,
    this.title,
    this.description,
    this.boxArt,
    this.releaseDate,
    this.categories,
    this.esrb,
    this.company,
    this.availability,
    this.price,
    this.salePrice,
  });

  factory Game.fromJSON(Map<String, dynamic> json) => Game(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      description: json['description'],
      boxArt: json['boxArt'],
      releaseDate: json['releaseDate'],
      categories: List<String>.from(json["categories"].map((x) => x)),
      esrb: json['esrb'],
      company: List<String>.from(json["company"].map((x) => x)),
      availability: List<String>.from(json["availability"].map((x) => x)),
      price: json['price'].toDouble(),
      salePrice: json['salePrice'].toDouble());

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "title": title,
        "description": description,
        "boxArt": boxArt,
        "releaseDate": releaseDate,
        "categories": categories,
        "esrb": esrb,
        "company": company,
        "availability": availability,
        "price": price,
        "salePrice": salePrice,
      };
}

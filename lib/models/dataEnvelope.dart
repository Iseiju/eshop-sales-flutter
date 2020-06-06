import 'package:switch_sales/models/game.dart';

class DataEnvelope {
  DataEnvelope({
    this.data,
  });

  List<Game> data;

  factory DataEnvelope.fromJson(Map<String, dynamic> json) => DataEnvelope(
        data: List<Game>.from(json["data"].map((x) => Game.fromJSON(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

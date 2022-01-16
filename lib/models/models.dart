import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

//flutter pub run build_runner build
//flutter pub run build_runner watch

@JsonSerializable()
class Sector {
  int id;
  int plant_timestamp;
  int plant_id;
  String health;
  int humidity;
  int tray_id;

  Sector({this.id, this.plant_timestamp, this.plant_id, this.health, this.humidity, this.tray_id});
  factory Sector.fromJson(Map<String, dynamic> json) =>  _$SectorFromJson(json);
  Map<String, dynamic> toJson() => _$SectorToJson(this);
}



@JsonSerializable()
class Tray{
  int id;
  int light;
  int temperature;

  Tray(this.id, this.light, this.temperature);

  factory Tray.fromJson(Map<String, dynamic> json) =>  _$TrayFromJson(json);
  Map<String, dynamic> toJson() => _$TrayToJson(this);
}

@JsonSerializable()
class Sectors{
  Tray tray;
  List<Sector> sectors;

  Sectors(this.tray, this.sectors);
  factory Sectors.fromJson(Map<String, dynamic> json) =>  _$SectorsFromJson(json);
  Map<String, dynamic> toJson() => _$SectorsToJson(this);

}

@JsonSerializable()
class Token{
  String token;

  Token({this.token});
  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

@JsonSerializable()
class Plant{
  final int id;
  final String name;
  final String description;
  final int normal_humidity;
  final int ripening_time;

  Plant({this.id, this.name, this.description, this.normal_humidity, this.ripening_time});

  factory Plant.fromJson(Map<String, dynamic> json) => _$PlantFromJson(json);
  Map<String, dynamic> toJson() => _$PlantToJson(this);
}

@JsonSerializable()
class Job{
  final int timestamp;
  final int plant_id;
  final int pot_id;
  final int tray_id;

  Job({this.timestamp, this.plant_id, this.pot_id, this.tray_id});

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
  Map<String, dynamic> toJson() => _$JobToJson(this);
}
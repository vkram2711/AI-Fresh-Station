// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sector _$SectorFromJson(Map<String, dynamic> json) {
  return Sector(
    id: json['id'] as int,
    plant_timestamp: json['plant_timestamp'] as int,
    plant_id: json['plant_id'] as int,
    health: json['health'] as String,
    humidity: json['humidity'] as int,
    tray_id: json['tray_id'] as int,
  );
}

Map<String, dynamic> _$SectorToJson(Sector instance) => <String, dynamic>{
      'id': instance.id,
      'plant_timestamp': instance.plant_timestamp,
      'plant_id': instance.plant_id,
      'health': instance.health,
      'humidity': instance.humidity,
      'tray_id': instance.tray_id,
    };

Tray _$TrayFromJson(Map<String, dynamic> json) {
  return Tray(
    json['id'] as int,
    json['light'] as int,
    json['temperature'] as int,
  );
}

Map<String, dynamic> _$TrayToJson(Tray instance) => <String, dynamic>{
      'id': instance.id,
      'light': instance.light,
      'temperature': instance.temperature,
    };

Sectors _$SectorsFromJson(Map<String, dynamic> json) {
  return Sectors(
    json['tray'] == null
        ? null
        : Tray.fromJson(json['tray'] as Map<String, dynamic>),
    (json['sectors'] as List)
        ?.map((e) =>
            e == null ? null : Sector.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SectorsToJson(Sectors instance) => <String, dynamic>{
      'tray': instance.tray,
      'sectors': instance.sectors,
    };

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'token': instance.token,
    };

Plant _$PlantFromJson(Map<String, dynamic> json) {
  return Plant(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    normal_humidity: json['normal_humidity'] as int,
    ripening_time: json['ripening_time'] as int,
  );
}

Map<String, dynamic> _$PlantToJson(Plant instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'normal_humidity': instance.normal_humidity,
      'ripening_time': instance.ripening_time,
    };

Job _$JobFromJson(Map<String, dynamic> json) {
  return Job(
    timestamp: json['timestamp'] as int,
    plant_id: json['plant_id'] as int,
    pot_id: json['pot_id'] as int,
    tray_id: json['tray_id'] as int,
  );
}

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'plant_id': instance.plant_id,
      'pot_id': instance.pot_id,
      'tray_id': instance.tray_id,
    };

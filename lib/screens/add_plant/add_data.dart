import 'package:ai_fresh_plant/network/api.dart';

class AddRepo{
  Future<String> addPlant(plantId, trayId, potId, token, timestamp){
    return RestClient().addPlant(plantId, trayId, potId, token, timestamp);
  }
}
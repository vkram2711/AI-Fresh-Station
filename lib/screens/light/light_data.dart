import 'package:ai_fresh_plant/network/api.dart';

class LightRepo {
    RestClient restClient = new RestClient();

    Future<bool> light(token, trayId){
      return restClient.light(token, trayId);
    }
    Future<String> setLight(token, light, trayId){
      return restClient.setLight(token, light, trayId);
    }
}
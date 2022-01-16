import 'package:ai_fresh_plant/network/api.dart';

class InfoRepo{
  RestClient restClient = new RestClient();
  Future<void> collect(token, tray_id, sector_id) {
    restClient.collect(token, tray_id, sector_id);
  }
}
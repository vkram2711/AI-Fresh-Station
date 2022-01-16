import 'package:ai_fresh_plant/models/models.dart';
import 'package:ai_fresh_plant/network/api.dart';

class SectorRepo {
  RestClient restClient = new RestClient();

  Future<Sectors> getSectors(token, tray_id) {
    return restClient.sectors(token, tray_id);
  }

  Future<List<Plant>> getPlants() {
    return restClient.plants();
  }

  Future<List<Job>> getJobs(token, tray_id) {
    return restClient.getJobs(token, tray_id);
  }
}
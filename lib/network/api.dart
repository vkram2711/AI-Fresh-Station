import 'dart:developer';

import 'package:ai_fresh_plant/constants.dart';
import '../models/models.dart';
import "dart:async";
import 'dart:convert';
import 'package:http/http.dart' as http;

class RestClient {

  Future<Token> auth(login, password) async {
    log("token");
    var response = await http.get(
        Uri.parse("${Constants.BASE_URL}auth?login=$login&password=$password"),
        headers: {"Accept": "application/json"});
    log(response.body);
    var data = json.decode(response.body);
    return new Token.fromJson(data);
  }

  Future<Sectors> sectors(token, tray_id) async {
    log("sectors");

    var response = await http.get(
        Uri.parse("${Constants.BASE_URL}sectors?token=$token&tray_id=$tray_id"),
        headers: {"Accept": "application/json"});
    log(response.body);
    Map<String, dynamic> parsed = json.decode(response.body);
   /* List<Sector> sector = parsed["sectors"].map((i) => Sector.fromJson(i)).toList();;
    Tray tray = parsed["tray"];
    Sectors sectors = Sectors(tray, sector);// l.map((Map model) => Sector.fromJson(model)).toList();*/
    Sectors sectors = Sectors.fromJson(parsed);
    return sectors;
  }

  Future<List<Plant>> plants() async {
    log("plants");
    var response = await http.get(
        Uri.parse("${Constants.BASE_URL}plants"),
        headers: {"Accept": "application/json"});
    log(response.body);
    var data = json.decode(response.body);
    List<Plant> plants = new List<Plant>.from(data.map((i) => Plant.fromJson(i)));

    return plants;
  }

  Future<String> collect(token, tray_id, sector_id) async {
    var response = await http.get(
        Uri.parse("${Constants.BASE_URL}collect?token=$token&tray_id=$tray_id&sector_id=$sector_id"),
        headers: {"Accept": "application/json"});
    log(response.body);
    return response.body;
  }

  Future<int> traysCount(token) async {
    var response = await http.get(
        Uri.parse("${Constants.BASE_URL}trays_count?token=$token"),
        headers: {"Accept": "application/json"});
    log(response.body);
    return int.parse(response.body);
  }

  Future<String> addPlant(plantId, trayId, potId, token, timestamp) async {
    var response = await http.get(
        Uri.parse("${Constants.BASE_URL}add_plant?token=$token&plant_id=$plantId&tray_id=$trayId&sector_id=$potId&timestamp=$timestamp"),
        headers: {"Accept": "application/json"});
    log(response.body);
    return response.body;
  }


  Future<String> setLight(token, light, trayId) async {
    var response = await http.get(
        Uri.parse("${Constants.BASE_URL}set_light?token=$token&light=$light&tray_id=$trayId"),
        headers: {"Accept": "application/json"});
    log(response.body);
    return response.body;
  }

  Future<bool> light(token, trayId) async {
    var response = await http.get(
        Uri.parse("${Constants.BASE_URL}light?token=$token&tray_id=$trayId"),
        headers: {"Accept": "application/json"});
    return response.body.toLowerCase() == 'true';
  }

  Future<List<Job>> getJobs(token, trayId) async {
    var response = await http.get(Uri.parse("${Constants.BASE_URL}scheduled?token=$token&tray_id=$trayId"),
        headers: {"Accept": "application/json"});
    var data = json.decode(response.body);
    List<Job> jobs = new List<Job>.from(data.map((i) => Job.fromJson(i)));
    return jobs;
  }

  Future<String> addDeviceToken(token, deviceToken) async {
    var response = await http.get(Uri.parse("${Constants.BASE_URL}add_device_token?device_token=$deviceToken&token=$token"),
        headers: {"Accept": "application/json"});
    return response.body;
  }

  Future<String> sendMessage(deviceToken, message) async {
    var response = await http.get(Uri.parse("${Constants.BASE_URL}send_message?device_token=$deviceToken&message=$message"),
        headers: {"Accept": "application/json"});
     return response.body;
  }
}
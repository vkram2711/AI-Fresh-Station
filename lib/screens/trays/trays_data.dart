import 'package:ai_fresh_plant/models/models.dart';
import 'package:ai_fresh_plant/network/api.dart';


class TraysRepo {
//  TraysData traysData = TraysData();
  RestClient restClient = RestClient();

  Future<int> traysCount(String token) {
    //traysData.setState(newState)
    return restClient.traysCount(token);
  }

  Future<Token> auth(String login, password) {
    return restClient.auth(login, password);
  }
}



/*

  RestClient().auth("vlad", "1234").then((result) {
  setState(() {
  token = result.token;
  print(token);


  });
  });*/

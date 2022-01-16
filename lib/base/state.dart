import 'package:ai_fresh_plant/models/models.dart';

class BaseState<T>{
  static GlobalState _global = GlobalState();
  T state;

  static GlobalState get global => _global;

  static set global(GlobalState value) {
    _global = value;
  }

  BaseState(this.state);
}

class GlobalState{
  static String _token = null;
  static List<Plant> _plants = null;


  static List<Plant> get plants => _plants;

  static set plants(List<Plant> value) {
    _plants = value;
  }

  static String get token => _token;
  static set token(String val) => _token=val;



}

enum States{
  init
}
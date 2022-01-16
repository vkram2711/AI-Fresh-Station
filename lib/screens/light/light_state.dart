import 'package:ai_fresh_plant/base/state.dart';

class LightBlocState extends BaseState<LightStates>{
    bool light = false;
    int trayId;
    LightBlocState.init() : super(LightStates.init);
    LightBlocState.lightLoaded() : super(LightStates.lightLoaded);
    LightBlocState.lightOn() : super(LightStates.lightOn){
        light = true;
    }
    LightBlocState.lightOff() : super(LightStates.lightOff){
        light = false;
    }
}

enum LightStates{
  init, lightLoaded, lightOn, lightOff
}
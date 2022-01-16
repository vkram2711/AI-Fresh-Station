import 'package:ai_fresh_plant/base/action.dart';
import 'package:ai_fresh_plant/base/bloc.dart';
import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/screens/light/light_action.dart';
import 'package:ai_fresh_plant/screens/light/light_data.dart';

import '../../utils.dart';
import 'light_state.dart';

class LightBloc extends Bloc<LightBlocState, LightAction>{
  LightRepo repo = LightRepo();

  LightBloc() : super(() => LightBlocState.init());

  @override
  Future<void> mapEventToState(LightAction event) async {
      switch(event.action){
        case LightActionTypes.lightLoaded:
          state = LightBlocState.lightLoaded();
          break;
        case LightActionTypes.onAction:
          repo.setLight(GlobalState.token, true, state.trayId);
          state = LightBlocState.lightOn();
          break;
        case LightActionTypes.offAction:
          repo.setLight(GlobalState.token, false, state.trayId);
          state = LightBlocState.lightOff();
          break;
      }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> initEventToState() async {
    bool light = await repo.light(GlobalState.token, state.trayId);
    state.light = light;
    mapEventToState(LightAction.lightLoaded(light));
  }
}
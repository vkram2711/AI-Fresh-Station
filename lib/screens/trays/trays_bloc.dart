import 'dart:math';

import 'package:ai_fresh_plant/base/action.dart';
import 'package:ai_fresh_plant/base/bloc.dart';
import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/constants.dart';
import 'package:ai_fresh_plant/models/models.dart';
import 'package:ai_fresh_plant/screens/trays/trays_action.dart';
import 'package:ai_fresh_plant/screens/trays/trays_data.dart';
import 'package:ai_fresh_plant/screens/trays/trays_state.dart';


import '../../utils.dart';

class TraysBloc extends Bloc<TraysBlocState, TraysAction>{
  final TraysRepo repo = TraysRepo();

  TraysBloc() : super(() => TraysBlocState.init());

  @override
  Future<void> initEventToState() async {
    Token token = await repo.auth(Constants.login, Constants.password);
    state = TraysBlocState.authCompleted();
    GlobalState.token = token.token;
    mapEventToState(TraysAction.authComplete(token.token));
  }

  @override
  Future<void> mapEventToState(TraysAction event) async {
    switch(event.action){
      case TraysActionTypes.authComplete:
        int traysCount = await repo.traysCount(GlobalState.token);
        GlobalState global = BaseState.global;
        state = TraysBlocState.traysCountLoaded(traysCount);
        BaseState.global = global;
        mapEventToState(TraysAction.traysCountLoaded(traysCount));
        break;
      case TraysActionTypes.traysCountLoaded:
        break;
      case TraysActionTypes.traySelected:
        state = TraysBlocState.traySelected(event.selectedTrayId);
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}

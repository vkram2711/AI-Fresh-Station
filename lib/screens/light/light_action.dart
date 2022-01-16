import 'package:ai_fresh_plant/base/action.dart';

class LightAction extends Action<LightActionTypes>{
  bool _light = null;

  bool get light => _light;

  set light(bool value) {
    _light = value;
  }

  LightAction.lightLoaded(this._light) : super(LightActionTypes.lightLoaded);
  LightAction.onAction() : super(LightActionTypes.onAction){
    this._light = true;

  }

  LightAction.offAction() : super(LightActionTypes.offAction){
    this._light = false;
  }
}

/**
 * lightLoaded - called when app load from backend information about light state
 * onAction - user switch on light
 */
enum LightActionTypes{
  lightLoaded, onAction, offAction
}
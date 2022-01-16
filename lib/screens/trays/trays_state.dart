import 'package:ai_fresh_plant/base/state.dart';

class TraysBlocState extends BaseState<TraysStates>{
  int _traysCount = null;
  int _selectedTrayId = null;

  TraysBlocState.init() : super(TraysStates.init);
  TraysBlocState.authCompleted() : super(TraysStates.authCompleted);
  TraysBlocState.traysCountLoaded(this._traysCount) : super(TraysStates.traysCountLoaded);
  TraysBlocState.traySelected(this._selectedTrayId) : super(TraysStates.traySelected);


  int get selectedTrayId => _selectedTrayId;

  set selectedTrayId(int value) {
    _selectedTrayId = value;
  }

  int get traysCount => _traysCount;

  set traysCount(int value) {
    _traysCount = value;
  }
}

enum TraysStates{
  init, authCompleted, traysCountLoaded, traySelected
}

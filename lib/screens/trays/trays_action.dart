import 'package:ai_fresh_plant/base/action.dart';


/**
 * Actions at tray screen:
 *
 * authComplete - after login/pasword checking and receiving token
 * traysCountLoaded - called when app receive count of trays in station
 * traysSelected - called after selection of tray
 */
enum TraysActionTypes{
  authComplete, traysCountLoaded, traySelected
}

class TraysAction extends Action<TraysActionTypes>{
  String _token = null;
  int _traysCount = null;
  int _selectedTrayId = null;

  String get token => _token;
  int get traysCount => _traysCount;

  set token(String value) {
    _token = value;
  }

  set traysCount(int value) {
    _traysCount = value;
  }

  int get selectedTrayId => _selectedTrayId;

  set selectedTrayId(int value) {
    _selectedTrayId = value;
  }

  TraysAction.traySelected(this._selectedTrayId) : super(TraysActionTypes.traySelected);
  TraysAction.authComplete(this._token) : super(TraysActionTypes.authComplete);
  TraysAction.traysCountLoaded(this._traysCount) : super(TraysActionTypes.traysCountLoaded);

}


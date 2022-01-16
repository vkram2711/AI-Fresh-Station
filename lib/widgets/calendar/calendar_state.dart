import 'dart:collection';

import 'package:ai_fresh_plant/base/state.dart';

import 'calendar_utils.dart';

class CalendarState extends BaseState<CalendarStates>{
  static CalendarState _instance;
  Date focusedDate = Date.startDate();
  Date selectedDate = Date.startDate();
  HashMap<String, Pip> pips;

  CalendarState._({this.focusedDate, this.selectedDate, CalendarStates state, this.pips}) : super(state){
    _instance = this;
    focusedDate = focusedDate ?? Date.startDate();
 //   selectedDate = Date.startDate();
  }
  factory CalendarState.init(HashMap<String, Pip> pips) => CalendarState._(state: CalendarStates.weekMode, pips: pips);
  factory CalendarState.changeFocusedDate(Date focusedDate) => CalendarState._copyWith(state: null, focusedDate: focusedDate);
  factory CalendarState.weekMode() => CalendarState._copyWith(state: CalendarStates.weekMode);
  factory CalendarState.monthMode() => CalendarState._copyWith(state: CalendarStates.monthMode);
  factory CalendarState.dateSelected(Date selectedDate) => CalendarState._copyWith(state: null, selectedDate: selectedDate);

  factory CalendarState._copyWith({
    Date focusedDate,
    Date selectedDate,
    HashMap<String, Pip> pips,
    CalendarStates state
  }){
    return CalendarState._(
        state: state ?? _instance.state,
        focusedDate: focusedDate ?? _instance.focusedDate,
        selectedDate: selectedDate ?? _instance.selectedDate,
        pips: pips ?? _instance.pips
      );
  }
}

enum CalendarStates{
  weekMode, monthMode
}
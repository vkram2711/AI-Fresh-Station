import 'dart:collection';

import 'package:ai_fresh_plant/base/bloc.dart';
import 'package:ai_fresh_plant/widgets/calendar/calendar_action.dart';
import 'package:ai_fresh_plant/widgets/calendar/calendar_state.dart';

import 'calendar_utils.dart';

class CalendarBloc extends Bloc<CalendarState, CalendarAction> {
  CalendarBloc(HashMap<String, Pip> pips) : super(() => CalendarState.init(pips));

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> initEventToState() {
    // TODO: implement initEventToState
    mapEventToState(CalendarAction.inited());
  }

  @override
  Future<void> mapEventToState(CalendarAction event) {
    print(" focused date ${state.focusedDate.day}");
    switch(event.action){
      case CalendarActionTypes.inited:
        break;
      case CalendarActionTypes.modeChange:
        state = (CalendarStates.weekMode == state.state) ? CalendarState.monthMode() : CalendarState.weekMode();
        break;
      case CalendarActionTypes.dateSelect:
        state = CalendarState.dateSelected(event.selectedDate);
        break;
      case CalendarActionTypes.scrollRight:
        print("right");
        state = CalendarState.changeFocusedDate(state.state == CalendarStates.weekMode ? Date.nextWeek(state.focusedDate) : Date.nextMonth(state.focusedDate));
        break;
      case CalendarActionTypes.scrollLeft:
        print("left");
        state = CalendarState.changeFocusedDate(state.state == CalendarStates.weekMode ? Date.previousWeek(state.focusedDate) : Date.previousMonth(state.focusedDate));
        break;
    }
  }

}
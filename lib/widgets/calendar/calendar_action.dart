import 'package:ai_fresh_plant/base/action.dart';

import 'calendar_utils.dart';

class CalendarAction extends Action<CalendarActionTypes>{
  Date selectedDate;

  CalendarAction.modeChange() : super(CalendarActionTypes.modeChange);
  CalendarAction.scrollRight() : super(CalendarActionTypes.scrollRight);
  CalendarAction.scrollLeft() : super(CalendarActionTypes.scrollLeft);
  CalendarAction.dateSelect(this.selectedDate) : super(CalendarActionTypes.dateSelect);
  CalendarAction.inited() : super(CalendarActionTypes.inited);
}

enum CalendarActionTypes{
  inited, modeChange, scrollRight, scrollLeft, dateSelect
}
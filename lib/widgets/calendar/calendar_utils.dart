import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';

class Date {
  int day;
  int month;
  int year;
  int weekday;
  int timestamp;
  static Map daysInMonthCount;
  static final List<String> monthsShort= [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  static final List<String> months= [
    "JANUARY",
    "FEBRUARY",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUGUST",
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER"
  ];

  void initDaysInMonthCount(){
    daysInMonthCount = {"Jan": 31, "Feb": (year%4 == 0) ? 29 : 28, "Mar" : 31, "Apr": 30, "May": 31, "Jun": 30, "Jul": 31, "Aug": 31, "Sep": 30, "Oct": 31, "Nov": 30, "Dec": 31};
  }

  Date(this.day, this.month, this.year, this.weekday, this.timestamp){
    initDaysInMonthCount();
  }

  Date.fromDateTime(DateTime dateTime){
    this.day = dateTime.day;
    this.month = dateTime.month;
    this.year = dateTime.year;
    this.weekday = dateTime.weekday;
    this.timestamp = dateTime.millisecondsSinceEpoch;
    initDaysInMonthCount();

  }
  factory Date.startDate() => Date.fromDateTime(DateTime.now());

  static Date previousWeek(Date date) => goToDaysBefore(date, 7);
  static Date nextWeek(Date date) => goToDaysAfter(date, 7);

  static Date previousMonth(Date date)=> goToDaysBefore(date, daysInMonthCount[monthsShort[date.month - 1]]);
  static Date nextMonth(Date date)=> goToDaysAfter(date, daysInMonthCount[monthsShort[date.month - 1]]);


  static Date goToDaysAfter(Date date, int days){
    return addMilliseconds(date.timestamp + days*24*60*60*1000);
  }

  static Date goToDaysBefore(Date date, int days){
    return addMilliseconds(date.timestamp - days*24*60*60*1000);
  }

  static addMilliseconds(int milliseconds){
    return Date.fromDateTime(DateTime.fromMillisecondsSinceEpoch(milliseconds));
  }

  static List<Date> generateWeek(Date focusedDate){
    List<Date> dates = [];
    for(int i = 1; i < focusedDate.weekday; i++){
      dates.add(Date.goToDaysBefore(focusedDate, focusedDate.weekday-i));
    }

    dates.add(focusedDate);
    for(int i = focusedDate.weekday, j=1; i < 7; i++, j++) {
      dates.add(Date.goToDaysAfter(focusedDate,j));
    }
    return dates;
  }

  static List<Date> generateMonth(Date focusedDate){
    int daysInMonth = Date.daysInMonthCount[Date.monthsShort[focusedDate.month - 1]];
    List<Date> dates = [];
    for(int i = 1; i < focusedDate.day; i++){
      dates.add(Date.goToDaysBefore(focusedDate, focusedDate.day-i));
    }
    while(dates[0].weekday > 1){
      dates.insert(0, Date.goToDaysBefore(dates[0], 1));
    }

    dates.add(focusedDate);
    for(int i = focusedDate.day, j=1; i < daysInMonth; i++, j++) {
      dates.add(Date.goToDaysAfter(focusedDate,j));
    }

    while (dates[dates.length - 1].weekday < 7){
      dates.add(Date.goToDaysAfter(dates[dates.length - 1],1));
    }
    return dates;
  }
}

class Pip{
  Color color;

  Pip(this.color);
}
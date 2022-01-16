import 'dart:collection';

import 'package:ai_fresh_plant/models/models.dart';
import 'package:ai_fresh_plant/widgets/calendar/calendar_utils.dart';
import 'package:flutter/material.dart';

class SectorsUtils{
  static HashMap<String, Pip> predictFinishDate(List<Plant> plants, List<Sector> sectors){
    HashMap<String, Pip> pips = HashMap();

    print("sectors length: " + sectors.length.toString());
    for(int i = 0; i < sectors.length; i++){
      if(sectors[i].plant_id >= 0){
        Date date = Date.fromDateTime(DateTime.fromMillisecondsSinceEpoch((sectors[i].plant_timestamp + plants[sectors[i].plant_id].ripening_time*24*60*60)*1000));
        pips["${date.day} ${date.month} ${date.year}"] = Pip(Colors.green);
      }
    }

    return pips;
  }
}
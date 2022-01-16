import 'package:ai_fresh_plant/base/action.dart';
import 'package:ai_fresh_plant/models/models.dart';


class SectorsAction extends Action<SectorsActionTypes>{
  Sectors _sectors = null;
  Sector sector = null;
  List<Plant> _plants;
  int sectorId;
  DateTime date;
  List<Plant> get plants => _plants;
  List<Job> jobs;
  Job job;

  bool scheduled;
  set plants(List<Plant> value) {
    _plants = value;
  }

  Sectors get sectors => _sectors;

  set sectors(Sectors value) {
    _sectors = value;
  }

  SectorsAction.sectorSelected(this.sectorId, this.scheduled) : super(SectorsActionTypes.sectorSelected);
  SectorsAction.sectorsLoaded(this._sectors, this.jobs) : super(SectorsActionTypes.sectorsLoaded);
  SectorsAction.sectorCollected(this.sectorId) : super.out(SectorsActionTypes.sectorCollected);
  SectorsAction.sectorRequest() : super.out(SectorsActionTypes.sectorRequest);
  SectorsAction.sectorIdRequest() : super.out(SectorsActionTypes.sectorIdRequest);
  SectorsAction.addOpen(this.sectorId) : super(SectorsActionTypes.addOpen);
  SectorsAction.dateSelected(this.date) : super(SectorsActionTypes.dateSelected);
  SectorsAction.addJob(this.job) : super(SectorsActionTypes.addJob);
}

/**
 * Actions at sectors(pots) screen:
 *
 * sectorSelected - called when user tap on one of the sectors
 * sectorsLoaded - called when app download sectors data and ready for show
 * sectorsCollected - called when user collect harvest from pot
 * sectorRequest - external request asking sector information
 * sectorIdRequest - external request asking id of sector
 * addOpen - called when user tap on add plant button
 * dateSelected - called when user change date on calendar
 * addSector - called when user add new plant
 */
enum SectorsActionTypes{
   sectorSelected, sectorsLoaded, sectorCollected, sectorRequest, sectorIdRequest, addOpen, dateSelected, addJob
}
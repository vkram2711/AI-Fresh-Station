import 'package:ai_fresh_plant/base/action.dart';
import 'package:ai_fresh_plant/models/models.dart';

class InfoAction extends Action<InfoActionsTypes>{
  int collectedId;
  Sector sector;
  Tray tray;

  InfoAction.collect(this.collectedId) : super(InfoActionsTypes.collect);
  InfoAction.sectorReceived(this.sector, this.tray) : super(InfoActionsTypes.sectorReceived);
}

enum InfoActionsTypes {
  collect, sectorReceived
}
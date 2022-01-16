import 'package:ai_fresh_plant/base/state.dart';
import 'package:ai_fresh_plant/models/models.dart';

class SectorsBlocState extends BaseState<SectorStates> {
  static SectorsBlocState _instance;

  Sectors sectors;
  DateTime date = DateTime.now();
  int trayId = 0; //TODO: receive trayId
  int selectedId;
  bool scheduled;
  List<Job> jobs;

  SectorsBlocState._({
    this.sectors,
    this.trayId,
    this.selectedId,
    this.date,
    this.jobs,
    this.scheduled,
    SectorStates state
  }) : super(state){
    date = date ?? DateTime.now();
    _instance = this;
  }

  factory SectorsBlocState.init(int trayId) => SectorsBlocState._(state: SectorStates.init, trayId: trayId);
  factory SectorsBlocState.sectorsLoaded(Sectors sectors, List<Job> jobs) => SectorsBlocState._copyWith(state: SectorStates.sectorsOpened, sectors: sectors, jobs: jobs);
  factory SectorsBlocState.infoOpened(int selectedId, bool scheduled) => SectorsBlocState._copyWith(state: SectorStates.infoOpened, selectedId: selectedId, scheduled: scheduled);
  factory SectorsBlocState.addOpened(int selectedId) => SectorsBlocState._copyWith(state: SectorStates.addOpened, selectedId: selectedId);
  factory SectorsBlocState.sectorCollected(int selectedId) => SectorsBlocState._copyWith(state: SectorStates.sectorsOpened, selectedId: selectedId);
  factory SectorsBlocState.dateSelected(DateTime date) => SectorsBlocState._copyWith(state: SectorStates.sectorsOpened, date: date);
  factory SectorsBlocState.jobAdded() =>  SectorsBlocState._copyWith(state: SectorStates.sectorsOpened);

  factory SectorsBlocState._copyWith({
    Sectors sectors,
    int trayId,
    int selectedId,
    DateTime date,
    List<Job> jobs,
    bool scheduled,
    SectorStates state
  }){
    return SectorsBlocState._(
        state: state ?? _instance.state,

        jobs: jobs ?? _instance.jobs,
        sectors: sectors ?? _instance.sectors,
        trayId: trayId ?? _instance.trayId,
        selectedId: selectedId ?? _instance.selectedId,
        scheduled: scheduled ?? _instance.scheduled,
        date: date ?? _instance.date);
  }
}

enum SectorStates{
  init, sectorsOpened, addOpened, infoOpened
}

import 'package:ai_fresh_plant/generated/i18n.dart' as Res;
import 'package:ai_fresh_plant/models/models.dart';
import 'package:ai_fresh_plant/notifications.dart';
import 'package:ai_fresh_plant/screens/info/info_action.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_bloc.dart';
import 'package:ai_fresh_plant/screens/sectors/widgets/sectors_widget.dart';
import 'package:ai_fresh_plant/widgets/plant_progress_bar.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../../utils.dart';
import '../info_bloc.dart';

TextStyle infoStyle = FontManager.sfProText(
    size: 14,
    color: HexColor.fromHex("#cdcdcd"));

class VitaminsText extends StatelessWidget{
  final String text;
  VitaminsText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 14),
        child: Text(text, style: infoStyle,)
    );
  }
}

class ScheduledPlantInfoImageWithProgressBar extends StatelessWidget{
  final double progress;
  final int timestamp;

  ScheduledPlantInfoImageWithProgressBar(this.progress, this.timestamp);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var formattedDate = formatDate(date, [dd, '.' , mm]);
    return Stack(children: <Widget>[
      Opacity(opacity: 0.35, child: PlantImageWithProgressBar(progress)),
      Container(color: Colors.black38,),
      Padding(padding: EdgeInsets.only(bottom: 16), child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ Center(child: Text(formattedDate, style: dateStyle))]))
    ]);
  }
}


class InfoTable extends StatelessWidget{
  final Sector _sector;
  final Tray _tray;

  Sector get sector => _sector;
  Tray get tray => _tray;

  final TextStyle keyFont = TextStyle(fontFamily: "SF Pro Text", fontSize: 16 , color: HexColor.fromHex("#a5a4a4"));
  final TextStyle valueFont = TextStyle(fontFamily: "SF Pro Text", fontSize: 17, color: HexColor.fromHex("#595959"));

  InfoTable(this._sector, this._tray);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
           Padding(padding: EdgeInsets.only(top: 6), child: Text(Res.S.of(context).humidity, style: keyFont, textAlign: TextAlign.left,)),
           Padding(padding: EdgeInsets.only(top: 6), child: Text(Res.S.of(context).temperature, style: keyFont, textAlign: TextAlign.left,)),
           Padding(padding: EdgeInsets.only(top: 6), child: Text(Res.S.of(context).light, style: keyFont, textAlign: TextAlign.left,)),
           Padding(padding: EdgeInsets.only(top: 6), child: Text(Res.S.of(context).healthStatus, style: keyFont, textAlign: TextAlign.left,)),
        ],)),
        Expanded(flex:1, child:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
           Padding(padding: EdgeInsets.only(top: 6), child: Text(Res.S.of(context).percent(sector.humidity), style: valueFont, textAlign: TextAlign.left,)),
           Padding(padding: EdgeInsets.only(top: 6), child: Text(Res.S.of(context).F(tray.temperature), style: valueFont, textAlign: TextAlign.left,)),
           Padding(padding: EdgeInsets.only(top: 6), child: Text(Res.S.of(context).lux(tray.light), style: valueFont, textAlign: TextAlign.left,)),
           Padding(padding: EdgeInsets.only(top: 6), child: Text("OK", style: valueFont, textAlign: TextAlign.left,)),
        ],))
      ],
    );
  }
}

class HarvestButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<InfoBloc<SectorBloc>>(context, listen: false);
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0),),
      color: HexColor.fromHex("#fdaa7c"),
      child: Text('HARVEST', style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: "SF Pro Text"),),
      onPressed: () {
        bloc.mapEventToState(InfoAction.collect(bloc.state.sector.id));
      },
    );
  }
}

class VitaminAndMineral extends StatelessWidget{
  final Color color;
  final String text;

  VitaminAndMineral(this.color, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(padding: EdgeInsets.all(8),child: Text(
        text,
        style: FontManager.sfProText(size: 14, color: Colors.white, weight: FontWeight.w500)
      )),
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class VitaminItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 16, bottom: 15),child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Vitamin C", style: FontManager.sfProText(size: 15, color: HexColor.fromHex("787878")),),
        LinearProgressIndicator(value: 0.27, valueColor:  AlwaysStoppedAnimation<Color>(ColorsRes.orangeAccent), backgroundColor: ColorsRes.whiteDark,),
        Text(Res.S.of(context).grams(27), style: FontManager.sfProText(size: 12, color: HexColor.fromHex("B1B1B1")),)
    ],));
  }
}

class Tab extends StatelessWidget{
  final String text;
  final bool selected;
  final PageController controller;

  Tab(this.text, this.selected, this.controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
            onTap: (){controller.animateToPage(controller.page.toInt() + 1 != 1 ? controller.page + 1 : 0, duration: Duration(milliseconds: 600), curve: Curves.ease);},
            child: Text(
              text,
              style: FontManager.sfProDisplay(size: 15, color: selected? ColorsRes.green : ColorsRes.greyDark2 ),
              textAlign: TextAlign.center,)
        )
    );
  }
}

class TabsState extends State<Tabs>{
  int page = 1;

  @override
  Widget build(BuildContext context) {
    widget.pageController.addListener(() {
      page = widget.pageController.page.toInt();
      setState(() {});
    });
    return Row(
      children: [
        Tab(Res.S.of(context).aboutPlant, page == 0, widget.pageController),
        Tab(Res.S.of(context).vitaminsAndMinerals, page == 1, widget.pageController),
      ],
    );
  }
}

class Tabs extends StatefulWidget {
  final PageController pageController;

  Tabs(this.pageController);

  @override
  State<StatefulWidget> createState() => TabsState();
}
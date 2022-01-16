import 'package:ai_fresh_plant/generated/i18n.dart';
import 'package:ai_fresh_plant/screens/sectors/sectors_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../add_action.dart';
import '../add_bloc.dart';

class SubmitButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<AddBloc<SectorBloc>>(context, listen: false);

    return Row(
      children: <Widget>[
        BackButton(),
        BaseButton(S.of(context).submit, () {
          bloc.mapEventToState(AddAction.submit());
        })
      ],
    );
  }
}

class BaseButton extends StatelessWidget{
  final String title;
  final VoidCallback onPressed;

  BaseButton(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Column(
          children: <Widget>[
            FlatButton(
              height: 48,

              color: HexColor.fromHex("#fdaa7c"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: HexColor.fromHex("#fdaa7c")),
              ),
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: onPressed,
            )
          ],
        ));
  }
}
void _scrollPage(AddBloc bloc) {
  print("scroll page ${bloc.state.controller} ${bloc.state.currentPage}");
  bloc.state.controller.animateToPage(bloc.state.currentPage,
      duration: Duration(milliseconds: 200), curve: Curves.easeInQuart);
}

class BackButton extends StatelessWidget{

  @override 
  Widget build(BuildContext context) {
    var bloc = Provider.of<AddBloc<SectorBloc>>(context, listen: false);
    return BaseButton(S.of(context).back, () {
      bloc.mapEventToState(AddAction.back());
      _scrollPage(bloc);
    });
  }
}

class NextButton extends StatelessWidget{
  final bool showBack;
  NextButton(this.showBack);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<AddBloc<SectorBloc>>(context, listen: false);
    return Row(
      children: <Widget>[
        showBack ? BackButton() : Container(),
        BaseButton(S.of(context).next, () {
          bloc.mapEventToState(AddAction.next());
          _scrollPage(bloc);
        })
      ],
    );
  }
}
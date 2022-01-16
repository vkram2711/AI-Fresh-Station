
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class ColorsRes {
  static final Color greyDark = HexColor.fromHex("555555");
  static final Color grey = HexColor.fromHex("A5A4A4");
  static final Color greyLight = HexColor.fromHex("#c1c1c1");
  static final Color blackLight = HexColor.fromHex("555555");
  static final Color orangeAccent = HexColor.fromHex("FDAA7C");
  static final Color greenDark = HexColor.fromHex("79C38A");
  static final Color green = HexColor.fromHex("56CC9A");
  static final Color whiteDark = HexColor.fromHex("FBFBFB");
  static final Color greyDark2 = HexColor.fromHex("828181");
}
/*
class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static final double PERFECT_HEIGHT = 568;  //Height gained from Pixel XL 1440x2560
  static final double PERFECT_WIDTH = 360;   //Width gained from Pixel XL 1440x2560

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal)/100;
    safeBlockVertical = (screenHeight - _safeAreaVertical)/100;

    print(
        "Screen size: $screenWidth x $screenHeight"
        "block size horizontal x vertical: $blockSizeHorizontal x $blockSizeVertical"
        "safe block size horizontal x vertical: $safeBlockHorizontal x $safeBlockVertical"
    );
  }
}*/

class BlocStream<T> {

  final StreamController<T> _streamController = StreamController.broadcast();

  Stream<T> get stream => _streamController.stream;

  set eventOut(T data) {
    _streamController.add(data);
  }
}


typedef StreamBuilderListener<T> = void Function(T data);

class StreamBuilderWithListener<T> extends StreamBuilder<T> {
  //by Eugene Brusov https://stackoverflow.com/questions/54101589/navigating-to-a-new-screen-when-stream-value-in-bloc-changes
  final StreamBuilderListener<T> listener;

  const StreamBuilderWithListener({
    Key key,
    T initialData,
    Stream<T> stream,
    @required this.listener,
    @required AsyncWidgetBuilder<T> builder,
  }) : super(
      key: key,
      initialData: initialData,
      stream: stream,
      builder: builder);

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    listener(data);
    return super.afterData(current, data);
  }
}

class FontManager{
  static TextStyle sfProText({double size, Color color = Colors.black, FontWeight weight = FontWeight.normal}){
    return TextStyle(
        fontFamily: Constants.fontProText,
        color: color,
        fontSize: size,
        fontWeight: weight
    );
  }

  static TextStyle sfProDisplay({double size, Color color = Colors.black}){
    return TextStyle(
        fontFamily: Constants.fontProDisplay,
        color: color,
        fontSize: size
    );
  }
}
/*
class FontSizes {
  static s11() => DefaultVerticalPixelsSizes.px11();
  static s12() => DefaultVerticalPixelsSizes.px12();
  static s14() => DefaultVerticalPixelsSizes.px14();
  static s16() => DefaultVerticalPixelsSizes.px16();
  static s17() => DefaultVerticalPixelsSizes.px17();
  static s18() => DefaultVerticalPixelsSizes.px18();
  static s20() => DefaultVerticalPixelsSizes.px20();
  static s21() => DefaultVerticalPixelsSizes.px21();
  static s22() => DefaultVerticalPixelsSizes.px22();
}

class DefaultVerticalPixelsSizes {
  static px4() => makeVerticalResponsible(4);
  static px6() => makeVerticalResponsible(6);
  static px8() => makeVerticalResponsible(8);
  static px11() => makeVerticalResponsible(11);
  static px12() => makeVerticalResponsible(12);
  static px14() => makeVerticalResponsible(14);
  static px16() => makeVerticalResponsible(16);
  static px17() => makeVerticalResponsible(17);
  static px18() => makeVerticalResponsible(18);
  static px20() => makeVerticalResponsible(20);
  static px21() => makeVerticalResponsible(21);
  static px22() => makeVerticalResponsible(22);
  static px24() => makeVerticalResponsible(24);

}

class DefaultHorizontalPixelsSizes {
  static px4() => makeHorizontalResponsible(4);
  static px8() => makeHorizontalResponsible(8);
  static px16() => makeHorizontalResponsible(16);
}*/

double boundProgress(double progress){
  if(progress > 100 ) return 100.0;
  if(progress < 0) return 0.0;
  return progress;
}

/*
double makeVerticalResponsible(double value){
  return SizeConfig.safeBlockVertical * (value/SizeConfig.PERFECT_HEIGHT*100);
}

double makeHorizontalResponsible(double value) {
  return SizeConfig.safeBlockHorizontal * (value/SizeConfig.PERFECT_WIDTH*100);
}
*/
Future<Image> svgToImage(String asset) async {
  final String rawSvg = await rootBundle.loadString(asset);
  final DrawableRoot svgRoot = await svg.fromSvgString(rawSvg, rawSvg);

  final Picture picture = svgRoot.toPicture();
  final Image image = (await picture.toImage(32, 32)) as Image;
  print("inside svg func $image");
  return image;
}


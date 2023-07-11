import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

mixin AppImages {
  static const runeBg = AssetImage('assets/images/rune_bg.jpg');
  static const chmapBg = AssetImage('assets/images/champ_bg.jpg');
  static const itemBg = AssetImage('assets/images/item_bg.png');
  static const appIcon = AssetImage('assets/images/league.png');
  static const leagueLogo = AssetImage('assets/images/lol_logo.webp');
  static const splashImg = AssetImage('assets/images/splash.webp');
  static const homeBackground = AssetImage('assets/images/background.jpg');
  static const caitChamp = AssetImage('assets/images/champion_cait.png');
  static const redRune = AssetImage('assets/images/rune_red.png');
  static const prawler = AssetImage('assets/images/item_prawler.png');

  static AssetImage itemImage(String name) => AssetImage('assets/images/items/$name.png');
  static AssetImage itemImageWithFullName(String name) => AssetImage('assets/images/items/$name');

  // static SvgPicture appTextIcon = SvgPicture.asset(
  //   'assets/images/league.svg',
  //   semanticsLabel: 'League of Legends',
  //   height: 50,
  //   width: 50,
  // );
}

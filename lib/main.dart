import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'screens/sign_up_screen.dart';

FirebaseAnalytics? analytics;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  analytics = FirebaseAnalytics();
  runApp(MyApp());
}

class RemoveGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

final NeumorphicThemeData lightTheme = NeumorphicThemeData(
        baseColor: CustomColors.bg,
        accentColor: CustomColors.bodyText,
        shadowDarkColor: CustomColors.darkShadow,
        shadowLightColor: CustomColors.lightShadow,
        shadowDarkColorEmboss: CustomColors.darkShadow,
        shadowLightColorEmboss: CustomColors.lightShadow,
        defaultTextColor: CustomColors.headerText,
        variantColor: CustomColors.bodyText,
        lightSource: LightSource.topLeft,
        depth: 10,
      );

final NeumorphicThemeData darkTheme = NeumorphicThemeData(
        baseColor: CustomColors.nightBG,
        accentColor: CustomColors.nightBodyText,
        shadowDarkColor: CustomColors.nightDarkShadow,
        shadowLightColor: CustomColors.nightLightShadow,
        shadowDarkColorEmboss: CustomColors.nightDarkShadow,
        shadowLightColorEmboss: CustomColors.nightLightShadow,
        defaultTextColor: CustomColors.nightHeaderText,
        variantColor: CustomColors.nightBodyText,
        lightSource: LightSource.topLeft,
        depth: 10,
      );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'QuoteNote',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: RemoveGlow(),
          child: child!,
        );
      },
      theme: lightTheme,
      darkTheme: darkTheme,
      home: SignUpScreen(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  disabledColor: CustomColors.primary,
  baseColor: CustomColors.bg,
  accentColor: CustomColors.bodyText,
  shadowDarkColor: CustomColors.darkShadow,
  shadowLightColor: CustomColors.lightShadow,
  shadowDarkColorEmboss: CustomColors.darkShadow,
  shadowLightColorEmboss: CustomColors.lightShadow,
  defaultTextColor: CustomColors.headerText,
  variantColor: CustomColors.bodyText,
  lightSource: LightSource.topLeft,
  depth: 5,
  intensity: 1,
);

final NeumorphicThemeData darkTheme = NeumorphicThemeData(
  disabledColor: CustomColors.nightPrimary,
  baseColor: CustomColors.nightBG,
  accentColor: CustomColors.nightBodyText,
  shadowDarkColor: CustomColors.nightDarkShadow,
  shadowLightColor: CustomColors.nightLightShadow,
  shadowDarkColorEmboss: CustomColors.nightDarkShadow,
  shadowLightColorEmboss: CustomColors.nightLightShadow,
  defaultTextColor: CustomColors.nightHeaderText,
  variantColor: CustomColors.nightBodyText,
  lightSource: LightSource.topLeft,
  depth: 5,
  intensity: 1,
);

ThemeMode theme = ThemeMode.light;

class MyApp extends StatelessWidget {
  void getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('darkMode') != null) {
      theme = prefs.getBool('darkMode')! ? ThemeMode.dark : ThemeMode.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: getTheme,
      child: NeumorphicApp(
        title: 'QuoteNote',
        debugShowCheckedModeBanner: false,
        themeMode: theme,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: RemoveGlow(),
            child: child!,
          );
        },
        theme: lightTheme,
        darkTheme: darkTheme,
        home: SignUpScreen(),
      ),
    );
  }
}

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({required this.onInit, required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

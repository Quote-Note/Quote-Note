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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'QuoteNote',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: RemoveGlow(),
          child: child!,
        );
      },
      theme: NeumorphicThemeData(
        baseColor: CustomColors.white,
        accentColor: CustomColors.lightGrey,
        shadowDarkColor: CustomColors.darkShadow,
        shadowLightColor: CustomColors.lightShadow,
        shadowDarkColorEmboss: CustomColors.darkShadow,
        shadowLightColorEmboss: CustomColors.lightShadow,
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: SignInScreen(),
    );
  }
}

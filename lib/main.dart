import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'auth.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

FirebaseAnalytics analytics;

void main() {
  //Crashlytics.instance.enableInDevMode = true; // turn this off after seeing reports in in the console.
  //FlutterError.onError = Crashlytics.instance.recordFlutterError;

  analytics = FirebaseAnalytics();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterBase',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Flutterbase'),
              backgroundColor: Colors.amber,
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  LoginButton(), // <-- Built with StreamBuilder
                  UserProfile() // <-- Built with StatefulWidget
                ],
              ),
            )));
  }
}

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    authService.profile.listen((state) => setState(() => _profile = state));

    authService.loading.listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(padding: EdgeInsets.all(20), child: Text(_profile.toString())),
      Text(_loading.toString())
    ]);
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialButton(
              onPressed: () => authService.signOut(),
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Signout'),
            );
          } else {
            return MaterialButton(
              onPressed: () => authService.googleSignIn(),
              color: Colors.white,
              textColor: Colors.black,
              child: Text('Login with Google'),
            );
          }
        });
  }
}

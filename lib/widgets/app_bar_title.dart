import 'package:flutter/material.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/screens/sign_up_screen.dart';
import 'package:notes_app/utils/auth.dart';

class AppBarTitle extends StatefulWidget {
  final String photoUrl;
  final String name;

  const AppBarTitle({required this.photoUrl, required this.name});

  @override
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {

  bool isAdmin = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  
  void toggleAdmin(){
    setState(() {
      isAdmin = !isAdmin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Neumorphic(
          style: NeumorphicStyle(
            depth: -1,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: Material(
              color: CustomColors.lightShadow.withOpacity(0.3),
              child: Image.network(
                widget.photoUrl,
                scale: 2,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Text(
          widget.name,
          style: TextStyle(
            color: CustomColors.darkGrey,
          )
        ),
        NeumorphicButton(
          onPressed: toggleAdmin,
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: isAdmin ? Icon(Icons.star, color: CustomColors.yellow) : Icon(Icons.star_border_outlined, color: CustomColors.darkGrey),
          ),
        ),
        NeumorphicButton(
          onPressed: () async {
                        setState(() {
                        });
                        await Authentication.signOut(context: context);
                        setState(() {
                        });
                        Navigator.of(context)
                            .pushReplacement(_routeToSignInScreen());
                      },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: Material(
              color: CustomColors.lightShadow.withOpacity(0.3),
              child: Icon(Icons.logout, color: CustomColors.primary,),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/screens/notes_screen.dart';
import 'package:notes_app/widgets/app_bars/app_bar_note.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:timeago/timeago.dart' as timeago;


class ExpandedNote extends StatelessWidget {
  final Note note;
  const ExpandedNote({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: CustomColors.white,
          title: AppBarNote(note: note),
        ),
      ),
      bottomNavigationBar: AppBarBottom(
        buttons: [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Neumorphic(
                  style: NeumorphicStyle(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
                    depth: 4,
                    intensity: 1,
                  ),
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: CustomColors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  note.title,
                                  style: TextStyle(
                                    color: CustomColors.darkGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      note.author,
                                      style: TextStyle(
                                        color: CustomColors.lightGrey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        '• ${timeago.format(note.timestamp, locale: 'en_short')}',
                                        style: TextStyle(
                                          color: CustomColors.lightGrey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  note.note,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  style: TextStyle(
                                      color: CustomColors.darkGrey,
                                      height: 1.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: CustomColors.primary,
                          ),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/dummy_image.jpg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

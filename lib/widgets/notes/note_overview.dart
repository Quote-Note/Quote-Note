import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicNoteOverview extends StatefulWidget {
  final String title;
  final int numberOfNotes;
  final List<String> notes;

  const NeumorphicNoteOverview(
      {Key? key,
      required this.title,
      required this.numberOfNotes,
      required this.notes,})
      : super(key: key);

  @override
  _NeumorphicNoteOverviewState createState() => _NeumorphicNoteOverviewState();
}

class _NeumorphicNoteOverviewState extends State<NeumorphicNoteOverview> {
  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return SizedBox(
                height: 174,
                width: 343,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                    depth: 4,
                    intensity: 1,
                  ),
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: theme.defaultTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.numberOfNotes,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  widget.notes[index],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: theme.variantColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWidget extends StatelessWidget {
  SlidableWidget({
    super.key,
    required this.child,
    required this.onDismissed,
  });

  final Widget child;
  final Function() onDismissed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(
          onDismissed: onDismissed,
        ),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (c) {
              log("Delete action");
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          // SlidableAction(
          //   onPressed: (c) {
          //     log("Share action");
          //   },
          //   backgroundColor: Color(0xFF21B7CA),
          //   foregroundColor: Colors.white,
          //   icon: Icons.share,
          //   label: 'Share',
          // ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      // endActionPane: ActionPane(
      //   motion: ScrollMotion(),
      //   children: [
      // SlidableAction(
      //   // An action can be bigger than the others.
      //   flex: 2,
      //   onPressed: (c) {
      //     log("Archieve action");
      //   },
      //   backgroundColor: Color(0xFF7BC043),
      //   foregroundColor: Colors.white,
      //   icon: Icons.archive,
      //   label: 'Archive',
      // ),
      // SlidableAction(
      //   onPressed: (c) {
      //     log('save action');
      //   },
      //   backgroundColor: Color(0xFF0392CF),
      //   foregroundColor: Colors.white,
      //   icon: Icons.save,
      //   label: 'Save',
      // ),
      //   ],
      // ),
      child: child,
    );
  }
}

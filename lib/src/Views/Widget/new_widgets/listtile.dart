import 'package:flutter/material.dart';

class Expandedtile extends StatefulWidget {
  final String title;
  final List<Widget> widgetcustom;

  const Expandedtile({
    super.key,
    required this.title,
    required this.widgetcustom,
  });

  @override
  State<Expandedtile> createState() => _ListtileState();
}

class _ListtileState extends State<Expandedtile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style:const TextStyle(color:  Colors.white),
        ),
        trailing: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: -2,
                right: 0,
                top: -2,
                bottom: 0,
                child: Icon(
                  _customTileExpanded
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                ),
              ),
            ],
          ),
        ),
        children: widget.widgetcustom,
        onExpansionChanged: (bool expanded) {
          setState(() {
            _customTileExpanded = expanded;
          });
        },
      ),
    );
  }
}


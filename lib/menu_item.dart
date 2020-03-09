import 'package:flutter/material.dart';
import './style.dart';

class MenuItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final int index;
  final void Function(int) function;

  MenuItem(
      {this.name,
      this.icon,
      this.isSelected,
      this.color,
      this.function,
      this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          right: 35.0,
        ),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: isSelected ? color : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 30.0),
            Icon(
              this.icon,
              color: this.isSelected ? Colors.white : Colors.grey[600],
            ),
            SizedBox(width: 15.0),
            Text(
              name,
              style: isSelected
                  ? Style.menuItemSelected
                  : Style.menuItemUnSelected,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      onTap: () => function(index),
    );
  }
}
